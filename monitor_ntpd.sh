#!/bin/bash

PROCESS=ntpd
SCRIPTNAME=$(basename $0)

RC=1

until (( RC == 0 )) 
do
  ps -ef| grep $PROCESS|grep -v grep|grep -v $SCRIPTNAME >/dev/null 2>&1
if (( $? == 0 )) 
then
 echo "$PROCESS is running `date`"
 echo
 echo
 ps -ef| grep $PROCESS|grep -v grep|grep -v $SCRIPTNAME
 echo
  exit 0
fi
sleep 20
done
