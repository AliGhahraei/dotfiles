# Packages
## Desktop notifications
AddPackage libnotify								# Library for notifications, needs server
AddPackage dunst								# Notification daemon/server

## Xorg
AddPackage xorg-server								# Enough to run Xorg
AddPackage xorg-xinit								# Enables startx to start Xorg

# WM
AddPackage xmonad
AddPackage xmonad-contrib							# Xmonad add-ons used in my config
AddPackage dmenu								# Command runner
AddPackage xmobar 								# Minimalistic Text Based Status Bar



# Files
CopyFile /etc/X11/xorg.conf.d/30-touchpad.conf 755
