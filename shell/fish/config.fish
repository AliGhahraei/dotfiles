source $HOME/.profile
thefuck --alias | source

if status is-login; and test -e $HOME/.profile
    switch (uname) 
    case Darwin
        export JAVA_HOME=/Library/Java/Home
    case '*'
        export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
    end
end

function fish_greeting 
    set_color brmagenta
    echo Welcome to the afterlife. 
    set_color normal
end

function cd
    builtin cd $argv
    ls
end


