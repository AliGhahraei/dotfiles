#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage networkmanager # Network connection manager and user applications
AddPackage nm-connection-editor # NetworkManager GUI connection editor and widgets
AddPackage network-manager-applet # Applet for managing network connections

# Files
## Network manager
CreateLink /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service \
    /usr/lib/systemd/system/NetworkManager-dispatcher.service
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service \
    /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service \
    /usr/lib/systemd/system/NetworkManager-wait-online.service
