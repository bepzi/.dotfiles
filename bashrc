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
    BROWSER="$(which firefox)"
elif command -v chromium >/dev/null 2>&1; then
    BROWSER="$(which chromium)"
else
    echo "Neither Firefox nor Chromium are installed on this system! BROWSER will not be explicitly set!"
fi

if command -v emacs >/dev/null 2>&1; then
    EDITOR="$(which emacs) -nw"
elif command -v nvim >/dev/null 2>&1; then
    EDITOR="$(which nvim)"
elif command -v vim >/dev/null 2>&1; then
    EDITOR="$(which vim)"
elif command -v nano >/dev/null 2>&1; then
    EDITOR="$(which nano)"
else
    echo "No reasonable text editor is installed on this system! EDITOR will not be explicitly set!"
fi

# Emacs has to be treated a little differently here
if command -v emacs >/dev/null 2>&1; then
    export VISUAL="$(which emacs)"
else
    export VISUAL="$EDITOR"
fi

# Enable bash completions with git
[ -f "$HOME/.config/git-completion.bash" ] && . "$HOME/.config/git-completion.bash"

PS1='[\u@\h \W]\$ '
[ -f "$HOME/bin/bash-powerline.sh" ] && . "$HOME/bin/bash-powerline.sh"
