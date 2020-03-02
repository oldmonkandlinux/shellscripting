#!/bin/bash

MAX_LOAD=2.00
declare -i INT_MAXLOAD
INT_MAXLOAD=$MAXLOAD
THISHOST=$(hostname);
echo "Load for $THISHOST"
echo
LOAD=$(cat /proc/loadavg |awk '{print $1}'|cut -d. -f1)
(($LOAD >= $INT_MAXLOAD)) && echo "WARNING: system load has reached $LOAD"

echo "system has current load at $LOAD"
echo "The threshold is set at $MAX_LOAD" 
