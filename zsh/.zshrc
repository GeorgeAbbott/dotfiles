# History
HISTFILE=$ZDOTDIR/zsh_history
HISTSIZE=1001
SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Various
export LANG=en_GB.UTF-8
setopt autocd
unsetopt beep
bindkey -v
zstyle :compinstall filename "$HOME/.zshrc"

# Configuring applications to use nvidia GPU
alias pmpv="prime-run mpv"


# Other general user config
autoload -U colors && colors
autoload -U promptinit && promptinit

########## Reducing clutter in home directory ##########
export LESSHISTFILE=/dev/null			# Remove ~/.lesshst generation
alias feh="feh --no-fehbg"
alias newsboat="newsboat -u ~/.config/newsboat/urls"
# TODO: add all XDG directories in the right places, and then run the commands
# as per the SO post: https://stackoverflow.com/questions/26198926/why-does-lesshst-keep-showing-up-in-my
# to get rid of .lesshst file and where man creates it as well

# alias less='less --lesskey-file=$XDG_CONFIG_HOME/lesskey'
# alias man='man --pager="less --lesskey-file=$XDG_CONFIG_HOME/lesskey"'

# Changing Default Prompt
# PS1='[%F{#ff0000}%n%f %F{#6a0dad}%1d%f] '
# PS1='[%F{#1111ee}%1d%f] => '
# PS1="%? | [%F{#ff0000}%n%f] [$(vcs_info_wrapper)] %2~ %# "
# Creates a git prompt
git_branch_test_color() {
  local ref=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -n "${ref}" ]; then
    if [ -n "$(git status --porcelain)" ]; then
      local gitstatuscolor='%F{red}'
    else
      local gitstatuscolor='%F{green}'
    fi
    echo "${gitstatuscolor} (${ref})"
  else
    echo ""
  fi
}
setopt PROMPT_SUBST
PROMPT='%9c$(git_branch_test_color)%F{none} %# '
RPROMPT='%D{%k:%M:%S}'

########## Aliases / Functions ##########
# allow sudo to make use of aliases
alias sudo="sudo "

# ls / exa 
alias ls='ls -a --color=always'
alias e="exa -a --header --long --git --time-style=long-iso"
alias ev="exa --header --long --git --time-style=long-iso" # Exa View
alias c="clear ; e"
alias cv="clear ; ev" # Clear + Exa View
alias t="e --tree"

# vim / nvim
alias v="vim"
alias n="nvim"

# music: mpd, ncmpcpp, mpc
alias m="ncmpcpp"
alias mc="mpc"

alias mps="mpc pause"
alias mpl="mpc play"
alias mst="mpc stop"
alias mtg="mpc toggle"

alias mnx="mpc next"
alias mpr="mpc prev"

# backgrounds, wal...

# todos...
alias td="mn todos"
alias cld="mn calendar" 

alias tdcmp="mn todos-cmp"
alias cldcmp="mn calendar-cmp"


# anime 
alias awl="mn anime-watchlist"  # Anime I have seen
alias atw="mn anime-towatch"    # Anime I should watch 
alias ac="mn anime-completed"   # Anime I have completed
alias ad="mn anime-dropped"     # Anime I have dropped

# documents
alias p="zathura" 
alias o="libreoffice --writer" 

# pulseaudio - this is a temporary solution
sv() {
    pactl set-sink-volume 0 $1%
}

# git
# TODO: add command to push to all remote repos, e.g. github, origin and gitlab
alias gb="git branch"
alias gco="git checkout" 
alias gcom="git checkout master"
alias gdb="git branch -d"
alias gp="git push"
alias gpa="gp origin && gp github && gp gitlab"
alias gpl="git pull" # TODO: might be ambiguous with multiple remotes
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"

# misc
alias pkg-query="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias r="newsboat"
# alias en="nvim /mnt/Shared/Text" ## TODO: what was this for? Can I replicate with, e.g. ranger? Is it needed anymore?
# alias fin="libreoffice --calc /mnt/Shared/Trackers/Financial/new/$(date +%Y-%m).ods & " ## TODO: is this needed anymore? If so, update

# lle... TODO: maybe find a way to make these take up less room in the zshrc?
lle() { # Life Log Entry
    if [ -z "$1" ]; then
        mkdir -p ~/docs/daily-log/$(date +%Y-%m)
        nvim ~/docs/daily-log/$(date +%Y-%m)/L$(date --iso-8601).txt
    else 
        mkdir -p ~/docs/daily-log/$(date +%Y-%m -d $1)
        nvim ~/docs/daily-log/$(date +%Y-%m -d $1)/L$(date --iso-8601 -d $1).txt
    fi
}

mer() { # Month End Recap - TODO: get this to work just with e.g. mer 2022-01
    if [ -z "$1"]; then 
        mkdir -p ~/docs/daily-log/$(date +%Y-%m)
        nvim "~/docs/daily-log/$(date +%Y-%m)/L$(date +%Y-%m) - Month End Recap"
    else 
        mkdir -p /mnt/Shared/Text/daily-log/$(date +%Y-%m -d $1)
        nvim "~/docs/daily-log/$(date +%Y-%m -d $1)/L$(date +%Y-%m -d $1) - Month End Recap" 
    fi
}

yer() { # Year End Recap - TODO: see mer TODO
    if [ -z "$1"]; then 
        mkdir -p ~/docs/daily-log/$(date +%Y)-12
        nvim "~/docs/daily-log/$(date +%Y)-12/$(date +%Y) - Year End Recap"
    else 
        mkdir -p ~/docs/daily-log/$(date %Y -d $1)-12
        nvim "~/docs/daily-log/$(date +%Y -d $1)-12/$(date +%Y -d $1) - Year End Recap"
    fi
}




mn() { # make note
    nvim "$HOME/docs/written/$1"
}

autoload -Uz compinit
compinit
# End of lines added by compinstall

# z - must go after compinit
eval "$(zoxide init zsh)"


# Sourcing for zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
