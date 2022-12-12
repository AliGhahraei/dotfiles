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
    AddPackage dotnet-sdk # The .NET Core SDK
    AddPackage openssh # Premier connectivity tool for remote login with the SSH protocol
    AddPackage postgresql # Sophisticated object-relational DBMS
    AddPackage --foreign dotnet-sdk-5.0-bin # The .NET Core SDK version 5.0 (binary) - End of life
    AddPackage --foreign mssql-server # Microsoft SQL Server for Linux
    AddPackage --foreign mssql-tools # Microsoft® SQL Server® Tools for Linux
    AddPackage --foreign postman-bin # Build, test, and document your APIs faster

    ## Kafka-related
    AddPackage jdk8-openjdk # OpenJDK Java 8 development kit
    AddPackage librdkafka # The Apache Kafka C/C++ library
    AddPackage ts-node # TypeScript execution and REPL for node.js, with source map support
    ## JS-related
    AddPackage npm # A package manager for javascript
    AddPackage pm2 # Production process manager for Node.JS applications with a built-in load balancer
    ## SQL Server dependencies
    AddPackage --foreign libldap24 # Lightweight Directory Access Protocol (LDAP) client libraries
fi


# Files
## Docker
CreateLink /etc/systemd/system/multi-user.target.wants/docker.service \
    /usr/lib/systemd/system/docker.service
## Git
CreatePlatformLink "$XDG_CONFIG_HOME/git/platform-config"
