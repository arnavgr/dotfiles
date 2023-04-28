#startup programs
xbanish &
slstatus &
dunst &
xinput set-prop "ELAN1300:00 04F3:3057 Touchpad" "libinput Tapping Enabled" 1 &
xautolock -time 10 -locker "slock" -killtime 30 -killer "systemctl suspend" -corners '000-' -detectsleep & 
udiskie &
feh --bg-scale ~/Pictures/dracula-arch.jpg &
picom -f &

# loop to restart dwm
while true; do
    # Log stderror to a file 
    dwm 2> ~/.dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done

#start dwm
exec dwm


