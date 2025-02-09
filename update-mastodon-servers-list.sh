#!/bin/bash

# Copyright (C) 2020  Andrew Larson (github-alt@drewj.la)
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# requires a file downloader to work
command -v wget >/dev/null 2>&1 && wget=0 || wget=1
command -v curl >/dev/null 2>&1 && curl=0 || curl=1
if [ $wget -eq 1 ] && [ $curl -eq 1 ]; then
  echo "Error: this tool requires either \`wget\` or \`curl\` to be installed." >/dev/stderr
  exit 1
fi

# check to make sure we are online
echo -e "GET http://google.com HTTP/1.0\n\n" | nc google.com 80 > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Error: this tool requires internet access to work."
  exit 1
fi

URL="https://instances.social/list/old"
JS_FILE="./js/custom.js"
TEMP_FILE="temp.txt"

# determines how to download based on availability of `wget` and `curl`
dlFile() {
  url="$1"
  # use wget, otherwise, use curl
  if [ $wget -eq 0 ]; then
    wget -qO - "$url" > /dev/stdout
 elif [ $curl -eq 0 ]; then
    curl -sL "$url"
  fi
}

# gets sorted array of Mastodon servers (only the ones that are UP; running)
servers=($(dlFile "${URL}" | grep -A 3 -F '<td class="table-success">UP</td>' | grep -oP 'scope="row".*href="https?://\K[^"]+' | sort))

# creates JS object code
echo -en "\nConverting server list to JS object"
echo -n "let mastodonServers = {" > "${TEMP_FILE}"
index=0
for server in "${servers[@]}"
do
  # echo progress dots
  ! (( index % 500 )) && echo -n " ."

  # create servers as keys, with their values being their URI encoded counterpart
  serverPartialEncoded=${server//./%2E} # encode periods to throw off domain detection on Twitter
  echo -n "'$server': '$serverPartialEncoded'" >> "${TEMP_FILE}"
  index=$((index+1))
  if [ $index -eq ${#servers[@]} ]; then
    echo "};" >> "${TEMP_FILE}"
  else
    echo -n ", " >> "${TEMP_FILE}"
  fi
done
# updates custom.js with new mastodon servers if any
sed -i -e '/let mastodonServers \=/{r '"${TEMP_FILE}"'' -e 'd}' "${JS_FILE}"
rm -f "${TEMP_FILE}"
echo -e "\nDone."
