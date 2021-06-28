#!/usr/bin/env fish
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
