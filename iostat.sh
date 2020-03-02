#!/bin/bash

####%user   %nice %system %iowait  %steal   %idle
####0.72    0.02    0.72    0.03    0.00   98.51

SECS=10
INTERVAL=2

iostat -c $SECS $INTERVAL |grep -Ev '[a-zA-Z]|^$'|sed -e 's/^\s*//g'|awk '{print $1, $2, $3, $4, $5, $6}'|while read iostat_USER NICE SYSTEM IOWAIT STEAL IDLE
do
 echo "User part is $iostat_USER"
 echo "Nice part is $NICE"
 echo "system part is $SYSTEM"
 echo "iowait part is $IOWAIT"
 echo "IDLE part is $IDLE"
done
