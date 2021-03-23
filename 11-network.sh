# Packages
AddPackage netctl								# Profile based systemd network management
AddPackage wpa_supplicant 							# A utility providing key negotiation for WPA wireless networks
AddPackage dhcpcd 								# RFC2131 compliant DHCP client daemon
AddPackage dialog 								# For wifi-menu



# Files
CopyFile /etc/group								# To add dhcpcd group

## After connecting to wifi
CopyFile /etc/resolv.conf '' systemd-resolve systemd-resolve
