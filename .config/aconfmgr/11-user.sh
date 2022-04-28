#!/usr/bin/env bash
set -euo pipefail

# Files
## Setup Autologin
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service \
    /usr/lib/systemd/system/getty@.service
CopyFile /etc/systemd/system/getty@tty1.service.d/override.conf

## Make apps comply with XDG
MakeUserDir "$XDG_STATE_HOME/less"
MakeUserDir "$XDG_STATE_HOME/bash"

## Configure sudo
CopyFile /etc/sudoers.d/config
