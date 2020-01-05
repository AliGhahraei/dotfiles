#!/usr/bin/env python3
from getpass import getpass
from os import listdir, sep
from os.path import abspath, expanduser, join
from platform import system
from sh import ln, mkdir, echo
from sh.contrib import sudo
from typing import Iterable, Dict, List

# Source paths
EDITORS = 'editors'
SHELLS = 'shells'
XORG = 'xorg'

# Destination paths
HOME = expanduser('~')
CONFIG = join(HOME, ".config")


DOTFILES_DIR = join(HOME, 'g', 'dotfiles')


SRC_TO_TARGET = {
    (EDITORS, 'emacs',): (HOME, CONFIG, 'doom',),
    (EDITORS, 'neovim',): (CONFIG, 'nvim',),

    (SHELLS, 'common',): (HOME,),
    (SHELLS, 'bash',): (HOME,),
    (SHELLS, 'fish',): (CONFIG, 'fish',),
    (SHELLS, 'ipython',): (HOME, '.ipython', 'profile_default'),

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


def link_src_files_to_dest_dirs(src_to_target: Dict[Iterable[str], Iterable[str]]):
    for relative_source, target in src_to_target.items():
        absolute_source = join(DOTFILES_DIR, *relative_source)
        target_dir = join(*target)
        mkdir('-p', target_dir)

        source_dotfiles = get_dotfiles(absolute_source)
        if not source_dotfiles:
            print(f'Empty dir: {absolute_source}')
        for source_dotfile in source_dotfiles:
            ln('-sf', source_dotfile, abspath(target_dir))


def get_dotfiles(absolute_src_dir_or_file: str) -> List[str]:
    try:
        relative_filenames = listdir(absolute_src_dir_or_file)
    except NotADirectoryError:
        filenames = [absolute_src_dir_or_file]
    else:
        filenames = [join(absolute_src_dir_or_file, filename) for filename in relative_filenames]
    return filenames


def main():
    link_src_files_to_dest_dirs(SRC_TO_TARGET)
    if system() == 'Linux':
        link_src_files_to_dest_dirs(LINUX_SRC_TO_TARGET)

        with sudo(getpass(), _with=True):
            link_src_files_to_dest_dirs(ROOT_LINUX_SRC_TO_TARGET)


if __name__ == '__main__':
    main()
