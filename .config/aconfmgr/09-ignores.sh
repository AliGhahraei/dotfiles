#!/usr/bin/env bash
set -euo pipefail

# General
IgnorePath '*.cache'
IgnorePath '*.lock'


# Boot
IgnorePath '/boot/*.img' # OS images
IgnorePath '/boot/vmlinuz-linux*' # Kernel executable
IgnorePath '/boot/EFI/Boot/*'
IgnorePath '/boot/EFI/BOOT/*'
IgnorePath '/boot/EFI/HP/*'
IgnorePath '/boot/EFI/Linux'
IgnorePath '/boot/EFI/Microsoft/*'
IgnorePath '/boot/EFI/tools/*'

## Systemd-boot
IgnorePath '/boot/EFI/systemd/*'
IgnorePath '/boot/loader/entries.srel'
IgnorePath '/boot/loader/random-seed'


# /etc
IgnorePath '/etc/*-' # Automatic backups for important files like passwd
IgnorePath '/etc/.updated' # Tracks last directory modification time for systemd
IgnorePath '/etc/adjtime' # Bookkeeping file used by hwclock
IgnorePath '/etc/ca-certificates/*' # Certification authority certificates
IgnorePath '/etc/credstore*' # Credential store (looks like it's used by systemd)
IgnorePath '/etc/docker/key.json'
IgnorePath '/etc/fonts/conf.d/*' # Fontconfigs should be handled by pacman
IgnorePath '/etc/hostname'
IgnorePath '/etc/machine-id' # Random identifier generated at install/boot time
IgnorePath '/etc/mkinitcpio.d/*'
IgnorePath '/etc/netctl/w*' # Netctl profiles
IgnorePath '/etc/netctl/examples/*'
IgnorePath '/etc/netctl/interfaces/*'
IgnorePath '/etc/NetworkManager/*'
IgnorePath '/etc/odbcinst.ini' # SQL server stuff
IgnorePath '/etc/os-release'
IgnorePath '/etc/pacman.d/gnupg/*'
IgnorePath '/etc/passwd'
IgnorePath '/etc/ssl/certs/*'

## Shadow
IgnorePath '/etc/gshadow' # Group passwords
IgnorePath '/etc/shadow'
IgnorePath '/etc/subgid' # Subordinate group ids
IgnorePath '/etc/subuid'

## Systemd
IgnorePath '/etc/systemd/user/sockets.target.wants/*'
IgnorePath '/etc/systemd/system/getty.target.wants/getty@tty1.service'
IgnorePath '/etc/systemd/system/multi-user.target.wants/remote-fs.target'


# Lost + found
IgnorePath '/lost+found'
IgnorePath '/lost+found/*'


# Nix
IgnorePath '/nix/*'


# /opt
IgnorePath '/opt/containerd' # Docker-related virtualization stuff
IgnorePath '/opt/containerd/*'


# /usr
## /usr/lib
IgnorePath '/usr/lib/graphviz/*' # Graphviz files
IgnorePath '/usr/lib/gdk-pixbuf-*/*' # Libnotify files
IgnorePath '/usr/lib/ghc-*/package.conf.d/*' # GHC packages
IgnorePath '/usr/lib/locale/locale-archive' # Selected locales in binary format
IgnorePath '/usr/lib/modules/*' # Kernel modules
IgnorePath '/usr/lib/udev/hwdb.bin' # Udev db to apply rules to devices
IgnorePath '/usr/lib/python*'

## /usr/share
IgnorePath '/usr/share/**/*.compiled'
IgnorePath '/usr/share/info/dir' # Info pages index
IgnorePath '/usr/share/mime/*' # Libnotify files


# /var
IgnorePath '/var/.updated' # Tracks last directory modification time for systemd

## /var/lib
IgnorePath '/var/lib/colord' # Color lib used by some unknown gtk3 app(s)
IgnorePath '/var/lib/dbus/machine-id'
IgnorePath '/var/lib/dhcpcd/*.lease' # DHCP leases
IgnorePath '/var/lib/docker/*'
IgnorePath '/var/lib/flatpak/*'
IgnorePath '/var/lib/lightdm'
IgnorePath '/var/lib/lightdm-data/*'
IgnorePath '/var/lib/NetworkManager/*'
IgnorePath '/var/lib/pacman/local/*' # Pacman's local DB
IgnorePath '/var/lib/pacman/sync/*.db' # Pacman's repository DBs
IgnorePath '/var/lib/pacman/sync/*.files' # Pacman's repository files
IgnorePath '/var/lib/pgadmin/*'
IgnorePath '/var/lib/postgres/*'
IgnorePath '/var/lib/sss/db/config.ldb' # SQL server stuff
IgnorePath '/var/lib/tpm2-tss/*' # Trusted Platform Module Software Stack API (security)
IgnorePath '/var/opt/mssql/*'

### Systemd
IgnorePath '/var/lib/machines/*'
IgnorePath '/var/lib/portables/*'
IgnorePath '/var/lib/private/*'
IgnorePath '/var/lib/systemd/*'

## /var/tmp
IgnorePath '/var/tmp/*'


# /var/log
IgnorePath '/var/log/*'
