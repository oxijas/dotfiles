#!/bin/zsh
#
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

ex() {
	case $1 in
		*.tar.bz2)	tar xjf $1		 ;;
		*.tar.gz)   tar xzf $1		;;
		*.bz2)		  bunzip2 $1		;;
		*.gz)		  gunzip $1			;;
		*.tar)		  tar xf $1			;;
		*.tbz2)	  tar xjf $1		;;
		*.tgz)		  tar xzf $1		;;
		*.zip)		  unzip $1			;;
		*.7z)		  7z x $1			;; # require p7zip
		*.rar)		  7z x $1			;; # require p7zip
		*.iso)		  7z x $1			;; # require p7zip
		*.Z)		  uncompress $1	;;
		*)			  echo "'$1' cannot be extracted" ;;
	 esac
}
