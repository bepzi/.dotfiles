#!/bin/bash

# ~/.bash_aliases
#
# Provides aliases for shell commands

alias ls='ls --color=auto'
alias diff='diff --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias shutdown='killall firefox && sync && history -a; shutdown -h now'
alias reboot='killall firefox && sync && history -a; reboot'

alias xscreensaver='xscreensaver -no-splash'

alias python='rlwrap python'
alias ocaml='rlwrap ocaml'

# Jump to the git repository root
alias groot='cd "$(git rev-parse --show-toplevel)"'

alias mkdir='mkdir -p'
alias cp='cp -r'

# Change keyboard layout
alias aoeu='setxkbmap dvorak'
alias asdf='setxkbmap us'

alias scrot='maim'

# Rather than learn tmux, this command starts a new instance of
# `alacritty` in the current working directory
# See: https://superuser.com/a/705448
alias alacpy='alacritty --working-directory "$(pwd)" &>/dev/null &; disown'

# Colors for man pages in `less`
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
