#!/bin/sh

# General Configurations
setxkbmap gb						# Set keyboard to gb layout
setxkbmap -option caps:swapescape
export SHELL=/bin/zsh					# Set shell to zsh
# wmname LG3D &						# For getting Java applications, e.g. Pycharm, Rider to work.

# Deal with screen saver
xset s off
xset -dpms

# Launch the Window Manager with a Parameter
session=${1:-wmdwm}

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

run_spectrwm() {
    spectrwm
}

case $session in
    wmferrwm            ) run_ferrwm ;;
    wmdwm               ) run_dwm ;;
    wmspectrwm          ) run_spectrwm ;;
    # No known session, try to run it as command
esac



