#!/bin/bash

SCRIPTNAME=$(basename $0)
PING_COUNT=3
if (( $# < 1 ))
then
 echo "USAGE: $SCRIPTNAME [hostname]"
exit 1
fi

HOST="$1"
trap 'echo "Exiting on a trapped signal";exit 88' 1 2 3 15
ping $HOST -c $PING_COUNT >/dev/null

RC1=$?

if (( $RC1 != 0)) 
then
 echo "$HOST has issues, will ping again in 10 secs"
 sleep 10
ping $HOST -c $PING_COUNT >/dev/null
RC2=$?
if (( $RC2 != 0))
then
 echo "ERROR: $HOST definitely has issues, sending notification"
fi
else
 echo "$HOST is reachable"
fi
