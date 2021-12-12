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

	# read input from server pipe and store in array
	read -a array < server.pipe

	if [ "${#array[@]}" -gt 1 ]; then

		idArr=("${array[0]}") # this slice contains the user id
		id="${idArr[*]}"
		reqArr=("${array[1]}") # this slice contains the request
		req="${reqArr[*]}"
		argsArr=("${array[@]:2}") # this slice contains the arguments
		args="${argsArr[*]}"
		# first element of array is command we want, subsequent elements are parameters

		case "$req" in

			create_database)
				./P.sh "$args"
				echo "$(./create_database.sh $args)" > "$id".pipe
				./V.sh "$args"
				;;

			create_table)
				 ./P.sh "$args"
				echo "$(./create_table.sh $args)" > "$id".pipe
				./V.sh "$args"
				;;

			insert)
				./P.sh "$args"
				echo "$(./insert.sh $args)" > "$id".pipe
				./V.sh "$args"
				;;

			select)
				./P.sh "$args"
				echo "$(./select.sh $args)" > "$id".pipe
				./V.sh "$args"
				;;

			replace)
				./P.sh "$args"
				echo "$(./replace.sh $args)" > "$id".pipe
				./V.sh "$args"
				;;

			*)
				echo "Error: bad request" > "$id".pipe
				exit 1

		esac

	elif [ "${#array[@]}" -eq 1 ]; then

		case "${array[0]}" in

			shutdown)
				# kill the process and delete pipe if shutdown is input by user
				echo "shutting down server.." > "$id".pipe
				ctrl_c
				;;

			*)
				echo "Error: bad request" > "$id".pipe
				exit 1

		esac
	fi
done
