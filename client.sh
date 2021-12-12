#!/bin/bash

# script that takes a user as argument
# prompts user for request in format req args

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
        # function to delete user.pipe when script is shut down
        rm "$id".pipe
	echo "shutting down client.."
	exit 0
}

if [ ! "$#" -eq 1 ]; then
	echo "Error: only takes one parameter"
	exit 52

else
	id="$1"
	mkfifo "$id".pipe
	while true; do

		echo "enter your request: "
		read -a request

		if [ "${#request[@]}" -eq 1 ]; then

			cmd="${request[0]}"

			# exit current program
			if [ "$cmd" = "exit" ]; then
				ctrl_c

			# shutdown server
			elif [ "$cmd" = "shutdown" ]; then
				echo "shutting down server.."
				echo "$cmd" > server.pipe
			fi

		elif [ "${#request[@]}" -gt 1 ]; then

			req="${request[0]}"
			argsArray=("${request[@]:1}")
			args="${argsArray[*]}"
			echo "$id $req $args" > server.pipe

		else
			echo "Error: bad request"

		fi

		# loop to receive response from the server
		while read response; do

			if [[ "$response" = *"OK"* || "$response" = *"Error"* ]]; then
				echo "command executed successfully"

			elif [[ "$response" != *"start_result"* && "$response" != "end_result" ]]; then
				echo "$response"

			fi

		done < "$id".pipe

	done
fi
