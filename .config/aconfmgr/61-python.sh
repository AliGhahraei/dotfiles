#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage ipython # An enhanced Interactive Python shell.
AddPackage pycharm-community-edition # Python IDE for Professional Developers
AddPackage pyenv # Easily switch between multiple versions of Python
AddPackage python-doit # A task management and automation tool
AddPackage python-flit # Simplified packaging of Python modules
AddPackage python-poetry # Python dependency management and packaging made easy
AddPackage python-typer # Build great CLIs. Easy to code. Based on type hints


# Files
## Pycharm
CreateLink /usr/lib/jvm/default java-11-openjdk
CreateLink /usr/lib/jvm/default-runtime java-11-openjdk
