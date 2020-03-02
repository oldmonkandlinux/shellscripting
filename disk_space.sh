#!/bin/bash

MIN_MB_FREE="1000MB"
OUTFILE=df.out
>$OUTFILE
WORKFILE=df.temp
>$WORKFILE
THISHOST=`hostname`

df -m|column -t|tail -n +2|grep -Ev '/dev/sr[0-9]|tpmfs|/proc|tmpfs'| awk '{print $1, $4, $6}' > $WORKFILE
MIN_MB_FREE=$(echo $MIN_MB_FREE | sed s/MB//g) 

while read FSDEVICE FSMB_FREE FSMOUNT
do 
   if (( $FSMB_FREE < $MIN_MB_FREE)) 
then
   echo "$FSDEVICE mounted on $FSMOUNT has $FSMB_FREE" >> $OUTFILE
   fi
done < $WORKFILE

if [ -s $OUTFILE ]
then
   echo "Full file system on $THISHOST ";
   cat $OUTFILE
   echo
fi
