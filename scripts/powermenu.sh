#! /bin/sh

chosen=$(printf "  Power Off\n  Restart\n  Lock\n  Logout\n鈴 Sleep" | rofi -dmenu -i -font "Fira Code Nerd Font 12")

case "$chosen" in
		"  Power Off") poweroff ;;
			"  Restart") reboot ;;
				"  Lock") i3lock-fancy ;;
         "  Logout") i3-msg exit ;;
         "鈴 Sleep") systemctl suspend ;;
					*) exit 1 ;;
				esac
