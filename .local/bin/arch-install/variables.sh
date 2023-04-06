#!/usr/bin/env sh
export MOUNTDIR="/mnt"
export NEW_USER="ali"
export NEW_HOSTNAME="$NEW_USER"
export NEW_SHELL="fish"
export TIMEZONE="America/Mexico_City"
export LOCALE="en_US.UTF-8"
export KEYBOARD="us"
export ARCH_FILESYSTEM_LABEL=Arch
export EFI_FILESYSTEM_LABEL=EFI

export RELATIVE_INSTALLATION_SOURCE_PATH=".local/bin/arch-install"
export INSTALLATION_SCRIPTS_MOUNTDIR_LOCATION="var/tmp/dotfiles"
export ABSOLUTE_SCRIPTS_LOCATION="$MOUNTDIR/$INSTALLATION_SCRIPTS_MOUNTDIR_LOCATION"
export NEW_USER_HOME="/home/$NEW_USER"
