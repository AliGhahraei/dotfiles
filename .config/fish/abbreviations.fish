#!/usr/bin/env fish

# Platform specific
if test $PLATFORM_TYPE = Linux
    abbr po 'systemctl poweroff'
    abbr re 'systemctl reboot'
    abbr mnt 'sudo mount /dev/sdb1 /mnt'
    abbr umnt 'sudo umount /mnt'

    abbr es 'sudo setxkbmap latam'
    abbr en 'sudo setxkbmap -layout us -variant altgr-intl'

    abbr box 'restic -r rclone:box_remote:backup --password-command="secret-tool lookup program restic remote box_remote"'
    abbr mega 'restic -r rclone:mega_remote:backup --password-command="secret-tool lookup program restic remote mega_remote"'

    alias nn 'nnn -e'

    abbr clipboard 'xclip -selection c'

    abbr ye 'yadm enter'
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
abbr n 'nvim'
abbr pretty 'python -m json.tool'
abbr pip-uninstall 'pip freeze | xargs pip uninstall -y'
abbr f 'fuck'
