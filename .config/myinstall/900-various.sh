#!/bin/sh

printf "1=change shell to zsh\n"
printf "2=set git username/email\n"
printf "3=test\n"
printf "\nany other key = exit\n"

printf "Choice? "
read -r ans
case $ans in
  1)
    sudo pacman -S --needed --noconfirm zsh
    chsh -s /usr/bin/zsh  ;;
  2)
    NAME=$(hostname|tr '[:upper:]' '[:lower:]')
    git config --global user.email "oxijas@gmail.com"
    git config --global user.name "$NAME"
    git config --global --list;;
  3)
    TEST=$HOME
    echo $HOME
    lf -remote 'send reload' ;;
esac
exit 0

