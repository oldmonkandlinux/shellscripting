#!/bin/bash


####functions######
cleanup() {
SCP="/usr/bin/scp"
REMOTE="192.168.1.1"
$SCP $LOGFILE ashish@$REMOTE:/tmp
compress $LOGFILE
exit

}

trap 'cleanup' 1 2 3 9 15
####main#####
TIMESTAMP=$(date +%m%d%y%H%M%S)
THISHOST=$(hostname|cut -d. -f1)
LOGDIR=/root/shell-practise
LOGFILE=${THISHOST}.${LOGNAME}.${TIMESTAMP}
touch $LOGDIR/$LOGFILE
stty erase ^?

chmod 600 $LOGDIR/$LOGFILE

script $LOGDIR/$LOGFILE

chmod 400 $LOGDIR/$LOGFILE

cleanup
