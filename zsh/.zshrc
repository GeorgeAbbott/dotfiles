#!/bin/zsh
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
unsetopt autocd
unsetopt beep
bindkey -v
zstyle :compinstall filename "$HOME/.zshrc"

# Other general user config
autoload -U colors && colors
autoload -U promptinit && promptinit

# Source .zshrc-xdg, which holds aliases to declutter the home directory 
source "$XDG_CONFIG_HOME/zsh/.zshrc-xdg"

################################## orgd #######################################
export WRITTEN="$HOME/docs/wr"
export LLE="$WRITTEN/lle"
export HOLIDAY="$LLE/hol"
export ORGD_ROOT="$WRITTEN/orgd"
export ORGD_INST_PATH="$HOME/git/pp/orgd"
export ORGD_SCR_PATH="$ORGD_INST_PATH/scr"

export ORGD_TD_PATH="$ORGD_ROOT/td"
export ORGD_CLD_PATH="$ORGD_ROOT/cld"
export ORGD_KT_PATH="$ORGD_ROOT/kt"
export ORGD_MED_PATH="$ORGD_ROOT/med"
export ORGD_CDALIAS_PATH="$ORGD_ROOT/sd/cd"

export VISUAL="/usr/bin/nvim"
export EDITOR="/usr/bin/nvim"

PATH=$PATH:$HOME/.local/share/go/bin:$ORGD_SCR_PATH:$HOME/.local/share/python/bin

########## Configuration #############
if [[ ! -d ~/.config/zsh/zsh-autopair ]]; then
  git clone https://github.com/hlissner/zsh-autopair ~/.config/zsh/zsh-autopair
fi

source ~/.config/zsh/zsh-autopair/autopair.zsh
autopair-init

# Source the abbrev file, which holds abbrev-alias and related settings. 
source "$XDG_CONFIG_HOME/zsh/.zshrc-abbrev"

# allow sudo to make use of aliases
alias sudo="sudo "

# ls / exa 
alias ls='exa --color=always'
alias l='exa --header --long --git --time-style=long-iso --group --color=always'
alias ll="exa -a --header --long --git --time-style=long-iso --group"
abbrev-alias x="clear; ls"
abbrev-alias t="ls --tree"

# cd aliases, from $ORGD_CDALIAS_PATH
while read a c ; do 
	alias "cd$a"="cd $c"
done <<< "$(strip-comments "$ORGD_CDALIAS_PATH" | strip-blank)"

# vim / nvim
alias vim="nvim"
abbrev-alias v="vim"
abbrev-alias n="nvim"

# music: mpd, ncmpcpp, mpc
abbrev-alias m="ncmpcpp"

abbrev-alias mps="mpc pause"
abbrev-alias mpl="mpc play"
abbrev-alias mst="mpc stop"
abbrev-alias mtg="mpc toggle"
abbrev-alias mnx="mpc next"
abbrev-alias mpr="mpc prev"

# backgrounds, wal...
alias rbg='feh --no-fehbg --bg-fill $(shuf -n1 -e ~/bgs/*)'
alias wlrbg='swaybg -i $(shuf -n1 -e ~/bgs/*)'

# cargo 
abbrev-alias cb="cargo build"
abbrev-alias cbr="cargo build --release"

# other 
abbrev-alias r="newsboat"
abbrev-alias ka="killall"

# documents
abbrev-alias p="zathura" 
abbrev-alias o="libreoffice --writer" 
abbrev-alias b="bat"

# other, e.g. updating and other commonly used commands
abbrev-alias pu="sudo pacman -Syu"
abbrev-alias pm="sudo pacman"
alias packages="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

# Source .zshrc-git, which contains all Git commands and aliases

# TODO: add command to push to all remote repos, e.g. github, origin and gitlab
source "$XDG_CONFIG_HOME/zsh/.zshrc-git"

# Source .zshrc-mk, which contains mkwr, mn, lle, and other mk~ commands
source "$XDG_CONFIG_HOME/zsh/.zshrc-mk"

# Source .zshrc-fn, which contains various miscellaneous functions 
source "$XDG_CONFIG_HOME/zsh/.zshrc-fn"

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
# End of lines added by compinstall

# Sourcing for zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
