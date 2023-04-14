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
mkdir -p "$DOTFILES_REPO"
cp -r "/$INSTALLATION_SCRIPTS_MOUNTDIR_LOCATION/.git" "$DOTFILES_REPO"
git -C $DOTFILES_REPO config --bool core.bare true
chown -R $NEW_USER $DOTFILES_REPO


msg "Preparing post-install abbreviation"
cmd="abbr --add post-install git --git-dir="$DOTFILES_REPO"\
 --work-tree=$NEW_USER_HOME checkout && ansible-playbook\
 $user_projects_location/dotfiles/.config/themis/ansible/configure.yml"
sudo -i -u ali  echo "$cmd" > "$NEW_USER_HOME/.config/fish/config.fish"


msg "Preparing greeting"
sudo -i -u ali set -U fish_greeting "Run post-install to configure the system"
