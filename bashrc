#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias shutdown='sync && shutdown -h now'
alias reboot='sync && reboot'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'

PS1='[\u@\h \W]\$ '

BROWSER=/usr/bin/firefox
EDITOR=/usr/bin/emacs

[ -e "$HOME/bin/bash-powerline.sh" ] && source "$HOME/bin/bash-powerline.sh"
