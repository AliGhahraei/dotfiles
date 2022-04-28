#!/usr/bin/env bash
set -euo pipefail

# Packages
AddPackage git

if is_main_platform; then
    ## Hugo-related
    AddPackage hugo # Fast and Flexible Static Site Generator in Go
    AddPackage go # Core compiler tools for the Go programming language
else
    AddPackage code # The Open Source build of Visual Studio Code (vscode) editor
    AddPackage docker # Pack, ship and run any application as a lightweight container
    AddPackage docker-compose # Fast, isolated development environments using Docker
    AddPackage --foreign mssql-server # Microsoft SQL Server for Linux
    AddPackage --foreign mssql-tools # Microsoft® SQL Server® Tools for Linux
    AddPackage --foreign postman-bin # Build, test, and document your APIs faster

    ## JS-related
    AddPackage npm # A package manager for javascript
    ## SQL Server dependencies
    AddPackage --foreign libldap24 # Lightweight Directory Access Protocol (LDAP) client libraries
fi


# Files
## Docker
CopyFile /etc/group # docker / SQL server group
## Git
CreatePlatformLink "$XDG_CONFIG_HOME/git/platform-config"
