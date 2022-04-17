#!/usr/bin/env fish
bass source $HOME/.config/common_profile/base
source $PRIVATE_FISH/abbreviations.fish


if not contains /home/ali/.pyenv/shims $PATH
    pyenv init --path | source
end

pyenv init - | source


exec startx $XDG_CONFIG_HOME/X11/xinitrc -- -keeptty
