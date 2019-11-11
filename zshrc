#!/usr/bin/zsh

# $ZDOTDIR/.zshrc
#
# Executes user's commands whenever ZSH is stared as an interactive
# shell.

# Enable completion
autoload -Uz compinit
compinit

# `fish`-like syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Auto-rehash whenever pacman installs something
# See: https://wiki.archlinux.org/index.php/Zsh#On-demand_rehash
zshcache_time="$(date +%s%N)"
autoload -Uz add-zsh-hook
rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}
add-zsh-hook -Uz precmd rehash_precmd
