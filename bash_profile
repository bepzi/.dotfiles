#!/bin/bash

#
# ~/.bash_profile
#

# Turn on Num Lock
setleds -D +num

# Auto-start X server
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
