set -l platform (uname)


source $HOME/.profile


switch $platform
case Darwin
    set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/openjdk.jdk/Contents/Home
case Linux
    set -gx BROWSER "firefox-developer-edition"
    set -gx JAVA_HOME /usr/lib/jvm/java-8-openjdk
end


if status --is-login; and test $platform = "Linux"
    exec startx -- -keeptty
end


if status --is-interactive
    set -x DIRENV_LOG_FORMAT ""
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

        switch $platform
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



# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end
