#!/bin/bash

while ! ln "$0" "$1-lock" 2> /dev/null; do
	sleep 1
done
exit 0
