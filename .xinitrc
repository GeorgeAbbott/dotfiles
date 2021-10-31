#!/bin/sh

# General Configurations
setxkbmap gb						# Set keyboard to gb layout
export SHELL=/bin/zsh					# Set shell to zsh
wmname LG3D &						# For getting Java applications, e.g. Pycharm, Rider to work.

# Programs for creating desktop
dwmstatus & 						# Status bar	
picom &     						# Compositor

# Programs to boot on startup
st &
librewolf &   

# Must go last
randombg &  	# Set a random background. Update to changebg & once theming is complete.



while true
do
        dwm
done
