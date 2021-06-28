#!/usr/bin/env fish
if test "$TERM" = "dumb"
    function fish_prompt
        echo "\$ "
    end

    function fish_right_prompt; end
    function fish_greeting; end
    function fish_title; end
else
    set -q PLATFORM_TYPE || set -gx PLATFORM_TYPE (uname)
    set -gx PRIVATE_FISH $__fish_config_dir/private


    if status --is-login
        source $PRIVATE_FISH/login.fish
    end


    if status --is-interactive
        thefuck --alias | source
        function cd
            builtin cd $argv
            ls
        end
    end


    function fish_greeting
        if mail -e
            set mail_message "MAAAAAAAAAAAAAAAAAAAAIL!"

            set_color red
            echo $mail_message
            set_color normal

            switch $PLATFORM_TYPE
                case Darwin
                    osascript -e "display notification \"$mail_message\""
                case Linux
                    notify-send -u critical $mail_message
            end
        else
            set_color brmagenta
            echo Welcome to the afterlife.
            set_color normal
        end
    end


end
