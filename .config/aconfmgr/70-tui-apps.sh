#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage emacs # The best OS with a half-decent editor
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

## Doom Emacs dependencies
### Core
#### Required
AddPackage ripgrep
#### Optional
AddPackage fd # Improves performance for many file indexing commands in doom
### Config
AddPackage adobe-source-sans-fonts # Cool variable pitch option for doom
### Modules
AddPackage marked # A markdown parser built for speed
AddPackage shellcheck # For shell script linting
AddPackage cmake # vterm needs it to (re)compile the executable
#### Python mode
AddPackage flake8 # The modular source code checker
AddPackage jedi-language-server # Language server for Jedi


#Files
## Doom Emacs
CreateLink /usr/bin/vi $SCRIPTS/miscellaneous/emacs-term
CreateLink /usr/bin/vim $SCRIPTS/miscellaneous/emacs-term
