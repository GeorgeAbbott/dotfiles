#!/bin/sh

# General Configurations
setxkbmap gb
export SHELL=/bin/zsh
wmname LG3D &		# For getting Java applications, e.g. Pycharm, Rider to work.

# Programs for creating desktop
dwmstatus & # Status bar
picom &     # Compositor

randombg &  # Set a random background.

# Programs to boot on startup
st &
librewolf &   


while true
do
        dwm
done
