#!/usr/bin/env sh
# shellcheck source=/dev/null
. "./msg.sh"
. "./variables.sh"

installation_scripts_mountdir_location="var/tmp/scripts"
absolute_scripts_location="$MOUNTDIR/$installation_scripts_mountdir_location"


msg "Installing essential packages. This will take a while"
pacstrap "$MOUNTDIR" base base-devel linux linux-firmware grub efibootmgr os-prober "$NEW_SHELL"


msg "Generating fstab"
genfstab -L "$MOUNTDIR" >> "$MOUNTDIR"/etc/fstab


msg "About to open /etc/fstab so you can verify it. Press enter to continue"
read -r _
vim "$MOUNTDIR/etc/fstab"


msg "Copying installation scripts to the mount directory"
mkdir -p "$absolute_scripts_location"
cp -R .. "$absolute_scripts_location"


msg "Entering chroot"
arch-chroot "$MOUNTDIR" sh -c \
  "cd /$installation_scripts_mountdir_location/arch-install \
  && ./chroot-install.sh"


msg "Moving scripts to the new user's home"
mv "$absolute_scripts_location" "$MOUNTDIR/home/$NEW_USER"


msg "DONE!"
