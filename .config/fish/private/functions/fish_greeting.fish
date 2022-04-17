#!/usr/bin/env fish
function fish_greeting
    if mail -e
        set mail_message "MAAAAAAAAAAAAAAAAAAAAIL!"

        set_color red
        echo $mail_message
        set_color normal

        notify-send -u critical $mail_message
    else
        set_color brmagenta
        echo Welcome to the afterlife.
        set_color normal
    end
end
