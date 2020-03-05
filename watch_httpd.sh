#!/bin/bash

LOGFILE="error_log"
PATTERN="error"
trap 'echo "Exiting on a trapped signal";exit 88' 1 2 3 15

tail -fn0 $LOGFILE|while read line 
do
echo "$line"|grep -iq "$PATTERN"
if [ $? == 0 ] 
then
 echo "HTTPD has errors"
fi
done



