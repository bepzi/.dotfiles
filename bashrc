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
    VISUAL="$(which emacs)"; export VISUAL
else
    VISUAL="$EDITOR"; export VISUAL
fi

# Enable bash completions with git
[ -f "$HOME/.config/git-completion.bash" ] && . "$HOME/.config/git-completion.bash"

# Shell prompt - use contrail and bash-powerline where possible
if command -v contrail >/dev/null 2>&1; then    
    ps1() {
        PS1="$(contrail -e $? -c $HOME/.config/contrail.toml) "
    }

    PROMPT_COMMAND="ps1; $PROMPT_COMMAND"
else
    PS1='[\u@\h \W]\$ '
    [ -f "$HOME/bin/bash-powerline.sh" ] && . "$HOME/bin/bash-powerline.sh"
fi

# Import colorscheme from wal, if installed
if command -v wal >/dev/null 2>&1; then

    # wal-git and python-pywal are different programs now
    if pacman -Qi wal-git >/dev/null 2>&1; then
        (wal -t -r &)
    else
        # python-pywal is installed, as wal-git and python-pywal are mutually exclusive
        
        # Import colorscheme from 'wal' asynchronously
        # ( ) # Hide shell job control messages.
        (cat "$HOME/.cache/wal/sequences" &)

        # Add support for TTYs
        source "$HOME/.cache/wal/colors-tty.sh"
    fi
fi

