#!/bin/sh

sudo pacman -Syyu
sudo pacman -S --noconfirm --needed xorg-server xorg-init xorg-xrandr xorg-xsetroot
sudo pacman -S --noconfirm --needed xorg-setxkbmap xorg-xmodmap xrdp xorg-xrdp xorg-arandr
sudo pacman -S --noconfirm --needed firefox alacritty dmenu lightdm




