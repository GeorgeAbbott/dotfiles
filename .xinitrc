#!/bin/sh

# General Configurations
setxkbmap gb						# Set keyboard to gb layout
export SHELL=/bin/zsh					# Set shell to zsh
# wmname LG3D &						# For getting Java applications, e.g. Pycharm, Rider to work.

# Launch the Window Manager with a Parameter
session=${1:-dwm}

run_dwm() {
    # Run all applications that go hand in hand w/ dwm

    while true 
    do
        dwm # Begin dwm wrapper 
    done

}

case $session in
    i3|i3wm           ) exec i3;;
    dwm               ) run_dwm ;;
    # No known session, try to run it as command
esac



