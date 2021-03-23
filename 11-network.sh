# Packages
AddPackage netctl								# Profile based systemd network management
AddPackage wpa_supplicant 							# A utility providing key negotiation for WPA wireless networks
AddPackage dhcpcd 								# RFC2131 compliant DHCP client daemon
AddPackage dialog 								# For wifi-menu



# Files
CopyFile /etc/group								# To add dhcpcd group
CopyFile /etc/resolv.conf '' systemd-resolve systemd-resolve			# After connecting to wifi
CreateLink /etc/systemd/system/sys-subsystem-net-devices-wlo1.device.wants/netctl-auto@wlo1.service /usr/lib/systemd/system/netctl-auto@.service	# Auto-connect
