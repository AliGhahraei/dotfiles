#!/usr/bin/env fish
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

# Keyboard
abbr es 'sudo setxkbmap latam'
abbr en 'sudo setxkbmap -layout us -variant altgr-intl'

# ls
abbr l 'ls'
abbr la 'ls -lah'

# route-tracker
abbr ta 'route --save tsukihime choices add'
abbr td 'route tsukihime choices advance'
abbr tl 'route tsukihime choices link'
abbr te 'route tsukihime ending add'
abbr tv 'route tsukihime view'

# Systemd
abbr po 'systemctl poweroff'
abbr re 'systemctl reboot'

# Misc.
abbr clipboard 'xclip -selection c'
abbr wa 'convert-whatsapp'
abbr e 'enter-dotfiles /usr/bin/fish'
abbr n 'emacs-term'
abbr nn 'nnn -e'
abbr pretty 'python -m json.tool'
abbr pip-uninstall 'pip freeze | xargs pip uninstall -y'
