#!/bin/zsh

#
# ~/.zshrc
#

[[ -f ~/.bash_aliases ]] && emulate sh -c 'source ~/.bash_aliases'

precmd() {
    PS1="$(contrail -e $? -z -c $HOME/documents/config.toml) "
}

# Import colorscheme from 'wal'
(wal -r &)
