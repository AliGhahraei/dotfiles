#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage netctl # Profile based systemd network management
AddPackage wpa_supplicant # A utility providing key negotiation for WPA wireless
AddPackage dhcpcd # RFC2131 compliant DHCP client daemon
AddPackage dialog # For wifi-menu



# Files
CopyFile /etc/group # To add dhcpcd group
CopyFile /etc/sysctl.d/40-ipv6.conf # Disable IPv6 until I get a new router

## Auto-connect
srcdir=/etc/systemd/system/sys-subsystem-net-devices-wlo1.device.wants/
CreateLink $srcdir/netctl-auto@wlo1.service \
    /usr/lib/systemd/system/netctl-auto@.service
