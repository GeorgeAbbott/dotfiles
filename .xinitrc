#!/bin/sh

# General Configurations
setxkbmap gb						# Set keyboard to gb layout
setxkbmap -option caps:swapescape
export SHELL=/bin/zsh					# Set shell to zsh
# wmname LG3D &						# For getting Java applications, e.g. Pycharm, Rider to work.

# Launch the Window Manager with a Parameter
session=${1:-ferrwm}

run_dwm() {
    # Run all applications that go hand in hand w/ dwm

    while true 
    do
        dwm # Begin dwm wrapper 
    done

}

run_ferrwm() {
    RUST_LOG=trace && ferrwm
}

case $session in
    ferrwm            ) run_ferrwm ;;
    dwm               ) run_dwm ;;
    # No known session, try to run it as command
esac



