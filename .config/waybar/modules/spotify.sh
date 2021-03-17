#!/bin/sh

class=$(playerctl metadata --player=spotify --format '{{lc(status)}}')


info=$(playerctl metadata --player=spotify --format '{{artist}}[{{album}}]: {{title}}')
if [[ ${#info} > 70 ]]; then
  info=$(echo $info | cut -c1-70)"..."
fi
text=$info


echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
