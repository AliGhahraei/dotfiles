#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage git
AddPackage neovim

## Python-related
AddPackage ipython # An enhanced Interactive Python shell.
AddPackage pyenv # Easily switch between multiple versions of Python
AddPackage python-doit # A task management and automation tool
AddPackage python-flit # Simplified packaging of Python modules
AddPackage python-nox # Flexible test automation for Python
AddPackage python-typer # Build great CLIs. Easy to code. Based on type hints
