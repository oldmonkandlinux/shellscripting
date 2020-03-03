#!/bin/bash

SCRIPTNAME=$(basename $0)
if (( $# != 1 ))
then
echo "usage: $SCRIPTNAME <length>"
exit 1
fi

length=$1

openssl rand -base64 48| cut -c1-$length
