#!/bin/bash

# server script

#trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
	#function to delete server.pipe when script is shut down
        rm server.pipe
	exit 0
}

mkfifo server.pipe

while true; do
	# take reading from server pipe incase client uses shutdown command
	read input < server.pipe
	# store input in an array
	read -a array

	# first element of array is command we want, subsequent elements are parameters
	case "${array[0]}" in

		create_database)
			eval ./create_database.sh "${array[1]}" &
			exit 0
			;;

		create_table)
			eval ./create_table.sh "${array[1]}" "${array[2]}" "${array[3]}" &
			exit 0
			;;

		insert)
			eval ./insert.sh "${array[1]}" "${array[2]}" "${array[3]}" &
			exit 0
			;;

		select)
			eval ./select.sh "${array[1]}" "${array[2]}" "${array[3]}" &
			exit 0
			;;

		shutdown)
			# kill the process if shutdown is input by user
			kill $! &
			exit 0
			;;

		*)
			echo "Error: bad request"
			exit 1

	esac
done
