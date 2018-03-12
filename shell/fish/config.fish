if test -e ~/.profile
    source ~/.profile > /dev/null
end

function fish_greeting 
    set_color brmagenta
    echo Welcome to the afterlife. 
    set_color normal
end

function pack
    set filename $argv[1]
    echo $filename
end

function cd
    builtin cd $argv
    ls
end
