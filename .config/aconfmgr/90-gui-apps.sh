#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage chromium # A web browser built for speed, simplicity, and security
AddPackage firefox # Standalone web browser from mozilla.org
AddPackage kitty # A modern, hackable, featureful, OpenGL-based terminal
AddPackage qbittorrent # An advanced BitTorrent client programmed in C++
AddPackage zathura # Minimalistic document viewer
AddPackage zathura-pdf-mupdf # PDF support for Zathura (Supports PDF, ePub, and OpenXPS)
AddPackage flameshot # Powerful yet simple to use screenshot software
AddPackage steam # Valve's digital software delivery system
AddPackage udiskie # Removable disk automounter using udisks
AddPackage wine # A compatibility layer for running Windows programs
AddPackage wine-mono # Wine's built-in replacement for Microsoft's .NET Framework
AddPackage --foreign activitywatch-bin # Log what you do on your computer.
AddPackage --foreign ventoy-bin # A new multiboot USB solution (Binary)

## Route-tracker dependencies
AddPackage graphviz # Graph visualization software


# Files
## gtk3 apps use colord
CreateDir /var/lib/colord/icc '' colord colord
CopyFile /etc/group
SetFileProperty /var/lib/colord group colord
SetFileProperty /var/lib/colord owner colord
