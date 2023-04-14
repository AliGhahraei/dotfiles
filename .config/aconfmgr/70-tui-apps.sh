#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage mpv # a free, open source, and cross-platform media player
AddPackage nnn # The fastest terminal file manager ever written.
AddPackage p7zip # Command-line file archiver with high compression ratio
AddPackage python-pipx # Install isolated global python apps
AddPackage feh # Fast and light imlib2-based image viewer


#Files
## Feh
CreatePlatformLink "$HOME/.fehbg" "${XDG_CONFIG_HOME:-$HOME/.config}/feh/fehbg"
