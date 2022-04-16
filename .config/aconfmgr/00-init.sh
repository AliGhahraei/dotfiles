#!/usr/bin/env bash
set -euo pipefail

function is_main_platform () {
    [ "$PLATFORM_LABEL" = 'main' ]
}
