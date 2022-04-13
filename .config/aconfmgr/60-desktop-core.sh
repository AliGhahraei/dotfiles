#!/usr/bin/env bash
set -euo pipefail

# Packages
## Xorg
AddPackage xorg-server # Enough to run Xorg
AddPackage xorg-xinit # Enables startx to start Xorg

## WM
AddPackage qtile # A full-featured, pure-Python tiling window manager
AddPackage mypy # Check typing with qtile check
AddPackage rofi # A window switcher, application launcher and dmenu replacement
AddPackage xdotool # Used by screenshot script

## Desktop notifications
AddPackage libnotify # Library for notifications, needs server
AddPackage dunst # Notification daemon/server

## Qt
AddPackage kvantum # SVG-based theme engine for Qt5/6 (including config tool and extra themes)
AddPackage qt5ct # Qt5 Configuration Utility
AddPackage qt6ct # Qt 6 Configuration Utility

## Misc
AddPackage picom # X compositor for sweet transparency



# Files
CopyFile /etc/X11/xorg.conf.d/30-touchpad.conf 755
