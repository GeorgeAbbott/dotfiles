#!/bin/sh

feh --bg-scale "$(shuf -n1 -e ~/bgs/*)" --no-fehbg
if ! pgrep dwmblocks >/dev/null ; then
    dwmblocks &
fi

alacritty &
setxkbmap -option caps:swapescape

# Notifications

if ! pgrep dunst >/dev/null ; then
    dunst & 
fi



