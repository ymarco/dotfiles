#!/bin/sh
#
export HISTCONTROL=ignoredups
export HISTSIZE=HISTFILESIZE=1000
export HISTIGNORE='c:clear'

export PATH="$HOME/.scripts:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$ANDROID_STUDIO/tools/bin:$PATH"
export ANDROID_HOME="$HOME/Android/Sdk"
export EDITOR="emacs"
export BROWSER="firefox"
export FZF_DEFAULT_OPTS="--reverse --height 40%"

# export LESS_TERMCAP_me='\e[0m'    # turn off all
# export LESS_TERMCAP_mb='\e[31m'   # start blink
# export LESS_TERMCAP_md='\e[1;33m' # start bold
# export LESS_TERMCAP_so='\e[35m'   # start stand-out
# export LESS_TERMCAP_se='\e[0m'    # stop stand-out
# export LESS_TERMCAP_us='\e[34m'   # start underline
# export LESS_TERMCAP_ue='\e[0m'    # stop underline

export JAVA_HOME='/usr/lib/jvm/java-11-openjdk-amd64'

# right alt is F13
xmodmap -e "keycode 108 = F13"

#export _JAVA_AWT_WM_NONREPARENTING=1
#pgrep mpd || mpd;
