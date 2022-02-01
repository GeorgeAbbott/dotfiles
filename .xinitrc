#!/bin/sh

# General Configurations
setxkbmap gb						# Set keyboard to gb layout
# export SHELL=/bin/zsh					# Set shell to zsh
# wmname LG3D &						# For getting Java applications, e.g. Pycharm, Rider to work.

# Daemons etc.
# mpd                             

# Programs for creating desktop
# picom &     						# Compositor


# Launch the Window Manager with a Parameter
session=${1:-dwm}

run_dwm() {
    # /usr/bin/prime-offload              # For optimus-manager, nvidia
    # Run all applications that go hand in hand w/ dwm
    # dwmblocks & 

    # Start-up apps for dwm
    st & 
    librewolf & 
    keepassxc &
    # discord &
    # firefox & 

    while true 
    do
        dwm # Begin dwm wrapper 
    done


    # sudo /usr/bin/prime-switch
}

run_kde() {
    export DESKTOP_SESSION=plasma
    startplasma-x11
}

case $session in
    i3|i3wm           ) exec i3;;
    kde               ) export DESKTOP_SESSION=plasma ; exec startplasma-x11;;
    dwm               ) run_dwm ;;
    # No known session, try to run it as command
esac



