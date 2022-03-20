from enum import Enum
from subprocess import Popen
from typing import Iterable, Iterator, List, Tuple, Callable

from libqtile.backend.base import Window
from libqtile.bar import Bar
from libqtile.config import Click, Drag, Group, Key, Mouse, Screen
from libqtile.core.manager import Qtile
from libqtile.hook import subscribe
from libqtile.layout import Tile
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget import (
    Battery, Chord, Clock, CurrentLayout, GroupBox, PulseVolume, Systray,
    TextBox, WindowName,
)

MOD = 'mod4'


class StrEnum(str, Enum):
    pass


class GroupNames(StrEnum):
    home = '1'
    dev = '2'
    www = '3'


GROUPS_TO_PROGRAMS_AND_WM_CLASSES = {
    GroupNames.dev: ('emacs', 'Emacs'),
    GroupNames.www: ('firefox', 'firefox'),
}


def get_groups() -> List[Group]:
    labelled_groups = (
        Group(GroupNames.home, label='home'),
        Group(GroupNames.dev, label='dev'),
        Group(GroupNames.www, label='www'),
    )
    non_labelled_groups = (Group(str(index))
                           for index in range(len(labelled_groups) + 1, 10))
    return [*labelled_groups, *non_labelled_groups]


def get_keys(group_names: Iterable[str]) -> List[Key]:
    def _get_base_keys() -> Tuple[Key, ...]:
        return (
            Key([MOD], 'h', lazy.layout.left(), desc='Move focus to left'),
            Key([MOD], 'l', lazy.layout.right(), desc='Move focus to right'),
            Key([MOD], 'j', lazy.layout.down(), desc='Move focus down'),
            Key([MOD], 'k', lazy.layout.up(), desc='Move focus up'),
            Key([MOD], 'Return', lazy.layout.next(),
                desc='Move window focus to other window'),

            Key([MOD, 'shift'], 'h', lazy.layout.shuffle_left(),
                desc='Move window to the left'),
            Key([MOD, 'shift'], 'l', lazy.layout.shuffle_right(),
                desc='Move window to the right'),
            Key([MOD, 'shift'], 'j', lazy.layout.shuffle_down(),
                desc='Move window down'),
            Key([MOD, 'shift'], 'k', lazy.layout.shuffle_up(),
                desc='Move window up'),

            Key([MOD, 'control'], 'h', lazy.layout.decrease_ratio(),
                desc='Decrease layout ratio'),
            Key([MOD, 'control'], 'l', lazy.layout.increase_ratio(),
                desc='Increase layout ratio'),
            Key([MOD], 'n', lazy.layout.normalize(),
                desc='Reset all window sizes'),
            Key([MOD], 't', lazy.window.toggle_floating(),
                desc='Toggle floating'),

            Key([MOD], 'f', lazy.window.toggle_fullscreen(),
                desc='Toggle fullscreen'),
            Key([MOD], 'w', lazy.window.kill(), desc='Kill focused window'),
            Key([MOD], 'r', lazy.reload_config(), desc='Reload the config'),
            Key([MOD, 'shift'], 'r', lazy.restart(), desc='Reload the config'),
            Key([MOD], 'q', lazy.shutdown(), desc='Shutdown Qtile'),

            Key([], 'XF86AudioRaiseVolume',
                lazy.spawn(['pamixer', '--increase', '5', '--unmute']),
                desc='Raise volume'),
            Key([], 'XF86AudioLowerVolume',
                lazy.spawn(['pamixer', '--decrease', '5', '--unmute']),
                desc='Lower volume'),
            Key([], 'XF86AudioMute', lazy.spawn(['pamixer', '--toggle-mute']),
                desc='Mute'),
            Key([], 'Print', lazy.spawn(['flameshot', 'gui']),
                desc='Screenshot'),
            Key([MOD], 'space', lazy.spawn(guess_terminal()),
                desc='Launch terminal'),
            Key([MOD], 'd', lazy.spawn(['rofi', '-show', 'run']),
                desc='Run command with Rofi'),
        )

    def _get_group_switch_key(name: str, *extra_actions: Callable[[], None]) \
            -> Key:
        return Key(
            [MOD],
            name,
            lazy.group[name].toscreen(), *extra_actions,
            desc=f'Switch to group {name}'
        )

    def _run_if_no_window_matches(qtile: Qtile, command: str, wm_class: str) \
            -> None:
        active_windows: List[Window] = qtile.current_group.windows
        windows_matching_class = (window for window in active_windows
                                  if (window_classes := window.get_wm_class())
                                  and wm_class in window_classes)
        try:
            next(windows_matching_class)
        except StopIteration:
            qtile.cmd_spawn(command)

    def _get_group_move_keys(names: Iterable[str]) -> Iterator[Key]:
        return(
            Key(
                [MOD, 'shift'],
                name,
                lazy.window.togroup(name, switch_group=True),
                desc=f'Move focused window & switch to group {name}',
            )
            for name in names
        )

    return [
        *_get_base_keys(),
        *(
            _get_group_switch_key(
                name,
                lazy.function(_run_if_no_window_matches, command, wm_class),
            )
            for name, (command, wm_class)
            in GROUPS_TO_PROGRAMS_AND_WM_CLASSES.items()
        ),
        *(
            _get_group_switch_key(name)
            for name in group_names
            if name not in GROUPS_TO_PROGRAMS_AND_WM_CLASSES
        ),
        *_get_group_move_keys(group_names),
    ]


def get_screens() -> List[Screen]:
    return [Screen(top=Bar(
        [
            GroupBox(),
            CurrentLayout(),
            WindowName(),
            Chord(
                chords_colors={
                    'launch': ('#ff0000', '#ffffff'),
                },
                name_transform=lambda name: name.upper(),
            ),
            Systray(),
            TextBox(text="墳"),
            PulseVolume(),
            Battery(format='{char} {percent:2.0%}', charge_char='▲',
                    discharge_char='▼'),
            Clock(format=' %a %Y-%m-%d   %H:%M'),
        ],
        24,
    ))]


def get_mouse_actions() -> List[Mouse]:
    return [
        Drag([MOD], 'Button1', lazy.window.set_position_floating(),
             start=lazy.window.get_position()),
        Drag([MOD], 'Button3', lazy.window.set_size_floating(),
             start=lazy.window.get_size()),
        Click([MOD], 'Button2',
              lazy.window.bring_to_front()),
    ]


@subscribe.startup_once
def startup_once():
    Popen('aw-qt')


groups = get_groups()
keys = get_keys([group.name for group in groups])
layouts = [Tile(border_on_single=False, ratio=0.5)]
screens = get_screens()
mouse = get_mouse_actions()
