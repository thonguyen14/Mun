thực hiện trên vps đã cài đặt mun thành công
# cài đặt phần phụ
```
sudo apt update
sudo apt install -y make gcc jq curl git
```
```
mkdir $HOME/.mun2
cp /root/go/bin/mund /root/go/bin/mun2d

cd .mun2

mun2d config chain-id testmun --home $HOME/.mun2
mun2d init to-the-sun --chain-id testmun -o --home $HOME/.mun2
```
# cài đặt ví 
```
mun2d keys add sun --keyring-backend test --home $HOME/.mun2
#hoặc add ví cũ
mun2d keys add sun --keyring-backend test --recover --home $HOME/.mun2
```
```
#check
mun2d keys list --keyring-backend test --home $HOME/.mun2
```
# tải genesis và add peer
```
curl --tlsv1 https://node1.mun.money/genesis? | jq ".result.genesis" > ~/.mun2/config/genesis.json
sha256sum $HOME/.mun2/config/genesis.json # a558d6c06bd1744458aa2dd4b2da4dd014fcbe0de8de13d40a96d46f46067e84
```
```
sed -i 's/stake/utmun/g' ~/.mun2/config/genesis.json
sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.0001utmun"|g' $HOME/.mun2/config/app.toml
seeds="b4eeaf7ca17e5186b181885714cedc6a78d20c9b@167.99.6.48:26656"
peers="7d4faf640eadec80b12da14e1739b9990538022f@212.227.151.155:26656,6681ac84384e28c6ecc00649ccdd87373797c203@38.242.150.136:26656,4f92d2072813a1c3e27ea929cd454bf27f2b746b@167.99.6.48:26656,31f77ca4df645c86d4586e7e50ed34e28dfbff6c@38.242.149.184:26656,6a08f2f76baed249d3e3c666aaef5884e4b1005c@167.71.0.38:26656,cf19651c969345b56b999d029a319cc1f1f4e032@65.108.229.225:56656,c27ac74e7f1ba7f2a2c659486d4b58ecd08b0326@34.66.157.37:26656,81533ad30607f636373dfd85747848b7331f5d32@95.216.32.172:26656,dc1a7c6ca2cd03ee8d740eb3d3a329cb036aeda5@117.78.1.136:26656,cf5b23fc9ed55385d062bc7c559371da8f250714@178.18.251.58:26656"
sed -i -e 's|^seeds *=.*|seeds = "'$seeds'"|; s|^persistent_peers *=.*|persistent_peers = "'$peers'"|' $HOME/.mun2/config/config.toml
sed -i.bak -e "s/^pruning *=.*/pruning = \""nothing"\"/" ~/.mun2/config/app.toml
```
# tạo systemd
```
sudo tee /etc/systemd/system/mun2d.service > /dev/null << EOF
[Unit]
Description=Mun2 Node 
After=network.target

[Service]
User=root
Type=simple
ExecStart=/root/go/bin/mun2d start --home $HOME/.mun2/
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```
```
sudo systemctl daemon-reload
sudo systemctl enable mun2d
```
# snapshot
```
sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1false|" ~/.mun2/config/config.toml
sudo systemctl stop mun2d
rm -rf /root/.mun2/data
mun2d tendermint unsafe-reset-all --home ~/.mun2/
curl -o - -L http://18.116.24.245:1234/mun/2022-11-05.tar.lz4 | lz4 -c -d - | tar -x -C $HOME/.mun2
sudo systemctl restart mun2d
sudo journalctl -u mun2d -f -o cat
```
