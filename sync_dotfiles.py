#!/usr/bin/env python3
from functools import partial
from pathlib import Path
from platform import system
from sys import argv
from typing import Dict, List, Tuple, Iterator, Callable

from sh import ln, mkdir, cp
from sh.contrib import sudo

PathDict = Dict[Path, Path]

HOME = Path.home()

# Source paths
DOTFILES = HOME / 'g/dotfiles'
EDITORS = DOTFILES / 'editors'
SHELLS = DOTFILES / 'shells'
XORG = DOTFILES / 'xorg'

# Destination paths
ROOT = Path('/')
ETC = ROOT / 'etc'
CONFIG = HOME / ".config"

SOURCES_TO_TARGETS = {
    EDITORS / 'emacs': CONFIG / 'doom',
    EDITORS / 'neovim': CONFIG / 'nvim',

    SHELLS / 'common': HOME,
    SHELLS / 'bash': HOME,
    SHELLS / 'fish' / 'config.fish': CONFIG / 'fish',
    SHELLS / 'fish' / 'abbreviations.fish': CONFIG / 'fish',
    SHELLS / 'fish' / 'fish_plugins': CONFIG / 'fish',
    SHELLS / 'fish' / 'fish_user_key_bindings.fish': CONFIG / 'fish' / 'functions',
    SHELLS / 'ipython': HOME / '.ipython/profile_default',

    DOTFILES / 'taskwarrior': HOME,
    DOTFILES / 'termite': CONFIG / 'termite',
    DOTFILES / 'systemd-units': CONFIG / 'systemd/user',
    DOTFILES / 'git': CONFIG / 'git',
}  # type: PathDict

LINUX_SOURCES_TO_TARGETS = {
    DOTFILES / 'wms/xmonad': HOME / '.xmonad',

    XORG / '.Xresources': HOME,
    XORG / '.xinitrc': HOME,
    XORG / 'dunstrc': CONFIG / 'dunst',
}  # type: PathDict

soft_link = ln.bake('-sfn')


def main():
    sync_files(SOURCES_TO_TARGETS)
    install_gui_files = len(argv) == 1
    if system() == 'Linux' and install_gui_files:
        sync_files(LINUX_SOURCES_TO_TARGETS)


def sync_files(sources_to_targets: PathDict, *, sync: Callable[[Path, Path], None] = soft_link):
    for (source_dir, target_dir), files in _get_dirs_to_files(sources_to_targets):
        if files:
            mkdir('-p', target_dir)
            for source_file, target_file in files.items():
                sync(source_file, target_file)
        else:
            print(f'Empty source dir: {source_dir}')


def _get_dirs_to_files(sources_to_targets: PathDict) -> Iterator[Tuple[Tuple[Path, Path], PathDict]]:
    return (((source_file_or_dir, target_dir), _get_file_sources_to_file_targets(source_file_or_dir, target_dir))
            for source_file_or_dir, target_dir in sources_to_targets.items())


def _get_file_sources_to_file_targets(source_file_or_dir: Path, target_dir: Path) -> PathDict:
    return {source_file: target_dir / source_file.name for source_file in _get_source_files(source_file_or_dir)}


def _get_source_files(source_file_or_dir: Path) -> List[Path]:
    try:
        paths = list(source_file_or_dir.iterdir())
    except NotADirectoryError:
        paths = [source_file_or_dir]
    return paths


def _root_sync(password: str, sync: Callable[[Path, Path], None], source_file: Path, target_file: Path):
    with sudo(password=password, _with=True):
        sync(source_file, target_file)


if __name__ == '__main__':
    main()
