#!/bin/bash

if [ "$#" -eq 0 ]; then # if no arguments provided
	echo "Error: Create database requires one argument, but no argument was provided"
	exit 10
elif [ "$#" -gt 1 ]; then # if too many arguments
	echo "Error: Create database takes one argument, too many were provided"
	exit 11
elif [ -d "$1" ]; then # if database exists
	echo "Error: $1 is a database that already exists"
	exit 12
else
	echo "OK: database created"
	mkdir "$1"
	exit 0
fi

