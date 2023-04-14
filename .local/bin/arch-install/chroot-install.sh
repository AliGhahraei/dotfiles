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


msg "Copying scripts to the new user's home"
mkdir -p "$DOTFILES_DESTINATION"
cp -r "/$INSTALLATION_SCRIPTS_MOUNTDIR_LOCATION/.git" "$DOTFILES_DESTINATION"
git --git-dir=$DOTFILES_DESTINATION config --bool core.bare true
chown -R $NEW_USER $DOTFILES_DESTINATION


msg "Preparing post-install abbreviation"
cmd="abbr --add post-install ansible-playbook $user_projects_location/dotfiles\
/.config/themis/ansible/configure.yml"
sudo -i -u ali  echo "$cmd" > "$NEW_USER_HOME/.config/fish/config.fish"


msg "Preparing greeting"
sudo -i -u ali set -U fish_greeting "Run post-install to configure the system"
