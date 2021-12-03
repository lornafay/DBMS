#!/bin/bash

# takes three parameters - $database $table and $columns
# $columms must be separated by commas with no whitespace

if [ ! "$#" -eq 3 ]; then # if parameters are incorrect
	echo "Error: must pass 3 parameters"
	exit 22

elif [ ! -d "$1" ]; then # if database does not exist
	echo "Error: database does not exist"
	exit 24

elif [ -e "$1"/"$2" ]; then # if file already exists in specified database
	echo "Error: table already exists in that database"
	exit 26

else # if everything is correct
	echo "creating file.."
	echo "adding columns.."
	echo "$3" > "$1"/"$2"
	exit 0
fi
