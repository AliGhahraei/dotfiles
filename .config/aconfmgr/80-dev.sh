#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage git
AddPackage pycharm-community-edition # Python IDE for Professional Developers

if is_main_platform; then
    ## Hugo-related
    AddPackage hugo # Fast and Flexible Static Site Generator in Go
    AddPackage go # Core compiler tools for the Go programming language
else
    AddPackage code # The Open Source build of Visual Studio Code (vscode) editor
    AddPackage --foreign postman-bin # Build, test, and document your APIs faster
fi

## Python-related
AddPackage ipython # An enhanced Interactive Python shell.
AddPackage pyenv # Easily switch between multiple versions of Python
AddPackage python-doit # A task management and automation tool
AddPackage python-flit # Simplified packaging of Python modules
AddPackage python-nox # Flexible test automation for Python
AddPackage python-typer # Build great CLIs. Easy to code. Based on type hints


# Files
## Git
CreatePlatformLink "$XDG_CONFIG_HOME/git/platform-config"
## Pycharm
CreateLink /usr/lib/jvm/default java-11-openjdk
CreateLink /usr/lib/jvm/default-runtime java-11-openjdk
