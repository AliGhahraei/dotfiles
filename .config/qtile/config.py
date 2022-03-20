from subprocess import Popen
from typing import Iterable, Iterator, List, Tuple

from libqtile.bar import Bar
from libqtile.config import Click, Drag, Group, Key, Mouse, Screen
from libqtile.hook import subscribe
from libqtile.layout import Tile
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget import (
    Battery, Chord, Clock, CurrentLayout, GroupBox, PulseVolume, Systray,
    TextBox, WindowName,
)

MOD = 'mod4'


def get_groups() -> List[Group]:
    named_groups = (
        Group('1', label='home'),
        Group('2', label='dev', spawn='emacs'),
        Group('3', label='www', spawn='firefox'),
    )
    non_named_groups = (Group(str(index))
                        for index in range(len(named_groups) + 1, 10))
    return [*named_groups, *non_named_groups]


def get_keys(groups_: Iterable[Group]) -> List[Key]:
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

    def _get_group_keys() -> Iterator[Key]:
        for group in groups_:
            yield Key(
                [MOD],
                group.name,
                lazy.group[group.name].toscreen(),
                desc=f'Switch to group {group.name}',
            )
            yield Key(
                [MOD, 'shift'],
                group.name,
                lazy.window.togroup(group.name, switch_group=True),
                desc=f'Switch to & move focused window to group {group.name}',
            )

    return [
        *_get_base_keys(),
        *_get_group_keys(),
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
keys = get_keys(groups)
layouts = [Tile(border_on_single=False, ratio=0.5)]
screens = get_screens()
mouse = get_mouse_actions()