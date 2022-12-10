#!/usr/bin/env fish
if test "$TERM" = "dumb"
    function fish_prompt
        echo "\$ "
    end

    function fish_right_prompt; end
    function fish_greeting; end
    function fish_title; end
else
    set -gx PRIVATE_FISH $__fish_config_dir/private
    source $PRIVATE_FISH/variables.fish
    source $PRIVATE_FISH/abbreviations.fish

    if status --is-login
        source $PRIVATE_FISH/login.fish
    end

    if status --is-interactive
        if not set -q PYENV_SHELL
            pyenv init --path | source
        end

        function cd
            builtin cd $argv
            ls
        end
    end
end
