#!/bin/bash

# script that takes a user as argument
# prompts user for request in format req args

#trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
        #function to delete user.pipe when script is shut down
        rm "$1".pipe
	exit 0
}

mkfifo "$1".pipe

if [ ! "$#" -eq 1 ]; then
	echo "Error: only takes one parameter"
	exit 52

else
	id="$1"
	while true; do
		echo "enter your request: "
		read -a request
		if [ ! "${#request[@]}" -eq 2 ]; then
			if [ "${#request[@]}" -eq 1 ]; then
				cmd="${request[1]}"
				if [ "$cmd" -eq "exit"]; then
					ctrl_c()
				elif [ "$cmd" -eq "shutdown" ]; then
					echo "$cmd" > server.pipe
					ctrl_c()
				fi

			else
				echo "Error: bad request"
				exit 54
			fi
		else
			req="${request[0]}"
			args="${request[1]}"
			echo "$req $id $args"
		fi
	done


fi
