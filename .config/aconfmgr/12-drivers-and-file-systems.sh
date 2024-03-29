#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage exfat-utils # Utilities for exFAT file system
AddPackage intel-media-driver # Intel Media Driver for VAAPI — Broadwell+ iGPUs
AddPackage libva-utils # vainfo shows if hardware acceleration is enabled
AddPackage ntfs-3g # NTFS filesystem driver and utilities
