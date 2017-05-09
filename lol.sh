#!/bin/bash

# yes, i know this is a terrible idea

# lol
read firstLine

echo "HTTP/1.0 200 OK"
echo "Content/Type: text/plain"
echo ""

# Really gross hack
# Exit if we're not explicitly called with the path "/";
# browsers may request favicon.ico and we don't want that to trigger the counter
# TODO: check if this works when run directly and not just through nginx
if ! grep 'GET / ' <<< "$firstLine" > /dev/null; then
    # this should return an HTTP error, but whatever, this whole script total crap anyway :P
    echo "nope"
    exit
fi

now=$(date -u +'%Y-%m-%dT%H:%M:%SZ')

echo "It's $now"
# redis-cli seemingly returns the count in stdout by default, so no need to run an extra command
numVisits=$(redis-cli -h redis RPUSH visits "$now")

times_="times"

if [[ $numVisits == 1 ]]; then
    times_="time"
fi

echo "and you've visited this site $numVisits $times_"
echo ""
echo ""
echo "-- your friendly shell script at $(hostname) <3"
