#!/bin/sh

ssh-keygen -t rsa -b 4096 -C "oxijas@gmail.com"
eval "$(ssh-agent -s)"

if [[ ! -f $HOME/.ssh/config ]]; then
	echo "Host" >$HOME/.ssh/config
	echo "  Hostname xx" >>$HOME/.ssh/config
	echo "  User xx" >>$HOME/.ssh/config
	echo "  Port xx" >>$HOME/.ssh/config
	echo "  IdentityFile $HOME/.ssh/id_rsa" >>$HOME/.ssh/config
fi
printf "copy public key to github\n\n"
cat $HOME/.ssh/id_rsa.pub

#werkt alleen in X
#xclip -sel clip < ~/.ssh/id_rsa.pub


