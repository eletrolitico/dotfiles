#!/bin/bash

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')

info=$(playerctl metadata --player=spotify --format '{{artist}}: {{title}}')

cut=60

if [[ ${#info} > $cut ]]; then
  info=$(echo $info | cut -c1-$cut)"..."
fi


echo -e "{\"text\":\""$info"\", \"class\":\""$class"\"}"
