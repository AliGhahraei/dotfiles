#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign paru-bin # "Feature packed AUR helper" :)
AddPackage gptfdisk # For cgdisk
AddPackage htop # Interactive process viewer
AddPackage ncdu # Disk usage analyzer with an ncurses interface
AddPackage nix # A purely functional package manager
AddPackage tree # Visualize dirs as tree

# Missing paru dependency
AddPackage openssl-1.1
## Paru optional deps
AddPackage bat # For colored pkgbuild printing


# Files
CopyFile /etc/paru.conf
## Nix
CreateLink /etc/systemd/system/multi-user.target.wants/nix-daemon.service \
    /usr/lib/systemd/system/nix-daemon.service
CopyFile /etc/group
CreatePlatformLink "$XDG_CONFIG_HOME/nixpkgs/config.nix"
