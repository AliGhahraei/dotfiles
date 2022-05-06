#!/usr/bin/env bash
set -euo pipefail

AddPackage rbw # Unofficial Bitwarden CLI


# Files
CreatePlatformLink "$XDG_CONFIG_HOME/rbw/config.json"
