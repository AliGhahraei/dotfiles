#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage git
AddPackage neovim
AddPackage pycharm-community-edition # Python IDE for Professional Developers

## Hugo-related
AddPackage hugo # Fast and Flexible Static Site Generator in Go
AddPackage go # Core compiler tools for the Go programming language

## Python-related
AddPackage ipython # An enhanced Interactive Python shell.
AddPackage pyenv # Easily switch between multiple versions of Python
AddPackage python-doit # A task management and automation tool
AddPackage python-flit # Simplified packaging of Python modules
AddPackage python-nox # Flexible test automation for Python
AddPackage python-typer # Build great CLIs. Easy to code. Based on type hints


# Files
## Neovim
CreateLink /usr/bin/vi /usr/bin/nvim
CreateLink /usr/bin/vim /usr/bin/nvim

## Pycharm
CreateLink /usr/lib/jvm/default java-11-openjdk
CreateLink /usr/lib/jvm/default-runtime java-11-openjdk
