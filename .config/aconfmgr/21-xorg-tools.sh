#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage xclip # Command line interface to the X11 clipboard
AddPackage xdg-utils # Provide xdg-open so default apps can be used for specific
                     # filetypes (e.g. a browser for HTML)
AddPackage xorg-xkill # Kill a client by its X resource
