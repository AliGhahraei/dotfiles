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

    if status --is-login
        source $PRIVATE_FISH/login.fish
    end

    if status --is-interactive
	    direnv hook fish | source

        function cd
            builtin cd $argv
            ls
        end
    end
end
