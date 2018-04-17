#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi


if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Source ~/.xprofile so that PATH, EDITOR, etc. are set
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# Restore last colorscheme and wallpaper with wal
if command -v wal >/dev/null 2>&1; then
    wal -R
fi

# Start and theme dunst
if command -v dunst >/dev/null 2>&1; then
    source "$HOME/.cache/wal/colors.sh"

    pkill dunst && \
        dunst \
            -lb "$color15" \
            -lf "$color0"  \
            -lfr "$color0" \
            -nb "$color15" \
            -nf "$color0"  \
            -nfr "$color0" \
            -cb "$color15" \
            -cf "$color9"  \
            -cfr "$color9" &
fi

# Enable numlock: See https://wiki.archlinux.org/index.php/Activating_Numlock_on_Bootup#startx
if command -v numlockx >/dev/null 2>&1; then
    numlockx &
fi

# Start window manager
exec i3
