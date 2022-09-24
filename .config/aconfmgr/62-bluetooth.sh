#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage blueman # GTK+ Bluetooth Manager


# Files
## Enable bluetooth services
CreateLink /etc/systemd/system/dbus-org.bluez.service \
    /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service \
    /usr/lib/systemd/system/bluetooth.service
