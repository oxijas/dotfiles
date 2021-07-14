#!/bin/sh

pacman-key --init
pacman-key --populate
sudo pacman -Syu
sudo pacman -S --noconfirm --needed zsh nnn git enca rsync base-devel bat
sudo pacman -S --noconfirm --needed vifm mc neovim fzf unzip p7zip tar

printf "git username :"
read ans

#NAME=$(hostname|tr '[:upper:]' '[:lower:]')
git config --global user.email "oxijas@gmail.com"
git config --global user.name "$ans"
git config --global --list




