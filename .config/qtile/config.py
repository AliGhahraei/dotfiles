from subprocess import Popen
from typing import Iterable, Iterator, List, Tuple, Callable

from libqtile.backend.base import Window
from libqtile.bar import Bar
from libqtile.config import Click, Drag, Group, Key, Mouse, Screen
from libqtile.core.manager import Qtile
from libqtile.hook import subscribe
from libqtile.layout import MonadTall
from libqtile.lazy import lazy
from libqtile.log_utils import logger
from libqtile.utils import guess_terminal
from libqtile.widget import (
    Battery, Chord, Clock, CurrentLayout, GroupBox, Pomodoro, PulseVolume,
    Systray, TextBox, WindowName,
)
from Xlib.display import Display
from Xlib.ext.randr import GetOutputInfo

MOD = 'mod4'
PURPLE = 'a663e6'
EDITOR = 'emacs'

HOME_GROUP_NAME = '1'
DEV_GROUP_NAME = '2'
WWW_GROUP_NAME = '3'


GROUPS_TO_PROGRAMS_AND_WM_CLASSES = {
    DEV_GROUP_NAME: (EDITOR, 'Emacs'),
    WWW_GROUP_NAME: ('firefox', 'firefox'),
}


def get_groups() -> List[Group]:
    labelled_groups = (
        Group(HOME_GROUP_NAME, label='home'),
        Group(DEV_GROUP_NAME, label='dev'),
        Group(WWW_GROUP_NAME, label='www'),
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
            Key([MOD], 'Return', lazy.layout.swap_main(),
                desc='Swap focused window with main'),

            Key([MOD, 'shift'], 'h', lazy.layout.shuffle_left(),
                desc='Move window to the left'),
            Key([MOD, 'shift'], 'l', lazy.layout.shuffle_right(),
                desc='Move window to the right'),
            Key([MOD, 'shift'], 'j', lazy.layout.shuffle_down(),
                desc='Move window down'),
            Key([MOD, 'shift'], 'k', lazy.layout.shuffle_up(),
                desc='Move window up'),

            Key([MOD, 'control'], 'h', lazy.layout.shrink_main(),
                desc='Shrink main window'),
            Key([MOD, 'control'], 'l', lazy.layout.grow_main(),
                desc='Grow main window'),
            Key([MOD, 'control'], 'r', lazy.layout.reset(),
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
            Key([], 'Print', lazy.spawn('screenshot'),
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
    def _get_screens(number_of_monitors: int) -> List[Screen]:
        shared_top_right_widgets = (
            Chord(
                chords_colors={'launch': ('#ff0000', '#ffffff')},
                name_transform=lambda name: name.upper(),
            ),
            Pomodoro(
                length_pomodori=50,
                length_short_break=10,
                length_long_break=30,
                update_interval=1,
                color_inactive=PURPLE,
            ),
            TextBox(text="墳"),
            PulseVolume(),
            Battery(format='{char} {percent:2.0%}',
                    charge_char='▲', discharge_char='▼'),
            Clock(format=' %a %Y-%m-%d   %H:%M'),
        )
        bar_size = 24

        return [
            Screen(top=Bar(
                [
                    *_create_screen_specific_widgets(),
                    Systray(),
                    *shared_top_right_widgets,
                ],
                bar_size,
            )),
            *(
                Screen(top=Bar(
                    [
                        *_create_screen_specific_widgets(),
                        *shared_top_right_widgets,
                    ],
                    bar_size,
                ))
                for _ in range(number_of_monitors - 1)
            )
        ]

    def _create_screen_specific_widgets() -> Tuple:
        return (
            GroupBox(),
            CurrentLayout(),
            WindowName(),
        )

    def _get_number_of_monitors_on() -> int:
        # Adapted from Qtile's wiki
        # (https://github.com/qtile/qtile/wiki/screens#setup-multiple-screens-dynamically)
        try:
            display = Display()
            screen = display.screen()
            resources = screen.root.xrandr_get_screen_resources()
            timestamp = resources.config_timestamp

            on_count = len([monitor for output in resources.outputs if _is_on(
                monitor := display.xrandr_get_output_info(output, timestamp)
            )])
        except Exception as e:
            logger.exception(f'Error found while detecting monitors: {e}')
            return 1
        else:
            return on_count

    def _is_on(monitor: GetOutputInfo) -> bool:
        # Couldn't find docs about attributes, but wiki uses them
        return bool(getattr(monitor, 'preferred', False)
                    or getattr(monitor, "num_preferred", False))

    monitors_on = _get_number_of_monitors_on()
    logger.info(f'Number of monitors detected: {monitors_on}')
    return _get_screens(monitors_on)


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
layouts = [MonadTall(single_border_width=0, border_focus=PURPLE,
                     new_client_position='top')]
screens = get_screens()
mouse = get_mouse_actions()
