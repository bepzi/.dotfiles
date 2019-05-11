#!/usr/bin/zsh

# $ZDOTDIR/.zshrc
#
# Executes user's commands whenever ZSH is stared as an interactive
# shell.

# Enable completion, and enable prompt themes
autoload -Uz compinit promptinit
compinit
promptinit

prompt redhat

# `fish`-like syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
