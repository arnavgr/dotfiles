#startup programs
xautolock -time 10 -locker "slock" -killtime 30 -killer "systemctl suspend" -corners '000-' -detectsleep & 
slstatus &
feh --bg-scale ~/Downloads/pxfuel.jpg &
picom -f &

#enable tap to click
xinput set-prop "ELAN1300:00 04F3:3057 Touchpad" "libinput Tapping Enabled" 1 &

# loop to restart dwm
while true; do
    # Log stderror to a file 
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done

#start dwm
exec dwm


