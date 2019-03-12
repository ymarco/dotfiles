# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
export SUDO_EDITOR=/usr/bin/vim
export PS1="\[$(tput bold)\]\[$(tput setaf 4)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\] \[$(tput setaf 5)\]\W\[$(tput setaf 4)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

[ -f "$HOME/.shortcuts" ] && source "$HOME/.shortcuts" # Load shortcut aliases
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"
# SET VI MODE YAAAAHHH
set -o vi
