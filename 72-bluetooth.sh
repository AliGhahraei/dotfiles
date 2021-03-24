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
