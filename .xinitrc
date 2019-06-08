#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# start pulseaudio
start-pulseaudio-x11 &
# start composite manager for transparency
echo "starting compton!"
compton -b
echo "done"
# set background
#feh --randomize --bg-fill ~/.wallpapers/*
# update with Xresources, cos appearently it doesnt happen automatically
xrdb ~/.Xresources
#[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
# Adjust typematic delay and rate
xset r rate 300 30
# start redshift
redshift -l 31.5:34.75 &
# start network manager applet if not already running
pgrep nm-applet || nm-applet &
# start unclutter to hide the mouse when not used
unclutter &
# finally, start the wm
exec awesome
#exec bspwm
