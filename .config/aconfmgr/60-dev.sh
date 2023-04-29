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
    AddPackage openssh # Premier connectivity tool for remote login with the SSH protocol
    AddPackage postgresql # Sophisticated object-relational DBMS

    ## Kafka-related
    AddPackage jdk8-openjdk # OpenJDK Java 8 development kit
    AddPackage librdkafka # The Apache Kafka C/C++ library
fi


# Files
## Docker
CreateLink /etc/systemd/system/multi-user.target.wants/docker.service \
    /usr/lib/systemd/system/docker.service
## Git
CreatePlatformLink "${XDG_CONFIG_HOME:-$HOME/.config}/git/platform-config"
