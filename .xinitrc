feh --bg-scale --no-fehbg --randomize --recursive /home/nemi//Downloads/wallpapers &
xrdb .Xresources &
rm -rf .surf/ .cache/ .mozilla/ .config/BraveSoftware/ &
xsetroot -cursor_name left_ptr &
setxkbmap us,np -option grp:ctrl_shift_toggle &
exec xmonad

