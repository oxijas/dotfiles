
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=1000
export SAVEHIST=1000

export TERM='xterm-256color'

export EDITOR="/usr/bin/nvim"
export VISUAL="/usr/bin/nvim"

export NNN_BMS='h:~/;c:~/.config/;d:~/Downloads/;e:/etc/;u:/usr/share'
export NNN_PLUG='c:fzcd;h:hexview;i:imgview;o:fzopen;m:nmount;x:togglex;S:suedit;u:uidgid'
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_COLORS='1267'
export NNN_FIFO=/tmp/nnn.fifo
export NNN_OPENER=/usr/share/nnn/plugins/nuke
export CUR_CTX=1

export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

#avoid duplicates
typeset -U PATH path

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

