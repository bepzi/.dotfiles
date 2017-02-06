#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Should any chained commands fail, exit with error
set -o pipefail

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Append to the history file, don't overwrite it
shopt -s histappend

# Check the window size after each command and, if necessary, update
# the values of LINES and COLUMNS.
shopt -s checkwinsize

# This hasn't been necessary for over a decade
unset MAILCHECK

# Don't put duplicate lines or lines starting with a space in the
# history.
HISTCONTROL=ignoreboth

[ -f "$HOME/.bash_aliases" ] && source "$HOME/.bash_aliases"

PS1='[\u@\h \W]\$ '

BROWSER=$(which firefox || which chromium)
EDITOR=$(which emacs || which nvim || which vim)

[ -f "$HOME/bin/bash-powerline.sh" ] && source "$HOME/bin/bash-powerline.sh"
