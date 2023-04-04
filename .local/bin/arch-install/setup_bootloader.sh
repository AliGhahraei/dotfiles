#!/bin/sh
. "./msg.sh"
. "./variables.sh"


msg "Installing systemd-boot"
bootctl install


msg "Copying bootloader config"
cp loader.conf /boot/loader/loader.conf


msg "Copying Arch boot entry"
cp arch.conf /boot/loader/entries/arch.conf
