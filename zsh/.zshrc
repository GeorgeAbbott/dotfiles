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
alias feh="feh --no-fehbg"
alias newsboat="newsboat -u ~/.config/newsboat/urls"
alias gpg2="gpg2 --homedir $XDG_DATA_HOME/gnupg"
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
alias e="exa -a --header --long --git --time-style=long-iso --group"
alias ev="exa --header --long --git --time-style=long-iso --group" # Exa View
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
alias tdcmp="mn todos-cmp"
alias tdntd="mn todos-ntd"

alias cld="mn calendar" 
alias cldcmp="mn calendar-cmp"

# anime 
alias awl="mn anime-watchlist"  # Anime I have seen
alias atw="mn anime-towatch"    # Anime I should watch 
alias ac="mn anime-completed"   # Anime I have completed
alias ad="mn anime-dropped"     # Anime I have dropped

# TV
alias tvwl="mn tv-watchlist"
alias tvtw="mn tv-towatch"
alias tvc="mn tv-completed"
alias tvd="mn tv-dropped"

# documents
alias p="zathura" 
alias o="libreoffice --writer" 
alias b="bat"

# file manipulation
defix() {
    for i in  "$1"*;do mv "$i" "${i#"$1"}";done
}

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
alias gpl="git pull" 
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gf="git fetch"
gar() { # Add remotes
    git remote add origin gitea@git.gabbott.xyz:self/$1.git
    git remote add github git@github.com:GeorgeAbbott/$1.git
    git remote add gitlab git@gitlab.com:GeorgeAbbott/$1.git
}
grr() { # Rename all remotes 
    git remote set-url origin gitea@git.gabbott.xyz:self/$1.git
    git remote set-url github git@github.com:GeorgeAbbott/$1.git
    git remote set-url gitlab git@gitlab.com:GeorgeAbbott/$1.git
}

# misc
alias pkg-query="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias r="prime-run newsboat"

lle() { # Life Log Entry
    if [ -z $1 ] ; then DT="today" else DT="$1" fi
    mkdir -p "$HOME/docs/daily-log/$(date +%Y-%m -d $DT)"
    nvim "$HOME/docs/daily-log/$(date +%Y-%m -d $DT)/L$(date --iso-8601 -d $DT).txt"
}

mer() { # Month End Recap - TODO: get this to work just with e.g. mer 2022-01
    if [ -z $1 ] ; then DT="yesterday" else DT="$1" fi
    mkdir -p "$HOME/docs/daily-log/$(date +%Y-%m -d $DT)"
    nvim "$HOME/docs/daily-log/$(date +%Y-%m -d $DT)/L$(date +%Y-%m -d $DT) - Month End Recap.txt" 
}

yer() { # Year End Recap - TODO: see mer todos
    if [ -z $1 ] ; then DT="yesterday" else DT="$1" fi
    mkdir -p "$HOME/docs/daily-log/$(date %Y -d $DT)-12"
    nvim "$HOME/docs/daily-log/$(date +%Y -d $DT)-12/$(date +%Y -d $DT) - Year End Recap.txt"
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
