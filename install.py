#!/usr/bin/env python3
from os import listdir, symlink, makedirs, unlink
from os.path import abspath, dirname, expanduser, join

SCRIPTS_CURRENT_DIR = dirname(abspath(__file__))

# Base paths
HOME = expanduser('~')
CONFIG = join(HOME, ".config")

SHELLS_SRC = "shell"
EMACS_BASE_SRC = "emacs"

# Source and destination mapping
EMACS_INIT_SRC = join(EMACS_BASE_SRC, 'init')
EMACS_CONFIG_SRC = join(EMACS_BASE_SRC, 'config')
FISH_SRC = join(SHELLS_SRC, 'fish')
NEOVIM_SRC = 'neovim'

EMACS = join(HOME, ".emacs.d")
EMACS_CONFIG = join(EMACS, 'config')
NEOVIM = join(CONFIG, 'nvim')
FISH = join(CONFIG, 'fish')

SRC_TO_DEST = {
    EMACS_INIT_SRC: EMACS,
    EMACS_CONFIG_SRC: EMACS_CONFIG,
    FISH_SRC: FISH,
    NEOVIM_SRC: NEOVIM,
}

# Home files
COMMON_SHELL_FILES = join(SHELLS_SRC, 'common')
BASH = join(SHELLS_SRC, 'bash')
ZSH = join(SHELLS_SRC, 'zsh')
TASKWARRIOR = 'taskwarrior'

HOME_FILES_SRC = (COMMON_SHELL_FILES, BASH, ZSH, TASKWARRIOR)


def link_src_files_to_dest_dirs(src_to_target):
    for partial_src_dir, target_dir in src_to_target.items():
        makedirs(target_dir, exist_ok=True)
        absolute_src_dir = join(SCRIPTS_CURRENT_DIR, partial_src_dir)

        for filename in listdir(absolute_src_dir):
            absolute_src_file = join(absolute_src_dir, filename)
            target_file = join(target_dir, filename)

            try:
                symlink(absolute_src_file, target_file)
            except FileExistsError:
                unlink(join(target_dir, filename))
                symlink(absolute_src_file, target_file)


if __name__ == '__main__':
    link_src_files_to_dest_dirs(SRC_TO_DEST)
    link_src_files_to_dest_dirs({src: HOME for src in HOME_FILES_SRC})

# TODO: change to python
# if [[ "$(uname)" == "Linux" ]]; then
#     XORG_CONF=/etc/X11/xorg.conf.d/
#     XMONAD="$HOME/.xmonad/"
#     DUNST="$HOME/.config/dunst/"

#     mkdir -p $XMONAD
#     mkdir -p $DUNST

#     sudo ln -sf $VC/70-synaptics.conf $XORG_CONF
#     ln -sf $VC/xmonad.hs $XMONAD
#     ln -sf $VC/dunstrc $DUNST
#     ln -sf $VC/.xinitrc $HOME
#     ln -sf $VC/.Xresources $HOME
#     ln -sf $VC/.asoundrc $HOME
# fi
