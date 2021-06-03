# dotfiles

Dotfiles managed with bare git repository. Dotfiles are stored
in $HOME/.local/share/dotfiles

On new machine with no existing config:
git clone --separate-git-dir=$HOME/.local/share/dotfiles https://github.com/oxijas/dotfiles.git ~
or
git clone --separate-git-dir=$HOME/.local/share/dotfiles git@github.com:oxijas/dotfiles.git ~


to install and overwite existing config:
git clone --separate-git-dir=$HOME/.local/share/dotfiles git@github.com:oxijas/dotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
