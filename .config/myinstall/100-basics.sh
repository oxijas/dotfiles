#!/bin/sh

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed xorg-server xorg-init xorg-xrandr xorg-xsetroot
sudo pacman -S --noconfirm --needed xorg-setxkbmap xorg-xmodmap xrdp xorg-xrdp
sudo pacman -S --noconfirm --needed vifm xsel xclip firefox nitrogen dmenu neovim
sudo pacman -S --noconfirm --needed tmux zsh alacritty nnn git enca rsync base-devel bat




