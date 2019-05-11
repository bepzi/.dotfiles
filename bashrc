#!/bin/bash

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
unset MAIL

# Don't put duplicate lines or lines starting with a space in the
# history.
HISTCONTROL=ignoreboth

[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"

if command -v firefox >/dev/null 2>&1; then
    BROWSER="$(command -v firefox)"
elif command -v chromium >/dev/null 2>&1; then
    BROWSER="$(command -v chromium)"
else
    BROWSER=""
fi
export BROWSER

if command -v emacs >/dev/null 2>&1; then
    EDITOR="$(command -v emacs) -nw"
elif command -v nvim >/dev/null 2>&1; then
    EDITOR="$(command -v nvim)"
elif command -v vim >/dev/null 2>&1; then
    EDITOR="$(command -v vim)"
else
    EDITOR="$(command -v nano)"
fi

# Emacs has to be treated a little differently here
if command -v emacs >/dev/null 2>&1; then
    VISUAL="$(command -v emacs)"
else
    VISUAL="$EDITOR"
fi
export VISUAL

# Enable bash completions with git
[ -f "$HOME/.config/git-completion.bash" ] && . "$HOME/.config/git-completion.bash"

PS1='[\u@\h \W]\$ '
[ -f "$HOME/bin/bash-powerline.sh" ] && . "$HOME/bin/bash-powerline.sh"
