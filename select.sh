#!/bin/bash

# program to select and display data from existing table and DB
# takes arguments $database $table which must
# optional third argument #columns supplied as tuple of column numbers
# otherwise all data displayed

# parameter checking

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ] ; then
        echo "Error: parameters problem"
        exit 40

elif [ ! -d "$1" ]; then
	 echo "Error: Database does not exist"
        exit 42

elif [ ! -f "$1"/"$2" ]; then
        echo "Error: Table does not exist"
        exit 44

else
	file="$1"/"$2"

	if [ "$#" -eq 2 ]; then
		echo "start_result"
		cat "$file"
		echo "end_result"

	elif [ "$#" -eq 3 ]; then
		if [ ! "$(cut -d, -f"$3" "$file")" ]; then
			echo "Error: column does not exist"
			exit 46
		else
			echo "start_result"
			cut -d, -f"$3" "$file"
			echo "end_result"
		fi
	fi
fi
