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

import XMonad.Util.Loggers

main :: IO()
main = xmonad
     .ewmhFullscreen
     .ewmh
--     .withEasySB (statusBarProp "polybar" (pure myPolybarPP)) defToggleStrutsKey
     .withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey   
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

myLayout = noBorders Full ||| Full ||| Mirror tiled ||| tiled ||| threeCol
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1 --Number of master pane
    delta    = 3/100 -- %of screeni to incremnet when resizing panes
    ratio    = 1/2  --Default porpotion of the screen occupied by the master pane


--myPolybarPP :: PP
--myPolybarPP = def


myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Bottom" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 50

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
