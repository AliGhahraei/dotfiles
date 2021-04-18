# General
IgnorePath '*.cache'
IgnorePath '*.lock'


# Boot
IgnorePath '/boot/*.img' # OS images
IgnorePath '/boot/System\ Volume\ Information' # M$ stuff for restoration
IgnorePath '/boot/vmlinuz-linux' # Kernel executable

## /boot/EFI
IgnorePath '/boot/EFI/Boot/*'
IgnorePath '/boot/EFI/HP/*'
IgnorePath '/boot/EFI/Microsoft/*'
IgnorePath '/boot/EFI/tools/*'

### Refind boot manager
IgnorePath '/boot/EFI/refind/*.efi'
IgnorePath '/boot/EFI/refind/BOOT.CSV'
IgnorePath '/boot/EFI/refind/icons/*'
IgnorePath '/boot/EFI/refind/icons-backup/*'
IgnorePath '/boot/EFI/refind/keys'
IgnorePath '/boot/EFI/refind/vars/*'


# /etc
IgnorePath '/etc/*-' # Automatic backups for important files
IgnorePath '/etc/.updated' # Systemd file that tracks last modification time
IgnorePath '/etc/adjtime' # Bookkeeping file used by hwclock
IgnorePath '/etc/ca-certificates/*'
IgnorePath '/etc/fonts/conf.d/*' # Fontconfigs should be handled by pacman
IgnorePath '/etc/gshadow' # Group passwords
IgnorePath '/etc/hostname'
IgnorePath '/etc/machine-id' # Random identifier generated at install/boot time
IgnorePath '/etc/mkinitcpio.d/*'
IgnorePath '/etc/netctl/*' # Netctl profiles and other files
IgnorePath '/etc/os-release'
IgnorePath '/etc/pacman.d/gnupg/*'
IgnorePath '/etc/passwd'
IgnorePath '/etc/resolv.conf' # Managed by filesystem package (base dependency)
IgnorePath '/etc/shadow'
IgnorePath '/etc/ssl/certs/*'

# Systemd
IgnorePath '/etc/systemd/system/multi-user.target.wants/*'
IgnorePath '/etc/systemd/user/sockets.target.wants/*'


# Lost + found
IgnorePath '/lost+found/*'


# /usr
IgnorePath '/usr/lib/locale/locale-archive' # Selected locales in binary format
IgnorePath '/usr/lib/modules/*' # Kernel modules
IgnorePath '/usr/lib/udev/hwdb.bin' # Udev db to apply rules to devices

## /usr/lib
IgnorePath '/var/lib/colord/*' # Added by termite
IgnorePath '/usr/lib/ghc-*/package.conf.d/*' # GHC packages
IgnorePath '/usr/lib/gdk-pixbuf-*/*' # Libnotify files

## /usr/share
IgnorePath '/usr/share/**/*.compiled'
IgnorePath '/usr/share/info/dir' # Info pages index
IgnorePath '/usr/share/mime/*' # Libnotify files


# /var
IgnorePath '/var/.updated' # Systemd file that tracks last modification time

## /var/lib
IgnorePath '/var/lib/dbus/machine-id'
IgnorePath '/var/lib/dhcpcd/*.lease' # DHCP leases
IgnorePath '/var/lib/pacman/local/*' # Pacman's local DB
IgnorePath '/var/lib/pacman/sync/*.db' # Pacman's repository DBs
IgnorePath '/var/lib/pacman/sync/*.files' # Pacman's repository files

### Systemd
IgnorePath '/var/lib/machines/*'
IgnorePath '/var/lib/portables/*'
IgnorePath '/var/lib/private/*'
IgnorePath '/var/lib/systemd/*'

## /var/tmp
IgnorePath '/var/tmp/*'


# /var/log
IgnorePath '/var/log/*'
