if test -e $HOME/.profile
    source $HOME/.profile
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

thefuck --alias | source
