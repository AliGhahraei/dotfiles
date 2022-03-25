#!/usr/bin/env fish

# Platform specific
if test $PLATFORM_TYPE = Linux
    abbr po 'systemctl poweroff'
    abbr re 'systemctl reboot'

    abbr es 'sudo setxkbmap latam'
    abbr en 'sudo setxkbmap -layout us -variant altgr-intl'

    abbr mega 'restic -r rclone:mega_remote:backup --password-command="secret-tool lookup program restic remote mega_remote"'

    abbr nn 'nnn -e'

    abbr clipboard 'xclip -selection c'
end


# Dbot
abbr d 'dbot'
abbr db 'dbot backup'
abbr dm 'dbot maintenance'
abbr dr 'dbot repos'

# Git
abbr gs 'git status'
abbr gc 'git commit'
abbr gp 'git push'
abbr gu 'git pull'
abbr ga 'git add'
abbr gl 'git log'
abbr gd 'git diff'
abbr gi "git ls-files -v | grep '^[[:lower:]]'"

# ls
abbr l 'ls'
abbr la 'ls -a'

# route-tracker
abbr ta 'route --save tsukihime choices add'
abbr td 'route tsukihime choices advance'
abbr tl 'route tsukihime choices link'
abbr te 'route tsukihime ending add'
abbr tv 'route tsukihime view'

# Misc.
abbr wa 'convert-whatsapp'
abbr e 'enter-dotfiles /usr/bin/fish'
abbr n 'nvim'
abbr pretty 'python -m json.tool'
abbr pip-uninstall 'pip freeze | xargs pip uninstall -y'
