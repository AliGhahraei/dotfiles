#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage dash # Fast alternative for /bin/sh
AddPackage fish

## "Add-ons" for shell
AddPackage fisher # A package manager for the fish shell
AddPackage fzf # Command-line fuzzy finder
AddPackage s-nail # Environment for sending and receiving mail



# Files
CopyFile /etc/shells
CopyFile /etc/pacman.d/hooks/dashbinsh.hook '' ali ali # Use dash as sh
CreateLink /usr/bin/sh dash
