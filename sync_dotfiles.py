#!/usr/bin/env python3
from getpass import getpass
from pathlib import Path
from platform import system
from sh import ln, mkdir, echo
from sh.contrib import sudo
from typing import Dict, List

PathDict = Dict[Path, Path]

HOME = Path.home()

# Source paths
DOTFILES = HOME / 'g/dotfiles'
EDITORS = DOTFILES / 'editors'
SHELLS = DOTFILES / 'shells'
XORG = DOTFILES / 'xorg'

# Destination paths
CONFIG = HOME / ".config"
ETC = Path('/etc')

SRC_TO_TARGET = {
    EDITORS / 'emacs': CONFIG / 'doom',
    EDITORS / 'neovim': CONFIG / 'nvim',

    SHELLS / 'common': HOME,
    SHELLS / 'bash': HOME,
    SHELLS / 'fish': CONFIG / 'fish',
    SHELLS / 'starship.toml': CONFIG,
    SHELLS / 'ipython': HOME / '.ipython/profile_default',

    DOTFILES / 'taskwarrior': HOME,
}  # type: PathDict

LINUX_SRC_TO_TARGET = {
    DOTFILES / 'alsa': HOME,

    DOTFILES / 'wms/xmonad': HOME / '.xmonad',

    XORG / '.Xresources': HOME,
    XORG / '.xinitrc': HOME,
    XORG / 'dunstrc': CONFIG / 'dunst',
}  # type: PathDict

ROOT_LINUX_SRC_TO_TARGET = {
    DOTFILES / 'udev-rules': ETC / 'udev/rules.d',

    XORG / '70-synaptics.conf': ETC / 'X11/xorg.conf.d',
}  # type: PathDict


def link_src_files_to_dest_dirs(src_to_target: PathDict):
    for source, target_dir in src_to_target.items():
        mkdir('-p', target_dir)

        source_dotfiles = get_dotfiles(source)
        if not source_dotfiles:
            print(f'Empty dir: {source}')
        for source_file in source_dotfiles:
            target_file = target_dir / source_file.name
            target_file.unlink(missing_ok=True)
            target_file.symlink_to(source_file)


def get_dotfiles(source: Path) -> List[Path]:
    try:
        paths = list(source.iterdir())
    except NotADirectoryError:
        paths = [source]
    return paths


def main():
    link_src_files_to_dest_dirs(SRC_TO_TARGET)
    if system() == 'Linux':
        link_src_files_to_dest_dirs(LINUX_SRC_TO_TARGET)

        with sudo(getpass(), _with=True):
            link_src_files_to_dest_dirs(ROOT_LINUX_SRC_TO_TARGET)


if __name__ == '__main__':
    main()
