import XMonad

import XMonad.Util.Cursor
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.Combo
import XMonad.Layout.Square
import XMonad.Util.Loggers

main :: IO()
main = xmonad
     .ewmhFullscreen
     .ewmh
     .withEasySB (statusBarProp "polybar" (pure myPolybarPP)) defToggleStrutsKey
--     .withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey   
     $ myConfig


myConfig = def
    { modMask = mod4Mask
    , layoutHook = spacingRaw True (Border 0 3 0 0) True (Border 0 3 0 0) True $ myLayout
    , borderWidth = 3
    , terminal = "urxvt"
    , focusedBorderColor = "#FF0000" 
    , normalBorderColor = "#000000"
    , startupHook = setDefaultCursor xC_left_ptr
    }
  `additionalKeysP`
   [ ("M-f",        spawn "apulse firefox")
   , ("M-s",        spawn "surf google.com")
   , ("M-g",        spawn "google-chrome")
   , ("M-r",        spawn "brave-browser --incognito")
   , ("M-C-s", unGrab *> spawn "scrot -s")
   , ("M-t",        spawn "telegram-desktop")
   ]    

myLayout = Mirror tiled ||| tiled ||| threeCol ||| Full ||| noBorders Full
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1 --Number of master pane
    delta    = 3/100 -- %of screeni to incremnet when resizing panes
    ratio    = 1/2  --Default porpotion of the screen occupied by the master pane


myPolybarPP :: PP
myPolybarPP = def

