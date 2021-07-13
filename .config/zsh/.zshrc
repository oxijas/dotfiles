
fpath=($ZDOTDIR/plugins $fpath)

setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt EXTENDED_HISTORY     # Write the history file in the ':start:elapsed;command' format.
setopt HIST_VERIFY          # Do not execute immediately upon history expansion.
#setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate.

# -------------- KEYBOARD -----------------------
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi


# -------------- ALIASES ------------------------
alias lf=lfrun
alias cp="cp -i" # Confirm before overwriting something
alias df='df -h' # Human-readable sizes
alias free='free -m' # Show sizes in MB
alias ls='ls --color=always --group-directories-first'
alias l='ls --color=always -A --group-directories-first'
alias la='ls -liAFh --group-directories-first --color=always'
alias ll='ls -liFh --group-directories-first --color=always'
alias gst='git status'
alias pac='sudo pacman'
alias vi='nvim'
alias slf='sudo lf'
alias fm='vifm'
alias mi='micro'
alias please='sudo'
alias gh="git log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci)' --abbrev-commit"
alias gh2="git log --all --decorate --oneline --graph"
alias gh3="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cs) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gls="git ls-tree --full-tree -r --name-only HEAD |fzf"
alias cdh="cd ~"
alias cdc="cd ~/.config"
alias update='sudo pacman -Syyu'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias cclip='xclip -selection clipboard'
alias pclip='xclip -o -selection clipboard'
# dot is defined in ~/.local/bin
dot config --local status.showUntrackedFiles no
alias dotl='dot log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cs) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias dots='dot status'
alias dotlt='dot ls-tree --full-tree -r --name-only HEAD |fzf'
alias dotcom='dot commit'
alias jctl="journalctl -p 3 -xb"



# ---------- FUNCTIONS --------------------------
n () {
	# Block nesting of nnn in subshells
	if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
		echo "nnn is already running"
		return
	fi
	# NOTE: NNN_TMPFILE is fixed, should not be modified
	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
	nnn -aceRHU "$@"
	if [ -f "$NNN_TMPFILE" ]; then
		. "$NNN_TMPFILE"
		rm -f "$NNN_TMPFILE" > /dev/null
	fi
}

# USE LF TO SWITCH DIRECTORIES AND BIND IT TO CTRL-O
lfcd () {
	tmp="$(mktemp)"
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		rm -f "$tmp"
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}
bindkey -s '^[o' 'lfcd\n'


# ---------- PREP FOR GO-LIVE -------------------
# Lines configured by zsh-newuser-install
unsetopt autocd beep
#bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
#zstyle :compinstall filename '/home/jga/.zshrc'

autoload -Uz compinit
compinit
_comp_optins+=(globdots) # With hidden files
source $ZDOTDIR/completion.zsh

#fpath="$ZDOTDIR/plugins/jgprompt.zsh $fpath"
autoload -Uz jgprompt.zsh-theme; jgprompt.zsh-theme

[ ! -f "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntaxhighlighting.zsh" ] &&
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/plugins/zsh-syntax-highlighting

source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

cd $HOME
pfetch

