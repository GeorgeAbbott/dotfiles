# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
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

# various temporary
pvd() {
    pmpv *$1*
}

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

alias mps="mpc pause"
alias mpl="mpc play"
alias mst="mpc stop"
alias mtg="mpc toggle"

alias mnx="mpc next"
alias mpr="mpc prev"

# backgrounds, wal...

# todos...
alias td="mn td/todos"
alias tdcmp="mn td/todos-cmp"
alias tdntd="mn td/todos-ntd"

alias cld="mn cld/calendar" 
alias cldcmp="mn cld/calendar-cmp"
alias cldrec="mn cld/calendar-recurring"

# anime 
alias awl="mn med/anime-watchlist"  # Anime I have seen
alias atw="mn med/anime-towatch"    # Anime I should watch 
alias ad="mn med/anime-dropped"     # Anime I have dropped

# TV
alias tvwl="mn med/tv-watchlist"
alias tvtw="mn med/tv-towatch"
alias tvc="mn med/tv-completed"
alias tvd="mn med/tv-dropped"

# Manga
alias mrl="mn med/manga-readlist"
alias mtr="mn med/manga-toread"
alias mc="mn med/manga-completed"
alias md="mn med/manga-dropped"

# Book 
alias brl="mn med/book-readlist"
alias btr="mn med/book-toread"
alias bc="mn med/book-completed"
alias bd="mn med/book-dropped"


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
alias gbd="git branch -d"
alias gp="git push"
alias gpa="gp origin && gp github && gp gitlab"
alias gpl="git pull" 
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gf="git fetch"
gar() { # Add remotes
    git remote add origin gitea@git.gabbott.dev:self/$1.git
    git remote add github git@github.com:GeorgeAbbott/$1.git
    git remote add gitlab git@gitlab.com:GeorgeAbbott/$1.git
}
grr() { # Rename all remotes 
    git remote set-url origin gitea@git.gabbott.dev:self/$1.git
    git remote set-url github git@github.com:GeorgeAbbott/$1.git
    git remote set-url gitlab git@gitlab.com:GeorgeAbbott/$1.git
}
gpr() { # Print all remotes
    git remote get-url origin 
    git remote get-url github 
    git remote get-url gitlab 
}
gcar() { # Git clone from origin url and then add in the rest of remotes
    git clone gitea@git.gabbott.dev:self/$1.git
    cd ./$1
    gar $1
    cd ..
}
gua() { # Update all - recursively iterates through dir and runs git pull 
    # TODO implement
}

# misc
alias pkg-query="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias r="prime-run newsboat"

lle() { # Life Log Entry
    if [ -z $1 ] ; then DT="today" else DT="$1" fi
    mkdir -p "$HOME/docs/daily-log/$(date +%Y-%m -d $DT)"
    nvim "$HOME/docs/daily-log/$(date +%Y-%m -d $DT)/L$(date --iso-8601 -d $DT).txt"
}

holc () { # Holiday Entry 
    if [ -z $1 ] ; then DT="today" else DT="$1" fi
    mkdir -p "$HOME/docs/daily-log/$(date +%Y-%m -d $DT)"
    nvim "$HOME/docs/daily-log/$(date +%Y-%m -d $DT)/H$(date --iso-8601 -d $DT).txt"
}

mer() { # Month End Recap - TODO: get this to work just with e.g. mer 2022-01
    if [ -z $1 ] ; then DT="yesterday" else DT="$1" fi
    mkdir -p "$HOME/docs/daily-log/$(date +%Y-%m -d $DT)"
    nvim "$HOME/docs/daily-log/$(date +%Y-%m -d $DT)/L$(date +%Y-%m -d $DT)-month-end-recap.txt" 
}

yer() { # Year End Recap - TODO: see mer todos
    if [ -z $1 ] ; then DT="yesterday" else DT="$1" fi
    mkdir -p "$HOME/docs/daily-log/$(date %Y -d $DT)-12"
    nvim "$HOME/docs/daily-log/$(date +%Y -d $DT)-12/$(date +%Y -d $DT)-year-end-recap.txt"
}

mn() { # make note
    nvim "$HOME/docs/wr/$1"
}

autoload -Uz compinit
compinit
# End of lines added by compinstall

# z - must go after compinit
eval "$(zoxide init zsh)"


# Sourcing for zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
