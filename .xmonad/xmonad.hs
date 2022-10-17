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

main :: IO()
main = xmonad
     .ewmhFullscreen
     .ewmh
     .withEasySB (statusBarProp "polybar" (pure myPolybarPP)) defToggleStrutsKey
     $ myConfig


myConfig = def
    { modMask = mod4Mask
    , layoutHook = spacingRaw True (Border 0 3 0 0) True (Border 0 3 0 0) True $ myLayout
    , terminal = "urxvt"
    , borderWidth = 3
    , focusedBorderColor = "#004EFF" 
    , startupHook = setDefaultCursor xC_left_ptr
    }
  `additionalKeysP`
   [ ("M-f",        spawn "apulse firefox")
   , ("M-s",        spawn "tabbed -c surf -e")
   , ("M-g",        spawn "google-chrome")
   , ("M-C-s", unGrab *> spawn "scrot -s")
   ]    

myLayout = tiled ||| Mirror tiled ||| threeCol ||| Full ||| noBorders Full
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1 --Number of master pane
    delta    = 3/100 -- %of screeni to incremnet when resizing panesa
    ratio    = 1/2  --Default porpotion of the screen occupied by the master pane


myPolybarPP :: PP
myPolybarPP = def

