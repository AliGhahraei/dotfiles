# Si no estamos corriendo de forma interactiva, no hacemos nada
[[ $- != *i* ]] && return

# Include common shell config
[[ -f ~/.profile ]] && source ~/.profile

export PS1="\[\e[1;32m\]\[\e[4m\]\u\[\e[m\]\[\e[1;31m\]|\[\e[m\]\[\e[1;33m\]\[\e[m\]\[\e[1;36m\]\W\[\e[m\]\[\e[1;31m\]\$\[\e[m\] "


if [[ $(uname) == 'Linux' ]]; then
   alias ls='ls --color'
fi

# Commented out so xonsh doesn't complain
#function cd() {
#  builtin cd $1
#  ls
#}
#[ -f ~/.config/fzf/fzf.bash ] && source ~/.config/fzf/fzf.bash
