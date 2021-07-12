#!/bin/sh

sudo pacman -S --needed --noconfirm git
NAAM=$(hostname|tr '[:upper:]' '[:lower:]')
git --global user.email "oxijas@gmail.com"
git --global user.name "$NAAM"

cd $HOME
git clone --separate-git-dir=$HOME/.local/share/dotfiles git@github.com:oxijas/dotfiles.git dottmp
rsync --recursive --verbose --exclude '.git' dottmp/ $HOME/
rm -r dottmp


