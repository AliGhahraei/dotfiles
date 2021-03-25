# Packages
AddPackage dash # Fast alternative for /bin/sh
AddPackage fish

## "Add-ons" from shell configs
AddPackage --foreign direnv-bin # manage per-directory environments
AddPackage fzf # Command-line fuzzy finder
AddPackage s-nail # Environment for sending and receiving mail
AddPackage thefuck # Magnificent app which corrects your previous command



# Files
CopyFile /etc/shells
