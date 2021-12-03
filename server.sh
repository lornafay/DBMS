#!/bin/bash

# server script

while true; do
	# store input in an array
	read -a array

	# first element of array is command we want, subsequent elements are parameters
	case "${array[0]}" in
		create_database)
			eval ./create_database.sh "${array[1]}"
			exit 0
			;;
		create_table)
			eval ./create_table.sh "${array[1]}" "${array[2]}" "${array[3]}"
			exit 0
			;;
		insert)
			eval ./insert.sh "${array[1]}" "${array[2]}" "${array[3]}"
			exit 0
			;;
		select)
			eval ./select.sh "${array[1]}" "${array[2]}" "${array[3]}"
			exit 0
			;;
		shutdown)
			# kill the process if shutdown is input by user
			PID=$!
			kill $PID
			exit 0
			;;
		*)
			echo "Error: bad request"
			exit 1

	esac
done
