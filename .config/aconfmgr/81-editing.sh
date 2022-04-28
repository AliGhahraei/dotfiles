#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage emacs # The best OS with a half-decent editor

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


# Files
## Doom Emacs
CreateLink /usr/bin/vi $SCRIPTS/miscellaneous/emacs-term
CreateLink /usr/bin/vim $SCRIPTS/miscellaneous/emacs-term
