#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage firefox # Standalone web browser from mozilla.org
AddPackage kitty # A modern, hackable, featureful, OpenGL-based terminal
AddPackage zathura # Minimalistic document viewer
AddPackage zathura-pdf-mupdf # PDF support for Zathura (Supports PDF, ePub, and OpenXPS)
AddPackage udiskie # Removable disk automounter using udisks
AddPackage --foreign activitywatch-bin # Log what you do on your computer.
AddPackage --foreign pomotroid-bin # Simple and visually-pleasing Pomodoro timer
AddPackage --foreign ventoy-bin # A new multiboot USB solution (Binary)

if is_main_platform; then
    AddPackage qbittorrent # An advanced BitTorrent client programmed in C++
    AddPackage wine # A compatibility layer for running Windows programs
    AddPackage wine-mono # Wine's built-in replacement for Microsoft's .NET Framework

    ## Route-tracker dependencies
    AddPackage graphviz # Graph visualization software

    # Files
    ## Some unknown gtk3 app(s) use(s) colord
    CreateDir /var/lib/colord/icc '' colord colord
    CopyFile /etc/group
    SetFileProperty /var/lib/colord group colord
    SetFileProperty /var/lib/colord owner colord
else
    AddPackage virtualbox # Powerful x86 virtualization for enterprise as well as home use
    AddPackage virtualbox-guest-iso # The official VirtualBox Guest Additions ISO image
    AddPackage virtualbox-host-modules-arch # Host modules for default kernel
    AddPackage --foreign brave-bin # Web browser that blocks ads and trackers by default (binary release)
    AddPackage --foreign realvnc-vnc-viewer # VNC remote desktop client software by RealVNC

    # Files
    CopyFile /etc/group # Virtualbox's group
fi
