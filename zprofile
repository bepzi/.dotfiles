#!/usr/bin/zsh

# $ZDOTDIR/.zprofile
#
# Executes user's commands at startup. Sourced whenever ZSH is stared
# as a login (not interactive) shell.

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
