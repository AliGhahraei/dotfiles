#!/usr/bin/env bash
. "$HOME/.local/bin/themis/core-variables"

set -euo pipefail

function is_main_platform () {
    [ "$THEMIS_PLATFORM_LABEL_PATH" = 'main' ]
}

function CreatePlatformLink () {
    local link_name
    local target

    link_name=$1
    target="${2:-${link_name}}.$THEMIS_PLATFORM_LABEL_PATH"

    # CreateLink always creates parent directory and makes $HOME not writable by user
    if [ "$(readlink -f -- "$link_name")" != "$target" ]; then
        ln -sf "$target" "$link_name"
        set_user_permissions "$link_name"
    fi
}

function MakeUserDir () {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        set_user_permissions "$1"
    fi
}

function set_user_permissions() {
    SetFileProperty "$1" owner "$USER"
	SetFileProperty "$1" group "$USER"
}
