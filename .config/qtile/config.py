from typing import Iterable, Iterator, List, Tuple

from libqtile.bar import Bar
from libqtile.config import Click, Drag, Group, Key, Mouse, Screen
from libqtile.layout import Max, Tile
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.widget import (
    Battery, Chord, Clock, CurrentLayout, GroupBox, Systray, WindowName,
)

MOD = 'mod4'


def get_groups() -> List[Group]:
    named_groups = (
        Group('main', spawn='aw-qt'),
        Group('dev', spawn='emacs'),
        Group('www', spawn='firefox'),
    )
    non_named_groups = (Group(str(index))
                        for index in range(len(named_groups) + 1, 10))
    return [*named_groups, *non_named_groups]


def get_keys(groups_: Iterable[Group]) -> List[Key]:
    def _get_group_keys(keys_and_groups: Iterable[Tuple[str, Group]]) \
      -> Iterator[Key]:
        for key, group in keys_and_groups:
            yield Key(
                [MOD],
                key,
                lazy.group[group.name].toscreen(),
                desc=f'Switch to group {group.name}',
            )
            yield Key(
                [MOD, 'shift'],
                key,
                lazy.window.togroup(group.name, switch_group=True),
                desc=f'Switch to & move focused window to group {group.name}',
            )

    return [
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
        Key([MOD], 't', lazy.window.toggle_floating(), desc='Toggle floating'),

        Key([MOD], 'f', lazy.next_layout(), desc='Toggle between layouts'),
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
        Key([], 'Print', lazy.spawn('scrot'), desc='Screenshot'),
        Key([MOD], 'space', lazy.spawn(guess_terminal()),
            desc='Launch terminal'),
        Key([MOD], 'd', lazy.spawn('dmenu_run'), desc='Dmenu'),

        *_get_group_keys((str(key), group)
                         for key, group in enumerate(groups_, start=1)),
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
            Battery(format='{char} {percent:2.0%}', charge_char='▲',
                    discharge_char='▼'),
            Systray(),
            Clock(format='%a %Y-%m-%dT%H:%M'),
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


groups = get_groups()
keys = get_keys(groups)
layouts = [Tile(border_on_single=False, ratio=0.5), Max()]
screens = get_screens()
mouse = get_mouse_actions()
