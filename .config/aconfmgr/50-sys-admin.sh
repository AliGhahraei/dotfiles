#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign paru-bin # "Feature packed AUR helper" :)
AddPackage ansible # Official assortment of Ansible collections
AddPackage gptfdisk # For cgdisk
AddPackage htop # Interactive process viewer
AddPackage ncdu # Disk usage analyzer with an ncurses interface
AddPackage nix # A purely functional package manager
AddPackage tree # Visualize dirs as tree

## Paru optional deps
AddPackage bat # For colored pkgbuild printing


# Files
CopyFile /etc/paru.conf
## Nix
CreateLink /etc/systemd/system/multi-user.target.wants/nix-daemon.service \
    /usr/lib/systemd/system/nix-daemon.service
CopyFile /etc/group
CreatePlatformLink "${XDG_CONFIG_HOME:-$HOME/.config}/nixpkgs/config.nix"
