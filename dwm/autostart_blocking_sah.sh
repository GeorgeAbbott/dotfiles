#!/bin/sh

feh --bg-scale $(shuf -n1 -e ~/bgs/*) --no-fehbg
dwmblocks &
alacritty &
setxkbmap -option caps:swapescape

# Notifications
dunst & 
