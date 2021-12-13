#!/bin/bash

# program to replace data on a chosen line of a file with a given alternative
# takes 5 parameters: $database $file $line $existing_data $replacement

#check file exists in database
if [ -f ~/"$1"/"$2" ]; then

	file="$1"/"$2"
	# check that $existing_data exists within $line of $file
	line="$(head -n "$3" "$file" | tail -1)"

	if [[ "$line" == *"$3"* ]]; then

		echo "OK: data replaced"
		# sed substitutes $existing_data for $replacement in $file
		# the g allows all instances of $existing_data to be replaced
		sed -i "$2 s/"$3"/"$4"/g" "$1"
		exit 0

	else

		echo "Error: pattern does not exist in specified line"
		exit 56

	fi

else
	echo "Error: file does not exist in database"
	exit 58
fi
