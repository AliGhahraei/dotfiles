#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage bitwarden # A secure and free password manager for all of your devices
AddPackage chromium # A web browser built for speed, simplicity, and security
AddPackage firefox # Standalone web browser from mozilla.org
AddPackage kitty # A modern, hackable, featureful, OpenGL-based terminal
AddPackage spotify-launcher # Client for spotify's apt repository in Rust for Arch Linux
AddPackage udiskie # Removable disk automounter using udisks
AddPackage --foreign activitywatch-bin # Log what you do on your computer.

if is_main_platform; then
    AddPackage qbittorrent # An advanced BitTorrent client programmed in C++
    AddPackage steam # Valve's digital software delivery system
    AddPackage wine # A compatibility layer for running Windows programs
    AddPackage wine-mono # Wine's built-in replacement for Microsoft's .NET Framework

    ## Route-tracker dependencies
    AddPackage graphviz # Graph visualization software
fi
