#!/bin/bash

PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"

echo '{ "packages":'
echo '['
dpkg -l | grep -E "^.i" | awk '{ print $2"="$3 }'
echo ']'
echo '}'
