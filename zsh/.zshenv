# XDG Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Path Directories
export PATH="$PATH:$HOME/.local/bin"

# Other
# export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export KDEHOME="$XDG_CONFIG_HOME/kde4"
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GOPATH="$XDG_DATA_HOME"/go
export LESSHISTFILE=/dev/null
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export PYTHONHISTFILE=/dev/null # in case one day they actually decide to support XDG... 
export PYTHONHISTORY=/dev/null
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem



# ZSH Directories
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"

# Qt Themes
export QT_STYLE_OVERRIDE=kvantum

# Vim
export VIMINIT="if has("nvim") | so ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/init.vim | else | set nocp | so ${XDG_CONFIG_HOME:-$HOME/.config}/vim/vimrc | endif"

