#!/bin/sh

# system default: /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
# rearranged to make /usr/local/bin more prominent
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
PATH=/usr/local/heroku/bin:$PATH
PATH=$(npm bin -g 2> /dev/null):$PATH
PATH=$HOME/bin:$PATH
PATH=./node_modules/.bin:$PATH
export PATH=./bin:$PATH
