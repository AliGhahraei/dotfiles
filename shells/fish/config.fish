source $HOME/.profile
thefuck --alias | source

if status is-login; and test -e $HOME/.profile
    switch (uname)
    case Darwin
        export JAVA_HOME=/Library/Java/Home
    case Linux
        export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
        startx
    end
end

function fish_greeting 
    if mail -e
	set mail_message "MAAAAAAAAAAAAAAAAAAAAIL!"

        set_color red
        echo $mail_message
        set_color normal

        switch (uname)
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

function cd
    builtin cd $argv
    ls
end

status --is-interactive; and source (pyenv init -|psub)
starship init fish | source
