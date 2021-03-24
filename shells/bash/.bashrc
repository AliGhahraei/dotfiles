# Return if not running interactively
[[ $- != *i* ]] && return

# Include common shell config
[[ -f ~/.profile ]] && source ~/.profile


export PS1="\[\e[1;32m\]\[\e[4m\]\u\[\e[m\]\[\e[1;31m\]|\[\e[m\]\[\e[1;33m\]\[\e[m\]\[\e[1;36m\]\W\[\e[m\]\[\e[1;31m\]\$\[\e[m\] "


if [[ $(uname) == 'Linux' ]]; then
   alias ls='ls --color'
fi

function cd() {
  builtin cd $1
  ls
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
