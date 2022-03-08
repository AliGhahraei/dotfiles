#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage emacs # The best OS with a half-decent editor
AddPackage chromium # A web browser built for speed, simplicity, and security
AddPackage firefox # Standalone web browser from mozilla.org
AddPackage kitty # A modern, hackable, featureful, OpenGL-based terminal
AddPackage qbittorrent # An advanced BitTorrent client programmed in C++
AddPackage qpdfview # A tabbed PDF viewer using the poppler library.
AddPackage scrot # Simple command-line screenshot utility for X
AddPackage steam # Valve's digital software delivery system
AddPackage udiskie # Removable disk automounter using udisks
AddPackage wine # A compatibility layer for running Windows programs
AddPackage wine-mono # Wine's built-in replacement for Microsoft's .NET Framework
AddPackage --foreign activitywatch-bin # Log what you do on your computer.
AddPackage --foreign ventoy-bin # A new multiboot USB solution (Binary)


## Doom Emacs dependencies

### Core
#### Required
AddPackage ripgrep
#### Optional
AddPackage fd # Improves performance for many file indexing commands in doom

### Config
AddPackage adobe-source-sans-fonts # Cool variable pitch option for doom

### Modules
AddPackage pandoc # Enable doom markdown previews
AddPackage shellcheck # For shell script linting
AddPackage cmake # vterm needs it to (re)compile the executable
#### Python mode
AddPackage flake8 # The modular source code checker
AddPackage jedi-language-server # Language server for Jedi

## Route-tracker dependencies
AddPackage graphviz # Graph visualization software


# Files
## gtk3 apps use colord
CreateDir /var/lib/colord/icc '' colord colord
CopyFile /etc/group
SetFileProperty /var/lib/colord group colord
SetFileProperty /var/lib/colord owner colord
