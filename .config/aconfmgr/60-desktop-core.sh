#!/usr/bin/env bash
set -euo pipefail

# Packages
## Xorg
AddPackage xorg-server # Enough to run Xorg
AddPackage xorg-xinit # Enables startx to start Xorg

## WM
AddPackage qtile # A full-featured, pure-Python tiling window manager
AddPackage mypy # Check typing with qtile check
AddPackage python-iwlib # Used by wlan widget
AddPackage rofi # A window switcher, application launcher and dmenu replacement

## Desktop notifications
AddPackage libnotify # Library for notifications, needs server
AddPackage dunst # Notification daemon/server

## Misc
AddPackage hsetroot # Background image setter
AddPackage picom # X compositor for sweet transparency



# Files
CopyFile /etc/X11/xorg.conf.d/30-touchpad.conf 755
