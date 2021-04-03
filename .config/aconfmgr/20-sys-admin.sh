# Packages
AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage --foreign paru-git # "Feature packed AUR helper" :)
AddPackage gptfdisk # For cgdisk
AddPackage htop # Interactive process viewer
AddPackage tree # Visualize dirs as tree
AddPackage --foreign yadm # Yet Another Dotfiles Manager

## Paru optional deps
AddPackage bat # For colored pkgbuild printing



# Files
CopyFile /etc/paru.conf
