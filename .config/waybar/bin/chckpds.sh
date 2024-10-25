#!/bin/sh
#
#
# This script depends on 'fuzzel'

UPV=/tmp/upd_versions

fuzzel -d -w 80 -R --prompt="[: $(cat ${UPV} | wc -l)] " --font=monospace:size=9 \
	--background=111111EE --border-color=111111FF --selection-color=111111EE \
	--text-color=999999AA --selection-text-color=999999DA --log-level=none <${UPV} >/dev/null

# Source code: "https://bbs.archlinux.org/viewtopic.php?id=279522"

