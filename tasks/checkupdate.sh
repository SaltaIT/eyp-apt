#!/bin/bash

PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"

echo '{ "updates":'
echo '['
apt-get --just-print upgrade | grep Inst | awk '{print "\""$2,"=",$4"\"" }' | sed 's/ = (/=/g' | paste -sd,
echo ']'
echo '}'
