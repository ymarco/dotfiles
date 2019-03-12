#!/bin/sh
export HISTCONTROL=ignoredups
export HISTSIZE=HISTFILESIZE=1000
export HISTIGNORE='c:clear'
#add ./scrips and its subdirs to path
export PATH="$PATH:$(du "$HOME/.scripts/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export XDG_CONFIG_HOME="$HOME/.config"
export FZF_DEFAULT_OPTS="--reverse --height 40%"
#export READER="zathura"
#export FILE="ranger"
#export BIB="$HOME/Documents/LaTeX/uni.bib"
#export REFER="$HOME/.referbib"
#export SUDO_ASKPASS="$HOME/.scripts/tools/dmenupass"
#export PIX="$HOME/.pix/"
#start X if wm isnt running
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x bspwm >/dev/null && exec startx
