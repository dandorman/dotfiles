#!/bin/sh

export JSTESTDRIVER_HOME=/usr/local/bin

jstd_versions=`ls -t ${JSTESTDRIVER_HOME}/JsTestDriver*`

alias jstd="java -jar ${jstd_versions[0]}"

alias jstd.server='jstd --port 4224'
alias jstd.s='jstd.server'

alias jstd.all='jstd --tests all'
alias jstd.a='jstd.all'

