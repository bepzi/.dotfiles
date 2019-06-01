#!/bin/bash

# ~/.bash_profile
#
# Only executed for login (non-interactive) shells.

[[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"

# Locale
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# PATH-related variables
export PATH="$PATH:$HOME/bin:$HOME/.bin:$HOME/documents/bin:$HOME/bin/scripts:$HOME/.cargo/bin:$HOME/.cabal/bin:$HOME/.scripts"

# Autostart X at login:
# https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
