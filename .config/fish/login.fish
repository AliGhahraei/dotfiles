#!/usr/bin/env fish
bass source $HOME/.config/common_profile/base
source $__fish_config_dir/abbreviations.fish


if not contains /home/ali/.pyenv/shims $PATH
    pyenv init --path | source
end

pyenv init - | source


if test $PLATFORM_TYPE = "Linux"
    exec startx $XDG_CONFIG_HOME/X11/xinitrc -- -keeptty
end
