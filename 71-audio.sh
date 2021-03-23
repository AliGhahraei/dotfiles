# Packages
AddPackage pamixer 								# Like amixer, used to set volume with key shortcut
AddPackage pulseaudio 								# A featureful, general-purpose sound server
AddPackage pulseaudio-alsa 							# ALSA Configuration for PulseAudio
AddPackage pulsemixer 								# CLI and curses mixer for pulseaudio

# Files
CopyFile /etc/group								# Pulseaudio changes
