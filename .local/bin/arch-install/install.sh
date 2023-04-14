#!/usr/bin/env sh
# shellcheck source=/dev/null
. "./msg.sh"
. "./variables.sh"


msg "Installing essential packages. This will take a while"
pacstrap "$MOUNTDIR" base base-devel linux-lts linux-firmware ansible iwd vim "$NEW_SHELL"


msg "Generating fstab"
genfstab -L "$MOUNTDIR" >> "$MOUNTDIR"/etc/fstab


msg "About to open /etc/fstab so you can verify it. Press enter to continue"
read -r _
vim "$MOUNTDIR/etc/fstab"


msg "Copying installation scripts to the mount directory"
mkdir -p "$ABSOLUTE_SCRIPTS_LOCATION"
cp -R ../../.. "$ABSOLUTE_SCRIPTS_LOCATION"


msg "Entering chroot"
arch-chroot "$MOUNTDIR" sh -c \
 "cd /$INSTALLATION_SCRIPTS_MOUNTDIR_LOCATION\
/$RELATIVE_INSTALLATION_SOURCE_PATH\
 && ./chroot-install.sh"


msg "You should now restart into the new system, login and follow\
 the instructions that will be shown"
