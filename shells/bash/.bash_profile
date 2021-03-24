#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ "$(uname)" == 'Linux' ] && systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

