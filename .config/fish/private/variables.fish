#!/usr/bin/env fish
set -gx PLATFORM_TYPE (uname)

if not contains $PRIVATE_FISH/functions $fish_function_path
    set --prepend fish_function_path $PRIVATE_FISH/functions
end
