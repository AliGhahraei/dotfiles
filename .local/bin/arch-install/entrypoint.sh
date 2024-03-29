#!/usr/bin/env sh
# shellcheck source=/dev/null
. "./msg.sh"
. "./variables.sh"


msg "Setting the console keyboard layout to $KEYBOARD"
loadkeys "$KEYBOARD"


msg "Verifying the boot mode"
if [ ! -d "/sys/firmware/efi/efivars" ]; then
  error_msg "Booted in non-UEFI mode, which is unsupported by this script"
  exit 1
fi


msg "Verifying the system clock"
timedatectl status


msg "Listing available devices"
lsblk


msg "Opening partitioning tool. You should at least create a root partition and\
 an EFI partition. Enter a relative device name (e.g. nvme0n1)"
read -r relative_device_name
cgdisk "/dev/$relative_device_name"


clear
msg "Re-listing devices"
lsblk


msg "Setting up EFI. Enter your relative EFI partition (e.g. nvme0n1p1).\
 WARNING! This partition will be formatted."
read -r relative_efi
efi_partition="/dev/$relative_efi"
mkfs.fat -F32 "$efi_partition" -n "$EFI_FILESYSTEM_LABEL"
mkdir -p "$MOUNTDIR/boot"
mount "$efi_partition" "$MOUNTDIR/boot"


msg "Setting up root. Enter your root's relative partition name (e.g. nvme0n1p2).\
 WARNING! This partition will be formatted."
read -r relative_root
root_partition="/dev/$relative_root"
mkfs.ext4 "$root_partition" -L "$ARCH_FILESYSTEM_LABEL"
mount "$root_partition" "$MOUNTDIR"


msg "Listing available devices after changes"
lsblk


msg "You should now format any extra partitions and mount them. When finished,\
 exit your shell (Ctrl + D) and the script will automatically continue to the\
 actual installation process."
zsh


./install.sh
