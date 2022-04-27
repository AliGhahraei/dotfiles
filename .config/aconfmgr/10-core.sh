#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage base
AddPackage linux
AddPackage linux-firmware
AddPackage reflector # Retrieve and filter the latest Pacman mirror list.
AddPackageGroup base-devel

## Reflector optional dependencies
AddPackage rsync # Rate rsync mirrors


# Files
CopyFile /etc/arch-release
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

## Systemd
CreateDir /var/lib/machines 700
CreateDir /var/lib/portables 700
CreateDir /var/lib/private 700

## User
### Setup Autologin
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service \
    /usr/lib/systemd/system/getty@.service
CopyFile /etc/systemd/system/getty@tty1.service.d/override.conf
### Make apps comply with XDG
MakeUserDir "$XDG_STATE_HOME/less"
MakeUserDir "$XDG_STATE_HOME/bash"

### Configure sudo
CopyFile /etc/sudoers.d/config
