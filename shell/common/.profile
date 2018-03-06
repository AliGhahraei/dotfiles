###########
# EXPORTS #
###########

# Work
export PYTHONPATH=~/spectrum-net:$PYTHONPATH

# Mac
export __CF_USER_TEXT_ENCODING='0x0:0x0'

# Misc.
export VISUAL="nvim"
export TERM="xterm-256color"
export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export __CF_USER_TEXT_ENCODING=""


###########
# ALIASES #
###########

# Work
alias cw='cd ~/Documents/spectrum-net'

# Linux
alias po='systemctl poweroff'
alias re='systemctl reboot'
alias es='sudo setxkbmap latam'
alias en='sudo setxkbmap us'
alias sql='sudo systemctl start mysqld'
alias clipboard="xclip -selection c"

# Git
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gu='git pull'
alias ga='git add'
alias gl='git log'
alias gd='git diff'

# ls con colores
alias ls='ls -GF'
alias l='ls'
alias la='ls -a'

# System
alias mnt="sudo mount /dev/sdb1 /mnt"
alias umnt="sudo umount /mnt"

# Misc.
alias maintenance='~/g/scripts/maintenance/maintenance.sh'
alias md='mkdir'
alias n='nvim'
alias pretty="python -m json.tool"
alias python='python3'
alias pip='pip3'
alias f='fuck'
