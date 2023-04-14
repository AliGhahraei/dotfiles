#!/usr/bin/env bash
set -euo pipefail

# Files
## Make apps comply with XDG
MakeUserDir "${XDG_STATE_HOME:-$HOME/.local/state}/less"
MakeUserDir "${XDG_STATE_HOME:-$HOME/.local/state}/bash"

## Configure sudo
CopyFile /etc/sudoers.d/config
