#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage bluez # Daemons for the bluetooth protocol stack
AddPackage bluez-utils # For bluetoothctl



# Files
## Enable bluetooth services
CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service \
    /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/dbus-org.bluez.service \
    /usr/lib/systemd/system/bluetooth.service
CreateLink \
    /etc/systemd/user/pipewire.service.wants/pipewire-media-session.service \
    /usr/lib/systemd/user/pipewire-media-session.service

## Bluetooth config
CopyFile /etc/bluetooth/main.conf
