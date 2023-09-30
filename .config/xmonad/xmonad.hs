import XMonad

import XMonad.Util.Cursor
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce

import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Actions.MouseResize
import XMonad.Layout.WindowArranger

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks 

import XMonad.Hooks.ManageHelpers

import XMonad.Util.Run  
import System.IO  

import XMonad.Util.Loggers
import XMonad.Util.Run

import Control.Monad (liftM2)
import qualified XMonad.StackSet as W
myTerminal = "urxvt"


main :: IO ()
main = xmonad
     .ewmhFullscreen
     .ewmh
--     .withEasySB (statusBarProp "polybar" (pure myPolybarPP)) defToggleStrutsKey
     .withEasySB (statusBarProp "xmobar" ( pure myXmobarPP)) defToggleStrutsKey   
     $ myConfig

myConfig = def
    { modMask                = mod4Mask
    , layoutHook             = myLayout
    -- , layoutHook          = spacingRaw True (Border 0 3 0 0) True (Border 0 3 0 0) True $ myLayout
    , borderWidth            = 4
--    , terminal             :: String
    , terminal               = myTerminal
--    , terminalClass        = "urxvt"
    , focusedBorderColor     = "#FF0000" 
    , normalBorderColor      = "#000000"
    , startupHook            = myStartupHook
    , workspaces             = myWorkspaces
    }
     
    
  `additionalKeysP`
   [ ("M-f",        spawn "apulse firefox --private-window")
   , ("M-s",        spawn "surf https://www.duckduckgo.com")
   , ("M-g",        spawn "google-chrome")
   , ("M-r",        spawn "brave-browser --incognito")
   , ("M-C-s", unGrab *> spawn "scrot -s")
   , ("M-p",            spawn "dmenu_run")
   --, ("M-t",        spawn "telegram-desktop")
   , ("M-a",        spawn $ myTerminal ++ " --title Ranger -e ranger")
   , ("M-S-a",      spawn $ myTerminal ++ " --title Hash-Ranger -e sudo ranger")
--   , ("M-l",        spawn $ myTerminal ++ " --title Ranger -e sudo lf")
   , ("M-d",        spawn "dolphin")
   , ("M-c",        spawn "clipmenu")
   , ("M-C-q",      spawn "lxsession-logout")
   , ("M-i",         spawn $ myTerminal ++ " -e sudo ibus-daemon -dxr")

--
--volume control --
--
   , ("<XF86AudioLowerVolume>",   spawn "amixer -c 0 set Master 1-")
   , ("<XF86AudioRaiseVolume>",   spawn "amixer -c 0 set Master 1+")
   , ("<XF86AudioMute>"       ,   spawn "amixer -c 0 set Master toggle")
   ] 
   
myLayout = mouseResize $ noBorders Full ||| Full ||| Mirror tiled ||| tiled ||| threeCol
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
    { ppSep             = magenta " ∙ "  
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = xmobarColor "#7ef3e4" "" .wrap " " " " 
    , ppHidden          = white . wrap " " " "
    , ppHiddenNoWindows = lowWhite . wrap "" " " 
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
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 40

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#ffffff" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#b4b7b5" ""
    

myWorkspaces = ["| \xf1a5 ", "| \xf127 ", "| \xf2c6 ", "| \xf113 ", "| \xf269 ", "| \xf1b2 ", "| \xf121 ", "| \xf292 ", "| \xf016c "]

myStartupHook :: X ()
myStartupHook = do
                ---Xmobar kill & reopen--
                spawn "killall -q xmobar & sleep 4 &&  xmobar &"
                
                --Trayer kill & repon--
                spawn "killall -q trayer & sleep 10 && trayer --edge top --align right --SetDockType true --SetPartialStrut true  --expand false --widthtype request --transparent true --alpha 0 --tint 0x000000 --height 18 &" 
                ---VoluemIcon---
                spawnOnce "volumeicon &"
                
                --Trayer Intregation--
                spawn "bash /home/nemi/.config/xmobar/trayer-padding-icon.sh"
                 
                --Conky--
                spawn "killall -q conky & sleep 1 && conky -q -c /home/nemi/.config/conky/conkyrc&"

                --Wallpaper--
                spawn "sh  /home/nemi/.config/x11/scripts/wallpaper.sh "

