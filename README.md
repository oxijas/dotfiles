# dotfiles

Dotfiles are managed with standard git tools. No symlinks.
It uses a simple shell script called 'dot' stored in ~/.local/bin and this folder should be in the path.
'dot'is a simple wrapper around git that sets the working tree to the $HOME directory and the git repository to $HOME/.local/share/dotfiles.

Adding files to the repo, just do with 'dot add <filename>' then 'dot commit/push' etc.
Any git command will work as it just calls git underneath and uses your home folder as the root of the git repo.
In bashrc/zshrc set 'dot config --local status.ShowUntrackedFiles no'.
Otherwise all files and folders from the home directory reported as new files in the repo.

For initial installation clone into the dotfiles folder:
> git clone --separate-git-dir=$HOME/.local/share/dotfiles git@github.com:oxijas/dotfiles.git ~

(note the ~ at the end). This will overwrite existing config files in the home folder!

otherwise clone into temp folder first
> git clone --separate-git-dir=$HOME/.local/share/dotfiles https://github.com/oxijas/dotfiles.git tmpdotfiles

> rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/

  > rm -r tmpdotfiles
