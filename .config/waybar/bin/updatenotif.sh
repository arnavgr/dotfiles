#!/bin/sh
#
#
# This script depends on 'pacman-contrib'


[ "${ULOCKER}" != "$0" ] &&
	exec env ULOCKER="$0" flock -en "$0" "$0" "$@" || :

UPD=/tmp/updates
UPV=/tmp/upd_versions

sleep 9 && echo 0 > ${UPD}

while [ -f ${UPD} ]
	do
		if ping -n -c 1 www.archlinux.org >/dev/null 2>&1
		then
			checkupdates > ${UPV} ; cat ${UPV} | wc -l >> ${UPD} ; sleep 0.5h
		else
			sleep 5m
		fi
	done

# Source code: "https://bbs.archlinux.org/viewtopic.php?id=279522"
