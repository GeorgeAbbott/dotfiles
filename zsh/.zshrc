# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/george/.zshrc'

# Changing Default Prompt
PROMPT='[%F{160}%n %F{93}%1d%f] $ '

# Aliases
alias ls='ls -a --color=always'
alias exa="exa -a --header --long --git"

alias mount-shared="sudo mount /dev/sda1 /mnt/Shared"
alias mount-fedora="sudo mount /dev/sda5 /mnt/Fedora"
alias umount-shared="sudo umount /mnt/Shared"
alias umount-fedora="sudo umount /mnt/Fedora"

alias lle="[ \"$(findmnt | grep /mnt/Shared -c)\" = \"1\" ] || mount-shared && mkdir -p /mnt/Shared/Text/daily-log/$(date +%Y-%m) && vim /mnt/Shared/Text/daily-log/$(date +%Y-%m)/L$(date --iso-8601).txt"

autoload -Uz compinit
compinit
# End of lines added by compinstall
