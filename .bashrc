# Return if not running interactively
[[ $- != *i* ]] && return

source $HOME/.config/common_profile/base


export HISTFILE="$XDG_DATA_HOME/bash/history"
export PS1="\[\e[1;32m\]\[\e[4m\]\u\[\e[m\]\[\e[1;31m\]|\[\e[m\]\[\e[1;33m\]\[\e[m\]\[\e[1;36m\]\W\[\e[m\]\[\e[1;31m\]\$\[\e[m\] "


function cd() {
  builtin cd $1
  ls
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash


eval "$(pyenv init -)"
