#!/bin/sh

# Installer for my setup for Arch based distro.

# This should be in the user config directory, e.g. ~/.usrconf
# or ~/git as examples of where to install it. 
# It should be run as sudo: sudo ./setup.sh
# By default, installs both dwm and kde, to just install dwm 
# pass the parameter "minimal", e.g.
# sudo ./setup.sh minimal

# If for an Artix install, specify parameter two as "artix", 
# and overtly state full for param 1 if not used:
# sudo ./setup.sh full artix

# Make sure to have internet before this, which will involve
# installing dhcpcd:
# sudo pacman -S dhcpcd ; dhcpcd
# or the equivalent on an Artix install, e.g.
# sudo pacman -S dhcpcd-s6

[ "$1" = "minimal" ] && MINIMAL="yes" || MINIMAL="no"
[ "$2" = "artix"   ] && ARTIX="yes"   || ARTIX="no"

#####################################################################################
#################################### Only on Artix ##################################

# TODO: copy Arch repos into pacman.conf

if [[ $ARTIX="yes" ]] ; then
    echo "We're on Artix alright!"
fi



########################### Setup everything necessary ###############################
# Install X Server
pacman -S xorg xorg-xinit

# Install Libraries Needed
pacman -S libxft fontconfig ntfs-3g

# Install all fonts necessary
pacman -S ttf-ubuntu-font-family

# TODO: set up yay

# Various programming language compilers, interpreters etc.
pacman -S make go ruby python cmake llvm clang ninja python rust cargo gcc
pacman -S curl git zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting

#####################################################################################
############# These are only installed in a non-minimal installation. ###############

pacman -S plasma kde-applications sddm

# TODO: add the dwm entry to XSessions

#####################################################################################
######## These are only installed in a minimal installation, as a non-minimal #######
######### install should already contain applications that fit this purpose. ########

########################## Install Necessary Packages ################################
##### Where e.g. fonts are in pacman, these are installed under its own section. #####
pacman -S libnotify			                                # Notifications
pacman -S sxiv python-pywal			                        # Background
pacman -S polkit			                                # poweroff w/o sudo
yay    -S vscodium-bin vscodium-bin-marketplace             # For C++ & C#
pacman -S vim neovim                                        # For Rust etc.
pacman -S torbrowser-launcher firefox                       # Browsers
yay    -S librewolf-bin
pacman -S mpd ncmpcpp mpc mpv                               # Music etc.
pacman -S zathura zathura-pdf-mupdf                         # PDF Viewer
pacman -S keepassxc                                         # Password Manager

yay    -S exa htop                                          # Command line utilities
pacman -S zoxide 

############################### git clone from repo #################################
git clone git.sateoki.xyz/self/dotfiles .
git clone git.sateoki.xyz/self/st       ./inst
git clone git.sateoki.xyz/self/dwm      ./inst
git clone git.sateoki.xyz/self/dmenu    ./inst


######################################################################################
##### Install all scripts under .usrconf/scripts by symlinking to /usr/local/bin #####
sh ./scripts/udcmdlink                                                           #####

######################### Set up symlinks to dotfiles ################################
symmove ./dotfiles/zsh/.zshrc     ~/.zshrc
symmove ./dotfiles/zsh/.zshenv    ~/.zshenv
symmove ./dotfiles/.xinitrc       ~/.xinitrc
# TBA the rest

# Ensure that in .zshrc, the variable $USRCONFDIR is exported correctly
# TODO: make sure $USRCONFDIR is set to the . path

############################### Install all fonts ####################################
sh ./fonts/install-fonts.sh
# Also install all fonts from pacman

######################################################################################
######################### Final Tits and Bits to be done #############################
chsh -s /bin/zsh
