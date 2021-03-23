# Boot
IgnorePath '/boot/*.img'							# OS images
IgnorePath '/boot/System\ Volume\ Information'					# M$ stuff for restoration
IgnorePath '/boot/vmlinuz-linux'						# Kernel executable

## /boot/EFI
IgnorePath '/boot/EFI/Boot/*'
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
IgnorePath '/etc/*-'								# Automatic backups for important files
IgnorePath '/etc/*.cache'
IgnorePath '/etc/*.lock'
IgnorePath '/etc/adjtime'							# Bookkeeping file used by hwclock
IgnorePath '/etc/ca-certificates/*'
IgnorePath '/etc/gshadow'							# Group passwords
IgnorePath '/etc/hostname'
IgnorePath '/etc/machine-id'							# Random identifier generated at install/boot time
IgnorePath '/etc/mkinitcpio.d/*'
IgnorePath '/etc/os-release'
IgnorePath '/etc/pacman.d/gnupg/*'
IgnorePath '/etc/passwd'
IgnorePath '/etc/shadow'
IgnorePath '/etc/ssl/certs/*'

# Systemd
IgnorePath '/etc/systemd/system/multi-user.target.wants/*'
IgnorePath '/etc/systemd/user/sockets.target.wants/*'


# Lost + found
IgnorePath '/lost+found/*'


# /usr
IgnorePath '/usr/lib/locale/locale-archive'					# Selected locales in binary format for speed
IgnorePath '/usr/lib/modules/*'							# Kernel modules
IgnorePath '/usr/lib/udev/hwdb.bin'						# Udev db to apply rules to devices
IgnorePath '/usr/share/info/dir'						# Info pages index


# /var/lib
IgnorePath '/var/lib/dbus/machine-id'
IgnorePath '/var/lib/pacman/local/*'						# Pacman's local DB
IgnorePath '/var/lib/pacman/sync/*.db'						# Pacman's repository DBs

# Systemd
IgnorePath '/var/lib/machines/*'
IgnorePath '/var/lib/portables/*'
IgnorePath '/var/lib/private/*'
IgnorePath '/var/lib/systemd/*'


# /var/log
IgnorePath '/var/log/*'
