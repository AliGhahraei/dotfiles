#!/bin/sh

#Defaults
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

#-------------------------------Personal---------------------------------

setxkbmap en

/home/ali/.fehbg

# Set cursor as an arrow
xsetroot -cursor_name left_ptr &

# Make DISPLAY and XAUTHORITY available to systemd
sh /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --widthtype percent --height 17 --margin 350 --transparent true --tint 0x1C1E1F  --width 8 &

# Compositor (for transparency)
picom &

# Emacs
doom run &

# exec wm
exec xmonad
