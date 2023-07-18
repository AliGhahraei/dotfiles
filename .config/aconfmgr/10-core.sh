#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage base
AddPackage base-devel
AddPackage linux-lts
AddPackage linux-firmware
AddPackage reflector # Retrieve and filter the latest Pacman mirror list.

## Reflector optional dependencies
AddPackage rsync # Rate rsync mirrors


# Files
CopyFile /etc/fstab
CopyFile /etc/group
CopyFile /etc/hosts
CopyFile /etc/locale.conf
CopyFile /etc/locale.gen
CreateLink /etc/localtime /usr/share/zoneinfo/America/Mexico_City
CopyFile /etc/pacman.conf
CopyFile /etc/pacman.d/mirrorlist.reflector
CopyFile /etc/xdg/reflector/reflector.conf
CopyFile /etc/shells
CopyFile /etc/systemd/logind.conf.d/power-button.conf

## Systemd
CreateDir /var/lib/machines 700
CreateDir /var/lib/portables 700
CreateDir /var/lib/private 700
