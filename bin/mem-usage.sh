#!/bin/bash
#
# Runs the command, collects its memory usage stats and plots them on a graph.
#   Usage: mem-usage.sh command

CMD=$1; shift
$CMD "$@" &
PID=$!

DAT_PATH=/tmp/mem-usage-$PID.dat
PNG_PATH=/tmp/mem-usage-$PID.png

while ps -p $PID > /dev/null; do
  top -pid $PID -l 1 -stats mem | tail -n 1 | grep -v -e '^[[:space:]]*$' | awk -v now=$(date +%s) '{print now,$1}' >> $DAT_PATH
done

usage-plot.gp $DAT_PATH $PNG_PATH 2> /dev/null
open $PNG_PATH

