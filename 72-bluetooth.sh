# Packages
AddPackage bluez-utils 								# Provides bluetoothctl command
AddPackage pulseaudio-bluetooth							# Bluetooth support for PulseAudio



# Files
## Enable bluetooth services
CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service
CreateLink /etc/systemd/system/dbus-org.bluez.service /usr/lib/systemd/system/bluetooth.service

## Bluetooth config
CopyFile /etc/bluetooth/main.conf
CopyFile /etc/pulse/default.pa

## Autogenerated config
CreateFile /var/lib/bluetooth/C0:E4:34:68:0C:68/settings 600 > /dev/null
SetFileProperty /var/lib/bluetooth mode 700
SetFileProperty /var/lib/bluetooth/C0:E4:34:68:0C:68 mode 700
