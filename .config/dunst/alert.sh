#!/bin/bash

# Skip alert for mpdnotify
if [[ "$1" == "Spotify" ]]
then
       exit 0
fi
if [[ "$1" == "Strawberry" ]]
then
       exit 0
fi

paplay ~/.config/dunst/message.oga
