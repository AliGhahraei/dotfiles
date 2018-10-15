###########
# EXPORTS #
###########

# Work (out of source control for security reasons)
source "$HOME/.work_profile"

# Projects
export PROJECTS_PATH="$HOME/g"

# Mac
export HOMEBREW_NO_AUTO_UPDATE=1
export __CF_USER_TEXT_ENCODING='0x0:0x0' # Prevent macOS from storing another useless file 

# Pelican
export PY='python3' # Looks like it needs dis
export PELICAN_THEMES_PATH="$PROJECTS_PATH/pelican-themes"
export PELICAN_PLUGINS_PATH="$PROJECTS_PATH/pelican-plugins"

# Misc.
export VISUAL="nvim"
export TERM="xterm-256color"
export _JAVA_AWT_WM_NONREPARENTING=1
export PATH="$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH"
export VIRTUAL_ENV_DISABLE_PROMPT=1


###########
# ALIASES #
###########

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

# Haskell
alias s='stack'

# Misc.
alias maintenance="$PROJECTS_PATH/scripts/maintenance/maintenance.fish"
alias dot_install="$PROJECTS_PATH/dotfiles/install.py"
alias md='mkdir'
alias n='nvim'
alias pretty="python -m json.tool"
alias f='fuck'
