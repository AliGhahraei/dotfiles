#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage emacs # The best OS with a half-decent editor
AddPackage firefox-developer-edition # Developer Edition of Firefox web browser
AddPackage kitty # A modern, hackable, featureful, OpenGL-based terminal
AddPackage qbittorrent # An advanced BitTorrent client programmed in C++
AddPackage scrot # Simple command-line screenshot utility for X
AddPackage udiskie # Removable disk automounter using udisks
AddPackage --foreign activitywatch-bin # Log what you do on your computer.
AddPackage --foreign brave-bin # Blocks ads and trackers (binary release).
AddPackage --foreign pomotroid-bin # Simple and visually-pleasing Pomodoro timer
AddPackage --foreign ventoy-bin # A new multiboot USB solution (Binary)


## Doom Emacs dependencies

### Core
#### Required
AddPackage ripgrep
#### Optional
AddPackage fd # Improves performance for many file indexing commands in doom

### Config
AddPackage adobe-source-sans-pro-fonts # Cool variable pitch option for doom

### Modules
AddPackage pandoc # Enable doom markdown previews
AddPackage shellcheck # For shell script linting
AddPackage cmake # vterm needs it to (re)compile the executable
#### Python mode
AddPackage flake8 # The modular source code checker
AddPackage jedi-language-server # Language server for Jedi


# Files
## gtk3 apps use colord
CreateDir /var/lib/colord/icc '' colord colord
CopyFile /etc/group
SetFileProperty /var/lib/colord group colord
SetFileProperty /var/lib/colord owner colord
