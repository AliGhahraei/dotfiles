#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage chromium # A web browser built for speed, simplicity, and security
AddPackage firefox # Standalone web browser from mozilla.org
AddPackage kitty # A modern, hackable, featureful, OpenGL-based terminal
AddPackage zathura # Minimalistic document viewer
AddPackage zathura-pdf-mupdf # PDF support for Zathura (Supports PDF, ePub, and OpenXPS)
AddPackage flameshot # Powerful yet simple to use screenshot software
AddPackage udiskie # Removable disk automounter using udisks
AddPackage --foreign activitywatch-bin # Log what you do on your computer.
AddPackage --foreign ventoy-bin # A new multiboot USB solution (Binary)

if is_main_platform; then
    AddPackage qbittorrent # An advanced BitTorrent client programmed in C++
    AddPackage steam # Valve's digital software delivery system
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
    AddPackage --foreign realvnc-vnc-viewer # VNC remote desktop client software by RealVNC
    AddPackage --foreign slack-desktop # Slack Desktop (Beta) for Linux
    AddPackage --foreign teams # Microsoft Teams for Linux is your chat-centered workspace in Office 365

    # Files
    CopyFile /etc/group # Virtualbox's group
fi
