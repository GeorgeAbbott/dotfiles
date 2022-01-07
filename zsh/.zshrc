# History
HISTFILE=~/.config/zsh/zsh_history
HISTSIZE=1001
SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Various
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/george/.zshrc'

# Path
export PATH="$PATH:/home/george/.local/bin"

# Configuring applications to use nvidia GPU
alias mpv='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME="nvidia" __VK_LAYER_NV_optimus="NVIDIA_only" __GL_SHOW_GRAPHICS_OSD=1 mpv'

# Other general user config
export USRCONFDIR=/home/george/.usrconf  # Set user configuration directory
export LANG=en_GB.UTF-8
autoload -U colors && colors
autoload -U promptinit && promptinit


# Dealing with .lesshst
export LESSHISTFILE=/dev/null			# Remove ~/.lesshst generation

# TODO: add all XDG directories in the right places, and then run the commands
# as per the SO post: https://stackoverflow.com/questions/26198926/why-does-lesshst-keep-showing-up-in-my
# to get rid of .lesshst file and where man creates it as well

# alias less='less --lesskey-file=$XDG_CONFIG_HOME/lesskey'
# alias man='man --pager="less --lesskey-file=$XDG_CONFIG_HOME/lesskey"'

# Dealing with .fehbg
alias feh="feh --no-fehbg"

# Newsboat 
alias newsboat="newsboat -u ~/.config/newsboat/urls"


# Changing Default Prompt
PS1='[%F{#ff0000}%n%f| %F{#6a0dad}%1d%f] => '
PROMPT=$PS1

# Aliases / Functions
alias ls='ls -a --color=always'
alias e="exa -a --header --long --git"
alias pkg-query="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias s="systemctl"
alias c="clear ; e"
alias r="newsboat"
alias m="ncmpcpp"
alias v="nvim"
alias randbg="wal -i $USRCONFDIR/backgrounds/nice-photos > /dev/null" # random background
alias rb="wal -R > /dev/null" # refresh bg
alias rbghs="randbg --backend haishoku" # random background haishoku backend
alias td="mn todos"
alias wtd="mn work-todos"
alias awl="mn anime-watchlist"

lle() { # Life Log Entry
    if [ -z "$1" ]; then
        mkdir -p /mnt/Shared/Text/daily-log/$(date +%Y-%m)
        nvim /mnt/Shared/Text/daily-log/$(date +%Y-%m)/L$(date --iso-8601).txt
    else 
        mkdir -p /mnt/Shared/Text/daily-log/$(date +%Y-%m -d $1)
        nvim /mnt/Shared/Text/daily-log/$(date +%Y-%m -d $1)/L$(date --iso-8601 -d $1).txt
    fi
}

mer() { # Month End Recap - TODO: get this to work just with e.g. mer 2022-01
    if [ -z "$1"]; then 
        mkdir -p /mnt/Shared/Text/daily-log/$(date +%Y-%m)
        nvim "/mnt/Shared/Text/daily-log/$(date +%Y-%m)/L$(date +%Y-%m) - Month End Recap"
    else 
        mkdir -p /mnt/Shared/Text/daily-log/$(date +%Y-%m -d $1)
        nvim "/mnt/Shared/Text/daily-log/$(date +%Y-%m -d $1)/L$(date +%Y-%m -d $1) - Month End Recap" 
    fi
}

yer() { # Year End Recap - TODO: see mer TODO
    if [ -z "$1"]; then 
        mkdir -p /mnt/Shared/Text/daily-log/$(date +%Y)-12
        nvim "/mnt/Shared/Text/daily-log/$(date +%Y)-12/$(date +%Y) - Year End Recap"
    else 
        mkdir -p /mnt/Shared/Text/daily-log/$(date %Y -d $1)-12
        nvim "/mnt/Shared/Text/daily-log/$(date +%Y -d $1)-12/$(date +%Y -d $1) - Year End Recap"
    fi
}




mn() { # make note
    nvim "/mnt/Shared/Text/$1"
}
alias en="nvim /mnt/Shared/Text"
alias fin="libreoffice --calc /mnt/Shared/Trackers/Financial/new/$(date +%Y-%m).ods & "

# Aliases for git
alias gb="git branch"
alias gco="git checkout" 
alias gcom="git checkout master"
alias gdb="git branch -d"


autoload -Uz compinit
compinit
# End of lines added by compinstall

# Sourcing for zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
