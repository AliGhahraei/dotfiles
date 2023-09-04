#!/usr/bin/env bash
set -euo pipefail

# Files
CopyFile /boot/loader/entries/arch.conf 755
CopyFile /boot/loader/loader.conf 755
