feh --bg-scale --no-fehbg --randomize --recursive /home/nemi//Downloads/wallpapers &

xrdb .Xresources &

conky &

trayer --edge top --align right --SetDockType true --SetPartialStrut true \ --expand true --width 10 --transparent true --tint 0x5f5f5f --height 18 &

rm -rf .surf/ .cache/ .mozilla/ .config/BraveSoftware/ &

xsetroot -cursor_name left_ptr &

setxkbmap us,np -option grp:ctrl_shift_toggle &

exec dbus-launch xmonad

