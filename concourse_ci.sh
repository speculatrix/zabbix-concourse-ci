#!/bin/bash

# put this script into /opt/zabbix/bin and make it executable so that
# the zabbix agent and the zabbix_ci.conf file reference it correctly.

ARG1="$1"
FLY="/usr/local/bin/fly"

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



