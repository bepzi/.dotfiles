#!/bin/zsh

#
# ~/.zshrc
#

[[ -f ~/.bash_aliases ]] && emulate sh -c 'source ~/.bash_aliases'

# Shell prompt - use contrail where possible
if command -v contrail >/dev/null 2>&1; then    
    precmd() {
        PS1="$(contrail --shell "zsh" -e $? -c $HOME/.config/contrail.toml) "
    }
fi

# Import colorscheme from wal, if installed
if command -v wal >/dev/null 2>&1; then
    (wal -t -r &)
fi
