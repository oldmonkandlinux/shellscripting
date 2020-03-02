#!/bin/bash

THISHOST=$(hostname)
LIMIT=60
echo "Swap space report for $THISHOST"
echo
date
echo

###               total        used        free      shared  buff/cache   available

free -m|grep -i swap|while read junk total used free 
do

PERCENT_USED=$(bc <<EOF
scale=4
($used / $total) * 100
EOF
)

PERCENT_FREE=$(bc <<EOF
scale=4
($free / $total) *100
EOF
)

echo "Total swap space is : $total MB"
echo "free swap space is : $free MB"
echo "used swap space is : $used MB"
echo "used percentage of swap space is : $PERCENT_USED %"
echo "free percentage of space is : $PERCENT_FREE %"
echo

INT_PERCENT_USED=$(echo $PERCENT_USED | cut -d. -f1)

if (($INT_PERCENT_USED >= $LIMIT))
then 
echo "WARNING: Paging swap has exceeded the limit: $LIMIT ";
fi

done 

