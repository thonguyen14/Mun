 DO NOT UPGRADE BEFORE CHAIN REACHES THE BLOCK 560700

AUTOMATIC UPGRADE

run inside a tmux session

install tmux if you dont have it on your server
```
apt install tmux
```
```
tmux new -t munupgrade
```
then run this inside the tmux session you opened

```
wget -O upgrade.sh https://raw.githubusercontent.com/thonguyen14/Mun/main/upgrade/upgrade.sh && chmod +x upgrade.sh && ./upgrade.sh
```

you are now ready for upgrade!

![image](https://user-images.githubusercontent.com/80441573/198813828-dad56226-12d2-4f95-87e7-69fff337341d.png)

you can monitor it too to check how much blocks left for the upgrade

```
tmux ls
```
this will show you all your active sessions, then attach the one you want to check

```
tmux attach -t munupgrade
```

to exit a tmux session use CTRL+b then press d
