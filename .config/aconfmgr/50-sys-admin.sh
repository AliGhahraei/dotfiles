#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign paru-bin # "Feature packed AUR helper" :)
AddPackage gptfdisk # For cgdisk
AddPackage htop # Interactive process viewer
AddPackage ncdu # Disk usage analyzer with an ncurses interface
AddPackage tree # Visualize dirs as tree

## Paru optional deps
AddPackage bat # For colored pkgbuild printing


# Files
CopyFile /etc/paru.conf
