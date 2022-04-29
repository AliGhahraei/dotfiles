#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage lightdm # A lightweight display manager
AddPackage xorg-server # Enough to run Xorg

## WM
AddPackage qtile # A full-featured, pure-Python tiling window manager

### Add-ons for qtile
AddPackage flameshot # Powerful yet simple to use screenshot software
AddPackage mypy # Check typing with qtile check
AddPackage python-xlib # Detect connected screens
AddPackage rofi # A window switcher, application launcher and dmenu replacement
AddPackage xdotool # Used by screenshot script to get window size for flameshot

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
## Lightdm
CopyFile /etc/group  # lightdm and autologin
CopyFile /etc/lightdm/Xsession
CopyFile /etc/lightdm/lightdm.conf
CreateLink /etc/systemd/system/display-manager.service \
    /usr/lib/systemd/system/lightdm.service
## Xorg
CopyFile /etc/X11/xorg.conf.d/30-touchpad.conf 755
