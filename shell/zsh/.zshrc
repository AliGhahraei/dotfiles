[[ -r ~/.profile ]] && source ~/.profile

fpath=( "$HOME/.zfunctions" $fpath )

# Antibody
source ~/.zsh_plugins.sh
alias bundle='antibody bundle < ~/.zsh_plugins > ~/.zsh_plugins.sh'

###########
# Plugins #
###########

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

[ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh
