#!/bin/bash

# expects running redis container named workshop_redis
docker build -t workshop/part2 . && docker run --rm -p 5000:5000 --link workshop_redis:redis workshop/part2
