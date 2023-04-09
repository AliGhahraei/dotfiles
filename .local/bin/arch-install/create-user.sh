#!/bin/sh
# shellcheck source=/dev/null
. "./msg.sh"
. "./variables.sh"


msg 'Creating user'
useradd -m -s /usr/bin/"$NEW_SHELL" "$NEW_USER"


msg 'Copying sudoers config'
mkdir -p /etc/sudoers.d
cp ../../../.config/aconfmgr/files/etc/sudoers.d/config /etc/sudoers.d


msg "Setting user password"
passwd "$NEW_USER"
