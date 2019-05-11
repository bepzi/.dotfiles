#!/bin/sh

# ~/.xinitrc
#
# Sourced when `startx` is run.

readonly userresources=$HOME/.Xresources
readonly usermodmap=$HOME/.Xmodmap
readonly sysresources=/etc/X11/xinit/.Xresources
readonly sysmodmap=/etc/X11/xinit/.Xmodmap

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
[ -f "$HOME/.xprofile" ] && . "$HOME/.xprofile"

# Start window manager
exec i3
