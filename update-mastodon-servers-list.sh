#!/bin/bash

URL="https://instances.social/list/old"
JS_FILE="./js/custom.js"
TEMP_FILE="temp.txt"

# gets sorted array of Mastodon servers (only the ones that are UP; running)
servers=($(curl "${URL}" | grep -A 3 -F '<td class="table-success">UP</td>' | grep -oP 'scope="row".*href="https?://\K[^"]+' | sort))

# creates JS object code
echo -en "\nConverting server list to JS object"
jsObject="let mastodonServers = {"
index=0
for i in "${servers[@]}"
do
  # echo progress dots
  ! (( index % 500 )) && echo -n " ."

  # create servers as keys, with `true` boolean as values
  jsObject="${jsObject}\"$i\": true"
  index=$((index+1))
  if [ $index -eq ${#servers[@]} ]; then
    jsObject="${jsObject}};"
  else
    jsObject="${jsObject}, "
  fi
done
echo "$jsObject" > "${TEMP_FILE}"
# updates custom.js with new mastodon servers if any
sed -i -e '/let mastodonServers \=/{r '"${TEMP_FILE}"'' -e 'd}' "${JS_FILE}"
rm -f "${TEMP_FILE}"
echo -e "\nDone."
