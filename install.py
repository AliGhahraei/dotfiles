#!/usr/bin/env python3
from getpass import getpass
from os import listdir, sep
from os.path import abspath, dirname, expanduser, join
from platform import system
from sh import ln, mkdir, echo
from sh.contrib import sudo
from typing import Tuple, Dict


SCRIPTS_CURRENT_DIR = dirname(abspath(__file__))

# Source paths
EDITORS = 'editors'
EMACS = join(EDITORS, 'emacs')
SHELLS = 'shells'
XORG = 'xorg'

# Destination paths
HOME = expanduser('~')
CONFIG = join(HOME, ".config")


SRC_TO_TARGET = {
    (EMACS, 'init.el',): (HOME, '.doom.d',),
    (EMACS, 'config.el',): (HOME, '.doom.d',),
    (EMACS, 'private',): (HOME, '.emacs.d', 'modules', 'private',),
    (EDITORS, 'neovim',): (CONFIG, 'nvim',),

    (SHELLS, 'common',): (HOME,),
    (SHELLS, 'bash',): (HOME,),
    (SHELLS, 'fish',): (CONFIG, 'fish',),
    (SHELLS, 'zsh',): (HOME,),

    ('taskwarrior',): (HOME,),
}
LINUX_SRC_TO_TARGET = {
    ('alsa',): (HOME,),

    ('wms', 'xmonad',): (HOME, '.xmonad',),

    (XORG, '.Xresources',): (HOME,),
    (XORG, '.xinitrc',): (HOME,),
    (XORG, 'dunstrc',): (CONFIG, 'dunst',),
}
ROOT_LINUX_SRC_TO_TARGET = {
    ('udev-rules',): (sep, 'etc', 'udev', 'rules.d',),

    (XORG, '70-synaptics.conf',): (sep, 'etc', 'X11', 'xorg.conf.d',),
}


def link_src_files_to_dest_dirs(src_to_target: Dict[Tuple[str], Tuple[str]]):
    for partial_src_tuple, target_tuple in src_to_target.items():
        src_dir = join(SCRIPTS_CURRENT_DIR, *partial_src_tuple)
        target_dir = join(*target_tuple)

        mkdir('-p', target_dir)

        try:
            filenames = [join(src_dir, filename) for filename in listdir(src_dir)]
        except NotADirectoryError:
            filenames = src_dir,
        else:
            if not filenames:
                print(f'Empty dir: {src_dir}')

        for filename in filenames:
            ln('-sf', filename, abspath(target_dir))


if __name__ == '__main__':
    link_src_files_to_dest_dirs(SRC_TO_TARGET)
    if system() == 'Linux':
        link_src_files_to_dest_dirs(LINUX_SRC_TO_TARGET)

        with sudo(getpass(), _with=True):
            link_src_files_to_dest_dirs(ROOT_LINUX_SRC_TO_TARGET)
