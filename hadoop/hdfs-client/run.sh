#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NUMWRITER=2
BLOCKPERFILE=1280

TASKDIV=`expr $1 / $NUMWRITER`
TASKDIV1=`expr $1 / $NUMWRITER + 1`
TASKMOD=`expr $1 % $NUMWRITER`


#hadoop jar $DIR/RandomWriter.jar RandomWriter $1 $BLOCKPERFILE $HOSTNAME-2 > /dev/null 2> /dev/null &

#exit

for i in `seq 1 $NUMWRITER`;
do
  if [ "$i" -le "$TASKMOD" ]
  then
    hadoop jar $DIR/RandomWriter.jar RandomWriter $TASKDIV1 $BLOCKPERFILE $HOSTNAME-$i > /dev/null 2> /dev/null &
  else
    hadoop jar $DIR/RandomWriter.jar RandomWriter $TASKDIV $BLOCKPERFILE $HOSTNAME-$i > /dev/null 2> /dev/null &
  fi
done
