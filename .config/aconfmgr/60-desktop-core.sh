# Packages
## Xorg
AddPackage xorg-server # Enough to run Xorg
AddPackage xorg-xinit # Enables startx to start Xorg

## WM
AddPackage dmenu # Command runner
AddPackage trayer # lightweight GTK2-based systray for UNIX desktop
AddPackage xmonad
AddPackage xmonad-contrib # Xmonad add-ons used in my config
AddPackage xmobar # Minimalistic Text Based Status Bar

## Desktop notifications
AddPackage libnotify # Library for notifications, needs server
AddPackage dunst # Notification daemon/server

## Misc
AddPackage hsetroot # Background image setter
AddPackage picom # X compositor for sweet transparency



# Files
CopyFile /etc/X11/xorg.conf.d/30-touchpad.conf 755
