#!/bin/sh
# shellcheck source=/dev/null
. "./msg.sh"
. "./variables.sh"


msg "Setting timezone"
ln -sf /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime


msg "Syncing hardware clock"
hwclock --systohc


msg "Generating locales"
sed -i "/$LOCALE/s/^#//" /etc/locale.gen
locale-gen


msg "Creating locale.conf"
echo "LANG=$LOCALE" > /etc/locale.conf


msg "Setting hostname"
echo "$NEW_HOSTNAME" > /etc/hostname


msg "Setting root password"
passwd


msg "Installing GRUB"
sed -i "/GRUB_DISABLE_OS_PROBER=false/s/^#//" /etc/locale.gen
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg


./create-user.sh
