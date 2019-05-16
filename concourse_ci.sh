#!/bin/bash

ARG1="$1"
FLY="/usr/local/bin/fly"
FLYRC="$HOME/.flyrc"

# check if we need to log in again - the .flyrc token lasts a day, 86400 seconds
# so we'll renew just before that.
NOW_DATE=$( date +%s )
FLYRC_DATE=$( stat --printf=%Y "$FLYRC" )
FLY_AGE=$(( $NOW_DATE - $FLYRC_DATE ))
if [ $FLY_AGE -gt 86000 ] ; then
	fly -t aa login -c https://concourse.aws.agileanalog.com -k -u admin -p abc123
fi


if [ ! -x "$FLY" ] ; then
	echo "Error, fly command not found"
	exit 1
fi

if [ -n "$ARG1" ] ; then

	if [ "$ARG1" == "containers.idle" ] ; then
		sudo -u centos /usr/local/bin/fly -t aa containers | awk '{print $3}' | grep none | wc -l

	elif [ "$ARG1" == "containers.total" ] ; then
		sudo -u centos /usr/local/bin/fly -t aa containers | wc -l

	elif [ "$ARG1" == "pipelines.paused" ] ; then
		sudo -u centos fly -t aa pipelines | awk '{print $2}' | grep yes | wc -l

	elif [ "$ARG1" == "pipelines.total" ] ; then
		sudo -u centos fly -t aa pipelines | wc -l

	elif [ "$ARG1" == "volumes.total" ] ; then
		sudo -u centos fly -t aa volumes | wc -l

	elif [ "$ARG1" == "workers.running" ] ; then
		sudo -u centos fly -t aa workers | grep " running " | wc -l

	elif [ "$ARG1" == "workers.landed" ] ; then
		sudo -u centos fly -t aa workers | grep " landed " | wc -l

	elif [ "$ARG1" == "workers.total" ] ; then
		sudo -u centos fly -t aa workers | wc -l

	else
		echo "Error, parameter not recognised"
		exit 1
	fi
else
	echo "Error, no parameter provided"
	exit 1
fi



