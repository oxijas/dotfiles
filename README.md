# dotfiles

Dotfiles are stored in $HOME/.local/share/dotfiles

to install and overwite existing config:
> git clone --separate-git-dir=$HOME/.local/share/dotfiles git@github.com:oxijas/dotfiles.git tmpdotfiles

> rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/

> rm -r tmpdotfiles
