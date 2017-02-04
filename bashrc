#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Should any chained commands fail, exit with error
set -o pipefail

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# This hasn't been necessary for over a decade
unset MAILCHECK

alias ls='ls --color=auto'
alias grep='grep --color'
alias shutdown='sync && shutdown -h now'
alias reboot='sync && reboot'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias mkdir='mkdir -p'

PS1='[\u@\h \W]\$ '

BROWSER=$(which firefox || which chromium)
EDITOR=$(which emacs || which nvim || which vim)

[ -e "$HOME/bin/bash-powerline.sh" ] && source "$HOME/bin/bash-powerline.sh"
