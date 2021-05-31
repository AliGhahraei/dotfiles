{-# OPTIONS -fno-warn-missing-signatures #-}

import XMonad

import XMonad.Actions.WindowGo
import XMonad.Actions.OnScreen

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName()
import XMonad.Hooks.ManageHelpers

import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.SimpleFloat

import qualified XMonad.StackSet as W

import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)

import System.IO


main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
  xmonad $ ewmh def
    -- Xmobar needs this to show the window title, the workspaces, etc.
    { logHook           = dynamicLogWithPP xmobarPP
      { ppOutput        = hPutStrLn xmproc
      , ppTitle         = xmobarColor "green" "" . shorten 50
      }
    -- XMonad doesn't cover xmobar with this. It also activates class rules
    , manageHook        = userManageHook <+> manageDocks <+> manageHook def
    -- This prevents xmobar from being covered in the first workspace
    , handleEventHook   = docksEventHook <+> handleEventHook def
    , layoutHook        = userLayout 
    -- , workspaces        = userWorkspaces
    , terminal          = userTerminal
    , modMask           = userModMask
    , normalBorderColor = userNormalBorderColor
    , focusedBorderColor= userFocusedBorderColor
    } 
    `additionalKeysP` userKeys 
    `removeKeysP` userRemovedKeys

userKeys =
    [ ("M-w"                   , kill)
    , ("M-n"                   , sendMessage NextLayout)
    , ("M-f"                   , sendMessage $ Toggle FULL)
    , ("M-r"                   , spawn "if type xmonad; then xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi")
    , ("M-d"                   , spawn "dmenu_run") 
    , ("<XF86AudioRaiseVolume>", spawn "pamixer --increase 5 --unmute")
    , ("<XF86AudioLowerVolume>", spawn "pamixer --decrease 5 --unmute")
    , ("<XF86AudioMute>"       , spawn "pamixer --toggle-mute")
    , ("<Print>"               , spawn "scrot")
    , ("M-<Space>"             , spawn userTerminal)
    -- , ("M-2"                   , switchAndRunOrRaise "code" editor editorClass)
    -- , ("M-3"                   , switchAndRunOrRaise "web" browser browserClass)
    ]
    ++
    [ (mask ++ "M-" ++ [key], screenWorkspace scr
        >>= flip whenJust (windows . action))
    | (key, scr)  <- zip "yui" [0..]
    , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ]

userRemovedKeys =
    [ "M-p"
    ]
    

editor                 = "emacs"
editorClass            = "Emacs"
browser                = "firefox-developer-edition"
browserClass           = "firefoxdeveloperedition"

userTerminal           = "kitty"
userNormalBorderColor  = "#FFFFFF"
userFocusedBorderColor = "#3137FD"
userModMask            = mod4Mask
userWorkspaces         = map show [1 :: Int .. 2] -- ++ ["editor", "browser"]

userLayout             = smartBorders
                       -- workspace can be toggled and be activated by signal
                       . mkToggle (NOBORDERS ?? FULL ?? EOT)
                       -- layouts won't cover xmobar thanks to avoidStruts
                       $ avoidStruts (tall ||| simpleFloat)
  where tall = Tall 1 (3/100) (1/2)
                               
userManageHook = composeAll
  [ className =? "Gimp"                   --> doFloat
  , className =? "sun-awt-X11-XFramePeer" --> doFloat
  , className =? "trayer"                 --> doIgnore
  , className =? editorClass              --> doShift "editor"
  --, className =? browserClass             --> doShift "browser"
  -- Fixes fullscreen players (like Youtube)
  , isFullscreen                          --> doFullFloat
  ]

switchAndRunOrRaise workspace executable windowClass =
  raiseMaybe (switchAndRun) (className =? windowClass)
    where switchAndRun = sequence_[switch, spawn executable]
            where switch = windows $ viewOnScreen 0 workspace
