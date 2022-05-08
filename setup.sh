#!/bin/sh

# Installer for my setup for Arch based distro.

# The dotfiles should be installed in $HOME/git/dotfiles
# for this script to work. 

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
# Various Basic Things
pacman -S pacman-contrib

# Install X Server
pacman -S xorg xorg-xinit xorg-xbacklight

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
if [[ $MINIMAL="no" ]] ; then 
    pacman -S plasma kde-applications sddm
fi

# TODO: add the dwm entry to XSessions

####################################################################################
###################### Making some directories for later use #######################
mkdir -p $HOME/.config
mkdir -p $HOME/.config/zsh
mkdir -p $HOME/.config/newsboat
mkdir -p $HOME/.config/mpd
mkdir -p $HOME/.config/ncmpcpp
mkdir -p $HOME/.local/share/dwm

#####################################################################################
######## These are only installed in a minimal installation, as a non-minimal #######
######### install should already contain applications that fit this purpose. ########

########################## Install Necessary Packages ################################
##### Where e.g. fonts are in pacman, these are installed under its own section. #####
pacman -S libnotify dunst                                   # Notifications
pacman -S sxiv python-pywal                                 # Background
pacman -S polkit                                            # poweroff w/o sudo
yay    -S vscodium-bin vscodium-bin-marketplace             # Vscodium
pacman -S vim neovim                                        # Vim
pacman -S rust-analyzer ccls gopls                          # Nvim LSP
pacman -S torbrowser-launcher firefox                       # Browsers
yay    -S librewolf-bin
pacman -S mpd ncmpcpp mpc mpv                               # Music etc.
pacman -S zathura zathura-pdf-mupdf                         # PDF Viewer
pacman -S keepassxc                                         # Password Manager

yay    -S exa htop                                          # Command line utilities
pacman -S zoxide bat dust                                   

############################### git clone from repo #################################
# TODO: git clone all repos here 
git clone git.sateoki.xyz/self/st       ./inst
git clone git.sateoki.xyz/self/dwm      ./inst
git clone git.sateoki.xyz/self/dmenu    ./inst


######################################################################################
##### Install all scripts under .usrconf/scripts by symlinking to /usr/local/bin #####
sh ./scripts/udcmdlink                                                           #####

######################### Set up symlinks to dotfiles ################################
ln -s $HOME/git/dotfiles/zsh/.zshrc     $HOME/.config/zsh/.zshrc
ln -s $HOME/git/dotfiles/zsh/.zshenv    $HOME/.zshenv
ln -s $HOME/git/dotfiles/.xinitrc       $HOME/.xinitrc

# Music
ln -s $HOME/git/dotfiles/mpd.conf       $HOME/.config/mpd.conf
ln -s $HOME/git/dotfiles/mpd.conf       /etc/mpd.conf
ln -s $HOME/git/dotfiles/ncmpcpp-config $HOME/.config/ncmpcpp/config

# sddm - only install if MINIMAL="no" 


# TBA the rest

# Ensure that in .zshrc, the variable $USRCONFDIR is exported correctly
# TODO: make sure $USRCONFDIR is set to the . path

############################### Install all fonts ####################################
sh ./fonts/install-fonts.sh
# Also install all fonts from pacman

######################################################################################
######################### Final Tits and Bits to be done #############################
chsh -s /bin/zsh
