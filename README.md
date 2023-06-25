# dotfiles

Dotfiles are managed with standard git tools. No symlinks.
It uses a simple shell script called 'dot' stored in ~/.local/bin and this folder should be in the path.
Dot is a simple wrapper around git that sets the working tree to the $HOME directory and the git repository to $HOME/.local/share/dotfiles.
Any git command will work as it just calls git under the hood. 

```dos
Usage: dot [OPTIONS]

All regular git commands work, in addition:

Options:
  a                similar to add -u
  c                similar to commit
  s                similar to status
  p                similar to push
  l                log in pretty format
  forcepull        Undo/delete all local changes and force the pull
  undoall          Remove all local changes, clean stage and restore worktree
  unstage          Unstage all files from stage area
  search           Search for files in dotfiles using fzf

```  

Adding files to the repo, just do with 'dot add <filename>' then 'dot commit/push' etc.

In bashrc/zshrc set 'dot config --local status.ShowUntrackedFiles no'.
Otherwise all files and folders from the home directory reported as new files in the repo.

For initial installation clone into a temporary folder:

	git clone --separate-git-dir=$HOME/.local/share/dotfiles https://github.com/oxijas/dotfiles.git tmpdotfiles 

or SSH:

	git clone --separate-git-dir=$HOME/.local/share/dotfiles git@github.com:oxijas/dotfiles.git tmpdotfiles
 
  
Then overwrite existing config
	rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/

And remove temp folder
	rm -r tmpdotfiles

add to existing bashrc
	source ~/.config/myprofile/mybash

in case of zsh, then .zshenv in home folder will be read automatically
  
first time git config:

	git config --global user.name "John Doe"

	git config --global user.email johndoe@example.com

some other options  

	dot config pull.rebase true


to set ssh instead of http later

	dot remote set-url origin git@github.com:oxijas/dotfiles.git

set local settings/aliases in  ~/.config/myprofile/thismachine
