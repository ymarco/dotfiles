#!/bin/sh
export HISTCONTROL=ignoredups
#add ./scrips and its subdirs to path
export PATH="$PATH:$(du "$HOME/.scripts/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
echo $PATH
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="firefox"
#export READER="zathura"
#export FILE="ranger"
#export BIB="$HOME/Documents/LaTeX/uni.bib"
#export REFER="$HOME/.referbib"
#export SUDO_ASKPASS="$HOME/.scripts/tools/dmenupass"
#export PIX="$HOME/.pix/"
#start X if i3 isnt running
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx
