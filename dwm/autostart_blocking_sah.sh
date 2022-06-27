#!/bin/sh

feh --bg-scale $(shuf -n1 -e ~/bgs/*)
dwmblocks &
alacritty &
setxkbmap -option caps:swapescape

# Notifications
dunst & 
