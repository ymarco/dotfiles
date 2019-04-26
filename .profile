#!/bin/sh
export HISTCONTROL=ignoredups
export HISTSIZE=HISTFILESIZE=1000
export HISTIGNORE='c:clear'
# add ./scrips and its subdirs to path
export PATH="$PATH:$(du "$HOME/.scripts/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
#export PATH=/opt/texlive/2018/bin/x86_64-linux/:$PATH
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export XDG_CONFIG_HOME="$HOME/.config"
export FZF_DEFAULT_OPTS="--reverse --height 40%"
#export READER="zathura"
export FILE="nnn"
export NNN_TMPFILE="~/.nnn_tempfile"
export NNN_USE_EDITOR=1
#export BIB="$HOME/Documents/LaTeX/uni.bib"
#export REFER="$HOME/.referbib"
#export SUDO_ASKPASS="$HOME/.scripts/tools/dmenupass"
#export PIX="$HOME/.pix/"
# Prompt user whether to use nvidia or intel gpu:
X=$(echo -e 'startx\nnvidia-xrun' | fzf)
# start X with the chosen card
exec $X
#[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x bspwm >/dev/null && startx
