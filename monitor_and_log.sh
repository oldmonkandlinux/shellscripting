#!/bin/bash

LOGFILE="status.log"

[[ ! -s $LOGFILE ]] && touch $LOGFILE

PROCESS="$1"
SCRIPTNAME=$(basename $0)
TTY=$(tty)

########functions########
usage() {
echo
echo "USAGE: $SCRIPTNAME [process-to-monitor]"
echo
}


monitor_start() {
START_RC="-1"

until (( $START_RC == 0 ))
do
 ps -ef|grep -i "$PROCESS"|grep -v grep|grep -v "$SCRIPTNAME" >/dev/null
 START_RC=$?
 sleep 1
done
TIMESTAMP=$(date +%d_%m_%Y_%T)
echo "START PROCESS: $PROCESS began ==> $TIMESTAMP" >> $LOGFILE &
echo "START PROCESS: $PROCESS began ==> $TIMESTAMP" > $TTY
}

monitor_end() {
END_RC="0"
until (( $END_RC != 0  ))
do
 ps -ef|grep -i "$PROCESS"|grep -v grep|grep -v "$SCRIPTNAME" >/dev/null
 END_RC=$?
 sleep 1
done
TIMESTAMP=$(date +%d_%m_%Y_%T)
echo "END PROCESS: $PROCESS end ==> $TIMESTAMP" >> $LOGFILE &
echo "END PROCESS: $PROCESS end ==> $TIMESTAMP" > $TTY
exit 2
}

trap_exit() {
TIMESTAMP=$(date +%d_%m_%Y_%T)
echo "MON START: Monitoring for $PROCESS began ==> $TIMESTAMP"| tee -a $LOGFILE
kill -9 $(jobs -p) 2>/dev/null

}

#######main#############
trap 'trap_exit;exit 0' 1 2 3 15
if (( $# < 1 )) 
then
 usage
 exit 1
fi

ps -ef|grep -i "$PROCESS"|grep -v grep|grep -v "$SCRIPTNAME" >/dev/null

PROC_RC=$?

if (( $PROC_RC == 0 )) 
then
 echo "The process is currently running and is being monitored"
 RUN="Y"
else
 echo "The process is not running"
 RUN="N"
fi

TIMESTAMP=$(date +%d_%m_%Y_%T)
echo "MON START: Monitoring for $PROCESS began ==> $TIMESTAMP"| tee -a $LOGFILE
while :
do 
 case $RUN in
 'N') monitor_start
     ;;
 'Y') monitor_end
     ;;
 esac
done 









