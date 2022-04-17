#!/usr/bin/env bash
set -euo pipefail

function is_main_platform () {
    [ "$PLATFORM_LABEL" = 'main' ]
}

function CreatePlatformLink () {
    local link_name
    local target

    link_name=$1
    target="$2.$PLATFORM_LABEL"

    # CreateLink always creates parent directory and makes $HOME not writable by user
    if [ "$(readlink -f -- "$link_name")" != "$target" ]; then
        ln -sf "$target" "$link_name"
        SetFileProperty "$link_name" owner "$USER"
	    SetFileProperty "$link_name" group "$USER"
    fi
}
