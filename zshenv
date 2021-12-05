#!/usr/bin/zsh

# $ZDOTDIR/.zshenv
#
# User's environment variables. It should not contain commands that
# produce output or assume the shell is attached to a tty. Always
# sourced by ZSH for both interactive and login shells.

# Avoid duplicates in $PATH
typeset -U path
path=($path ~/bin ~/.bin ~/.cargo/bin ~/documents/bin)

export BROWSER="$(command -v firefox)"
export EDITOR="$(command -v emacs) -nw"
export VISUAL="$(command -v emacs)"

unset MAILCHECK
unset MAIL

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

setopt NULL_GLOB  # Don't complain if a glob doesn't expand to anything

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Aliases
source ~/.bash_aliases
