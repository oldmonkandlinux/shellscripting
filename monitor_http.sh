#!/bin/bash

LYNX="/usr/bin/lynx"
STATUS="http.status.out.$$"
>$STATUS
URL="$1"
$LYNX $URL -head -dump > $STATUS

if (( $? != 0 )) 
then
 echo "$URL - Unable to connect"
 cat $STATUS
else
 head -n1 "$STATUS"|while read VER RC STATUS
 do
   case $RC in
   200|301|302) echo "HTTP response is OK"
   ;;
   *) echo "HTTP reponse not OK"
   ;;
   esac
 done
fi
