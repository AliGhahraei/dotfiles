#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign paru-git # "Feature packed AUR helper" :)
AddPackage gptfdisk # For cgdisk
AddPackage htop # Interactive process viewer
AddPackage restic # Fast, secure, efficient backup program
AddPackage tree # Visualize dirs as tree
AddPackage --foreign yadm-git # Yet Another Dotfiles Manager

## Paru optional deps
AddPackage bat # For colored pkgbuild printing

## Restic optional deps
AddPackage rclone # Mega/Box support


# Files
CopyFile /etc/paru.conf
