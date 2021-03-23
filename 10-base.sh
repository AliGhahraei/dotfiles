# Packages
AddPackage base
AddPackage linux
AddPackage linux-firmware



# Files
CopyFile /etc/fstab
CopyFile /etc/group
CopyFile /etc/hosts
CopyFile /etc/locale.conf
CopyFile /etc/locale.gen
CreateLink /etc/localtime /usr/share/zoneinfo/America/Mexico_City
CopyFile /etc/pacman.d/mirrorlist
CopyFile /etc/resolv.conf '' systemd-resolve systemd-resolve			# DNS file
CopyFile /etc/shells
CopyFile /etc/sudoers

## Setup Autologin
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
CopyFile /etc/systemd/system/getty@tty1.service.d/override.conf

## Sudo
CreateFile /var/db/sudo/lectured/ali 600 '' ali > /dev/null			# Remove nagging when running sudo

## Systemd
CreateDir /var/lib/machines 700
CreateDir /var/lib/portables 700
CreateDir /var/lib/private 700
