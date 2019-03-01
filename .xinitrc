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
compton -b
# set background
feh --bg-scale Downloads/mandelbrot.png
# update with Xresources, cos appearently it doesnt happen automatically
xrdb ~/.Xresources
#[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
# start redshift
redshift -l 31.5:34.75 &
# Finally, launch i3
exec i3
#sxhkd &
#exec bspwm

