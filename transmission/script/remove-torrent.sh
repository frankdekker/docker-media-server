#!/bin/bash

/usr/bin/transmission-remote 127.0.0.1:9091 -l | grep 100% | awk '{print $1}' | xargs -n 1 -I % /usr/bin/transmission-remote 127.0.0.1:9091 -t % -r
