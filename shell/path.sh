#!/bin/sh

# system default: /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
PATH=$(npm bin -g 2> /dev/null):$PATH
export PATH=./node_modules/.bin:$HOME/Code/gitflow:$HOME/bin:$PATH

