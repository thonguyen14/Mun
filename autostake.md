thank Revenge#5536 shared !
# Run in Tmux

    apt install tmux
    tmux new -t mundrestake
    mund config keyring-backend test && wget -O mun_restake.sh https://raw.githubusercontent.com/thonguyen14/Mun/main/mun_restake.sh && chmod +x mun_restake.sh

##edit mun_restake.sh file following your node , then run command 

    ./mun_restake.sh
    
    Ctrl+B then D
##To end the retake, run the following command
      tmux ls
      tmux attach -t mundrestake
      exit
