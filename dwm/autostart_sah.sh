#!/bin/sh

if ! pgrep picom >/dev/null ; then 
	picom
fi
setxkbmap -option caps:swapescape
