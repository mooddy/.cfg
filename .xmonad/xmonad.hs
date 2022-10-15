import XMonad
import XMonad.Util.EZConfig

import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.Combo
import Xmonad.Layout.Square

main :: IO()
main = xmonad
     .ewmhFullscreen
     .ewmh
     .withEasySB (statusBarProp "polybar" (pure myPolybarPP)) defToggleStrutsKey
     $ myConfig


myConfig = def
    { modMask = mod4Mask
    , layoutHook = spacingRaw True (Border 0 3 3 3) True (Border 3 3 3 3) True $ myLayout
    , terminal = "urxvt"
    , borderWidth = 3
    , focusedBorderColor = "#004EFF" 
    }

myLayout = tiled ||| Mirror tiled ||| threeCol ||| Full ||| noBorders Full
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1 --Number of master pane
    delta    = 3/100 -- %of screeni to incremnet when resizing panesa
    ratio    = 1/2  --Default porpotion of the screen occupied by the master pane


myPolybarPP :: PP
myPolybarPP = def

