#!/bin/sh

UPD=/tmp/updates
UPV=/tmp/upd_versions
percentage="100"

[ -x /usr/bin/fuzzel ] &&
	menu="(on click: view updates)" ||
	menu="(on click: *please install 'fuzzel'*)"

if [ -s ${UPV} ]; then
	[ "$(tail -n 1 ${UPD})" -gt "$(tail -n 2 ${UPD} | head -n 1)" ] &&
		class="new-updates" ||
		class="updates"

	tooltip=$(tail -n 1 ${UPD})
else
	class="up-to-date"
	tooltip="0"
fi

[ "${class}" = "up-to-date" ] && percentage="0"

printf '%s\n' "{\"class\":\"$class\",\"percentage\": $percentage,\"tooltip\":\"Updates: $tooltip\n\n$menu\n(right-click: refresh db)\"}"

# Source code: "https://bbs.archlinux.org/viewtopic.php?id=279522"
