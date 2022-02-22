{-# OPTIONS -fno-warn-missing-signatures #-}
import System.IO (hPutStrLn)


import XMonad (mod4Mask)

import XMonad.Actions.WindowGo ((<+>), (=?), (-->), className, composeAll, doFloat
                               , doIgnore, doShift, raiseMaybe
                               )
import XMonad.Actions.OnScreen (viewOnScreen)

import XMonad.Core (focusedBorderColor, handleEventHook, layoutHook, logHook, manageHook
                   , modMask, normalBorderColor, spawn, terminal, whenJust, workspaces
                   )

import XMonad.Hooks.DynamicLog (def, dynamicLogWithPP, ppOutput, ppTitle, shorten
                               , xmobarColor, xmobarPP
                               )
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks (manageDocks, docksEventHook, avoidStruts)
import XMonad.Hooks.ManageHelpers (doFullFloat, isFullscreen)

import XMonad.Layout (Tall(..))
import XMonad.Layout ((|||), ChangeLayout(NextLayout))
import XMonad.Layout.MultiToggle ((??), EOT(..), mkToggle, Toggle(..))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(FULL, NOBORDERS))
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.SimpleFloat (simpleFloat)

import XMonad.Main (xmonad)

import XMonad.Operations (kill, sendMessage, screenWorkspace, windows)

import XMonad.StackSet (view, shift)

import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Util.Run (spawnPipe)


main = do
  xmproc <- spawnPipe "xmobar ~/.config/xmonad/xmobar.hs"
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
    , (action, mask) <- [ (view, "") , (shift, "S-")]
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
