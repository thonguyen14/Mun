# 1. Chạy cài đặt fullnode trên máy mới  --> guide :https://github.com/munblockchain/mun
# 2. Chắc chắn rằng bạn có seed phrase của wallet đang chạy trên máy cũ
##To backup your key
```
mund keys list
```
# 3.Di chuyển wallet từ máy cũ sang máy mới

##thực hiện với mnemonics
```
mund keys add <Wallet-name> --recover
```
# 4. chờ cho full node trên máy mới sync hoàn toàn 
 ##kiểm tra trạng thái sync
```
mund status 2>&1 | jq .SyncInfo
```
> _`catching_up` = `false`_
# 5.Sau khi fullnode trên máy mới đã sync xong , dừng validator node trên máy cũ
```
sudo systemctl stop mund
sudo systemctl disable mund
```
> validator sẽ bắt đầu thiếu khối từ đây _
# 6. Stop fullnode trên máy mới 
```
sudo systemctl stop mund
```
# 7.Di chuyển  validator private key từ máy cũ sang máy mới
##Private key nằm trong link file : `~/.mund/config/priv_validator_key.json`
> sau khi được sao chép , priv_validator_key.json sẽ được xóa khỏi config của node cũ để ngăn việc ký 2 lần (double-signing) nếu node mới bắt đầu sao lưu 
# 8. Start service trên máy mới
```
sudo systemctl start mund
```
>Node mới sẽ bắt đầu ký khối sau khi bắt kịp
# 9.Đảm bảo validator của bạn ko bị jailed
##để hủy bỏ việc jailed
```
mund tx slashing unjail --broadcast-mode=block --from=<Wallet-name> --keyring-backend test --chain-id=testmun --node="http://127.0.0.1:36657" --gas=auto --gas-adjustment=1.5 -y
```

# 10. sau khi đảm bảo validator mới đang hoạt động và ký khối tốt , bạn xóa hoàn toàn node trên máy cũ
