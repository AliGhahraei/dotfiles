#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage gnome-keyring # Stores passwords and encryption keys
AddPackage mpv # a free, open source, and cross-platform media player
AddPackage nnn # The fastest terminal file manager ever written.
AddPackage p7zip # Command-line file archiver with high compression ratio
AddPackage python-pipx # Install isolated global python apps
AddPackage feh # Fast and light imlib2-based image viewer
AddPackage xclip # Command line interface to the X11 clipboard
AddPackage xorg-xkill # Kill a client by its X resource

AddPackage xdg-utils # Provide xdg-open so apps like Emacs can find default apps
                     # (e.g. a browser)
