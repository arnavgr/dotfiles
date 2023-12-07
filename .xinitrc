#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
    # if not found, launch a new one
    eval `dbus-launch --sh-syntax --exit-with-session`
    echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

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
exec dbus-run-session dwm


