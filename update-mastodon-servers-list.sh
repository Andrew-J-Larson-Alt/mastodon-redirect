#!/bin/bash

URL="https://instances.social/list/old"
JS_FILE="./js/custom.js"
TEMP_FILE="temp.txt"

# gets sorted array of mastodon servers
servers=($(curl "${URL}" | grep -A 3 -F '<td class="table-success">UP</td>' | grep -oP 'scope="row".*href="https?://\K[^"]+' | sort))

# creates JS object code
echo -en "\nConverting server list to JS object"
jsObject="let mastodonServers = {"
index=0
for i in "${servers[@]}"
do
  ! (( index % 500 )) && echo -n " ."
  
  jsObject="${jsObject}\"$i\": true"
  index=$((index+1))
  if [ $index -eq ${#servers[@]} ]; then
    jsObject="${jsObject}};"
  else
    jsObject="${jsObject}, "
  fi
done
echo "$jsObject" > "${TEMP_FILE}"
sed -i -e '/let mastodonServers \=/{r '"${TEMP_FILE}"'' -e 'd}' "${JS_FILE}"
rm -f "${TEMP_FILE}"
echo -e "\nDone."
