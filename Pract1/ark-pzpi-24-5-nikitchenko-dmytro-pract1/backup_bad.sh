#!/bin/sh
DIR=$1
if [ -z $DIR ]
then
echo "нема теки"
exit
fi
mkdir -p ~/backups
NAME=`basename $DIR`_`date +%Y-%m-%d_%H%M%S`.tar.gz
tar czf ~/backups/$NAME $DIR
echo "готово: ~/backups/$NAME"
