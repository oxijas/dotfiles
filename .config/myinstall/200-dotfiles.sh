#!/bin/sh

printf "This will overwrite all config files locally, continue? [y/*]\n"
read ans

if [ $ans != "y" ]; then
	echo "no action taken"
	exit 0
else
	sudo pacman -S --needed --noconfirm git zsh
	cd $HOME
	git clone --separate-git-dir=$HOME/.local/share/dotfiles git@github.com:oxijas/dotfiles.git dottmp
	rsync --recursive --verbose --exclude '.git' dottmp/ $HOME/
	rm -r dottmp
	chsh -s /usr/bin/zsh
fi
