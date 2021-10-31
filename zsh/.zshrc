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

# Other general user config
export LESSHISTFILE=/dev/null			# Remove ~/.lesshst generation
autoload -U colors && colors
autoload -U promptinit && promptinit


# Changing Default Prompt
PROMPT='[%F{160}%n %F{93}%1d%f] $ '

# Aliases
alias ls='ls -a --color=always'
alias exa="exa -a --header --long --git"

alias mount-shared="[ \"$(findmnt | grep /mnt/Shared -c)\" = \"0\" ] && sudo mount /dev/sda1 /mnt/Shared ; echo \"$(findmnt | grep /mnt/Shared -c)\""
alias mount-fedora="[ \"$(findmnt | grep /mnt/Fedora -c)\" = \"0\" ] && sudo mount /dev/sda5 /mnt/Fedora"
alias umount-shared="sudo umount /mnt/Shared"
alias umount-fedora="sudo umount /mnt/Fedora"


alias lle="mount-shared ;  mkdir -p /mnt/Shared/Text/daily-log/$(date +%Y-%m) ; nvim /mnt/Shared/Text/daily-log/$(date +%Y-%m)/L$(date --iso-8601).txt"
alias fin="mount-shared ;  libreoffice --calc /mnt/Shared/Trackers/Financial/new/$(date +%Y-%m).ods & "

# Add command that open Month end entry for final month, at /mnt/Shared/Text/daily-log/ and previous months month then filename 2021-NN - How I Improved.txt
autoload -Uz compinit
compinit
# End of lines added by compinstall
