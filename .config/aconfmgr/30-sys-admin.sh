#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign paru-bin # "Feature packed AUR helper" :)
AddPackage gptfdisk # For cgdisk
AddPackage htop # Interactive process viewer
AddPackage ncdu # Disk usage analyzer with an ncurses interface
AddPackage restic # Fast, secure, efficient backup program
AddPackage tree # Visualize dirs as tree

if is_main_platform; then
    AddPackage borg # Deduplicating backup program with compression and encryption
fi

## Paru optional deps
AddPackage bat # For colored pkgbuild printing

## Restic optional deps
AddPackage rclone # Mega/Box support


# Files
CopyFile /etc/paru.conf
