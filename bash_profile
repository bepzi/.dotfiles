#
# ~/.bash_profile
#

# Turn on Num Lock
setleds -D +num

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart X at login: https://wiki.archlinux.org/index.php/Xinit#Autostart_X_at_login
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  exec startx
fi
