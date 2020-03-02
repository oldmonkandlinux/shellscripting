#!/bin/bash
PROCESS="ntp"
MAILIST="ashish882000@yahoo.co.in"
MAILFILE="mailfile.out"
TIMESTAMP=$(date +%m%d%y%H%M%S)
APPS_LOG="app.log"
[ -s $APP_LOG ] || touch $APP_LOG

PROCESS_COUNT=$(ps -ef|grep "$PROCESS"|grep -v grep|wc -l)

if (( $PROCESS_COUNT == 0 ))
then
 echo "$PROCESS is down: Attempting Restart" > $MAILFILE
 sendmail -f groupmailbox.com $MAILIST < $MAILFILE
 echo "ERROR: $TIMESTAMP $PROCESS DOWN  - Attempting Restart" >> $APPS_LOG
 systemctl start ntpd 2>&1 >> $APPS_LOG
fi
