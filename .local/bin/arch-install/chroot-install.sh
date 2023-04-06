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


./setup_bootloader.sh


./create-user.sh


msg "Moving scripts to the new user's home"
user_projects_location="$NEW_USER_HOME/g"
mkdir -p $user_projects_location
mv "/$INSTALLATION_SCRIPTS_MOUNTDIR_LOCATION" "$user_projects_location"
chown -R $NEW_USER $user_projects_location
