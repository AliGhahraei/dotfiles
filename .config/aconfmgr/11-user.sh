#!/usr/bin/env bash
set -euo pipefail

# Files
## Make apps comply with XDG
MakeUserDir "$XDG_STATE_HOME/less"
MakeUserDir "$XDG_STATE_HOME/bash"

## Configure sudo
CopyFile /etc/sudoers.d/config
