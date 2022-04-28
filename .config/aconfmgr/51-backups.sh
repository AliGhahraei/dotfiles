#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage restic # Fast, secure, efficient backup program

if is_main_platform; then
    AddPackage borg # Deduplicating backup program with compression and encryption
fi

## Restic optional deps
AddPackage rclone # Manage cloud files
