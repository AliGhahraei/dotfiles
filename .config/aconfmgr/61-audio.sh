#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage pamixer # Like amixer, used to set volume with key shortcut
AddPackage pipewire-pulse # PulseAudio replacement
AddPackage pulsemixer # CLI and curses mixer for pulseaudio

# Files
CopyFile /etc/group # Pipewire needs rtkit group
CreateLink /etc/systemd/user/pipewire-session-manager.service /usr/lib/systemd/user/pipewire-media-session.service
