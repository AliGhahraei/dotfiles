#!/bin/sh
# shellcheck source=/dev/null
. "./msg.sh"
. "./variables.sh"


msg 'Creating user'
useradd -m -G wheel -s /usr/bin/"$NEW_SHELL" "$NEW_USER"


msg "Setting user password"
passwd "$NEW_USER"
