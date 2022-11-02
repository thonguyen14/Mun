#!/bin/bash
GREEN_COLOR='\033[0;32m'
RED_COLOR='\033[0;31m'
NO_COLOR='\033[0m'
BLOCK=560700
VERSION=2.0.0
echo -e "$GREEN_COLOR YOUR NODE WILL BE UPDATED TO VERSION: $VERSION ON BLOCK NUMBER: $BLOCK $NO_COLOR\n"
for((;;)); do
	height=$(mund status --node="http://127.0.0.1:36657" |& jq -r ."SyncInfo"."latest_block_height")
	if ((height>=$BLOCK)); then

		sudo systemctl stop mund
		cd $HOME
    rm -rf mun
		git clone https://github.com/munblockchain/mun.git
		cd $HOME/mun && make install
    mund version
    sudo rm -rf /var/log/mund/
    cd $HOME/mun && make log-files
    echo "=============Preparing binary upgrades============="
    cd $HOME/.mun/upgrade_manager/upgrades && mkdir mun-upgrade-v2 && cd mun-upgrade-v2 && mkdir bin
    cp $HOME/go/bin/mund $HOME/.mun/upgrade_manager/upgrades/mun-upgrade-v2/bin/
    echo "=============Upgrading service configration============="
    sudo sed -i 's/=on/=true/g' /etc/systemd/system/mund.service
    sudo sed -i 's/=true-/=on-/g' /etc/systemd/system/mund.service
    echo "=============Daemon reloading============="
    sudo systemctl daemon-reload
		echo "restart the system..."
		sudo systemctl restart mund

		for (( timer=60; timer>0; timer-- )); do
			printf "* second restart after sleep for ${RED_COLOR}%02d${NO_COLOR} sec\r" $timer
			sleep 1
		done
		height=$(mund status --node="http://127.0.0.1:36657" |& jq -r ."SyncInfo"."latest_block_height")
		if ((height>$BLOCK)); then
			echo -e "$GREEN_COLOR YOUR NODE WAS SUCCESFULLY UPDATED TO VERSION: $VERSION $NO_COLOR\n"
		fi
		mund version --long | head
		break
	else
		echo -e "${GREEN_COLOR}$height${NO_COLOR} ($(( BLOCK - height  )) blocks left)"
	fi
	sleep 5
done
