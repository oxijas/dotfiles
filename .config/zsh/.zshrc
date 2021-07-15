#!/bin/zsh


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


# USE LF TO SWITCH DIRECTORIES AND BIND IT TO CTRL-O
bindkey -s '^[o' 'lfcd\n'

# -------------- ALIASES ------------------------
source $XDG_CONFIG_HOME/aliases/aliases

# ---------- SCRIPTS ----------------------------
source $ZDOTDIR/scripts.zsh

# ---------- PREP FOR GO-LIVE -------------------
# Lines configured by zsh-newuser-install
unsetopt autocd beep

autoload -Uz compinit
compinit
_comp_optins+=(globdots) # With hidden files
source $ZDOTDIR/completion.zsh

# option to use bd to go back directories quickly - not used much, just kept in
#autoload -Uz bd; bd

autoload -Uz jgprompt.zsh-theme; jgprompt.zsh-theme

[ ! -f "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] &&
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/plugins/zsh-syntax-highlighting


source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

cd $HOME
pfetch

