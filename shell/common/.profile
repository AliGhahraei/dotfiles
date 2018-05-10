###########
# EXPORTS #
###########

# Work
source "$HOME/.work_profile"

# Mac
export HOMEBREW_NO_AUTO_UPDATE=1
export __CF_USER_TEXT_ENCODING='0x0:0x0' # Prevent stupid macOS from storing yet another useless file in my $HOME

# Misc.
export VISUAL="nvim"
export TERM="xterm-256color"
export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
export PATH="$PATH:/usr/local/bin:$HOME/bin"
export PY='python3' # Pelican needs dis


###########
# ALIASES #
###########

# Work
alias cw="cd $SPECTRUM"
alias cr="cd $REQUESTS"

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
alias gi="git ls-files -v | grep '^[[:lower:]]'"

#Rest
alias ipack='json2msgpack -i'
alias dpack='msgpack2json -d'
alias h='http'
alias hp='http-prompt'

# Colorful ls
alias ls='ls -GF'
alias l='ls'
alias la='ls -a'

# System
alias mnt="sudo mount /dev/sdb1 /mnt"
alias umnt="sudo umount /mnt"

# Python
alias python='python3'
alias pip='pip3'

# Misc.
alias maintenance="$HOME/g/scripts/maintenance/maintenance.sh"
alias md='mkdir'
alias n='nvim'
alias pretty="python -m json.tool"
alias f='fuck'
