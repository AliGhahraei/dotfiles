[[ -r ~/.profile ]] && source ~/.profile

fpath=( "$HOME/.zfunctions" $fpath )

zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# Exports
export SAVEHIST=300
export HISTFILE=~/.zsh_history

# Antibody
source ~/.zsh_plugins.sh
alias bundle='antibody bundle < ~/.zsh_plugins > ~/.zsh_plugins.sh'

###########
# Plugins #
###########

[ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh
