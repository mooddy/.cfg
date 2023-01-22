#!/bin/sh

###Walpaper Setter ###
feh --bg-scale --no-fehbg --randomize --recursive /home/nemi//Downloads/wallpapers &

##Fonts and Style ###
xrdb .Xresources &

### Conky ###
conky &

#trayer --edge top --align right --SetDockType true --SetPartialStrut true \ --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 &

### Browser History ###
rm -rf .surf/ .cache/ .mozilla/ .config/BraveSoftware/ &

### Crusor icon ###
xsetroot -cursor_name left_ptr &

### Language ###
setxkbmap us,np -option grp:ctrl_shift_toggle &

### volume all max ###
## Headphone ##
amixer set Headphone 100% &
##Speaker##
amixer set Front 100% &

### Launch xmonad ###
exec dbus-launch xmonad

