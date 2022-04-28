#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage pamixer # Like amixer, used to set volume with key shortcut
AddPackage pipewire-pulse # PulseAudio replacement
AddPackage pulsemixer # CLI and curses mixer for pulseaudio

if is_main_platform; then
    ## Wine game audio
    AddPackage lib32-pipewire # Low-latency audio/video router and processor - 32-bit client library
    AddPackage pipewire-alsa # Low-latency audio/video router and processor - ALSA configuration
fi


# Files
CopyFile /etc/group # Pipewire needs rtkit group
CreateLink /etc/systemd/user/pipewire-session-manager.service /usr/lib/systemd/user/pipewire-media-session.service
