#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage refind # Boot manager



# Files
CopyFile /boot/EFI/refind/manual.conf 755 # Manual boot entries
CopyFile /boot/EFI/refind/refind.conf 755 # General config
CreateDir /boot/EFI/tools # Additional tools (?) (maybe not created by refind)
CopyFile /boot/refind_linux.conf 755 # Boot flags for linux
