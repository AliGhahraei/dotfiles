#!/usr/bin/env bash
set -euo pipefail

if is_main_platform; then
    # Packages
    AddPackage refind # Boot manager

    # Files
    CopyFile /boot/loader/entries/arch.conf 755
    CopyFile /boot/loader/loader.conf 755
else
    # Packages
    AddPackage efibootmgr # Boot manager

    # Files
    CopyFile /etc/machine-info # Kernel layout apparently used by efibootmgr
fi
