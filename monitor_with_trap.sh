#!/bin/bash

SCRIPTNAME=$(basename $0)

usage() {
echo 
echo "USAGE: $SCRIPTNAME [process-to-monitor]"
echo "Exiting..."
echo
}

send_trap() {
echo
echo "...Exiting on trapped signal..."
echo
}

trap 'send_trap; exit 3' 1 2 3 15

if ((  $# < 1 ))
then
 usage
fi

PROCESS=$1

ps -ef|grep -i "$PROCESS"|grep -v grep|grep -v "$SCRIPTNAME" > /dev/null

if (( $? != 0)) 
then
 echo "$PROCESS is not an active process...EXITING "
 exit 2
fi

RC="0"

while (( $RC == 0 ))
do
 ps -ef|grep -i "$PROCESS"|grep -v grep|grep -v "$SCRIPTNAME" > /dev/null
 
if (( $? != 0 )) 
then
 echo "$PROCESS has completed `date`"
 exit 0
fi

done
