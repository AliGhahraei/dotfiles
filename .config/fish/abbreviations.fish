#!/usr/bin/env fish

# Platform specific
if test $PLATFORM_TYPE = Linux
    abbr po 'systemctl poweroff'
    abbr re 'systemctl reboot'
    abbr mnt 'sudo mount /dev/sdb1 /mnt'
    abbr umnt 'sudo umount /mnt'

    abbr es 'sudo setxkbmap latam'
    abbr en 'sudo setxkbmap us'

    abbr clipboard 'xclip -selection c'


    # YADM
    abbr ys 'yadm status'
    abbr yc 'yadm commit'
    abbr yp 'yadm push'
    abbr yu 'yadm pull'
    abbr ya 'yadm add'
    abbr yl 'yadm log'
    abbr yd 'yadm diff'
    abbr yi "yadm ls-files -v | grep '^[[:lower:]]'"
end

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

# Misc.
abbr maintenance '$PROJECTS_PATH/scripts/maintenance/trigger_maintenance.fish'
abbr n 'nvim'
abbr pretty 'python -m json.tool'
abbr f 'fuck'
