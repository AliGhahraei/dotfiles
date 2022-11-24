#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage iwd # Network manager

if ! is_main_platform; then
    AddPackage openfortivpn # An open implementation of Fortinet's proprietary PPP+SSL VPN solution
    AddPackage systemd-resolvconf # So OpenFortiVPN can set name servers and search domains

    # Files
    CopyFile /etc/openfortivpn/config.gpg
    CopyFile /etc/systemd/system/vpn.service
fi


# Files
## Iwd
CopyFile /etc/iwd/main.conf
CreateLink /etc/systemd/system/multi-user.target.wants/iwd.service \
    /usr/lib/systemd/system/iwd.service

## systemd-resolved
CreateLink /etc/systemd/system/multi-user.target.wants/systemd-resolved.service \
    /usr/lib/systemd/system/systemd-resolved.service
### Enable DNS
CreateLink /etc/systemd/system/dbus-org.freedesktop.resolve1.service \
    /usr/lib/systemd/system/systemd-resolved.service
### Provide DNS for services that read resolv.conf directly like GnuPG
CreateLink /etc/resolv.conf /run/systemd/resolve/stub-resolv.conf
