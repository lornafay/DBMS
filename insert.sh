#!/bin/bash
# script to insert data into chosen file
# takes 3 parameters $database $table and $columns
# columns must be a tuple separated by commas with no whitespace
# individual items in tuple must not contain commas or spaces

if [ ! "$#" -eq 3 ]; then # if number of parameters is incorrect
	echo "Error: must pass 3 parameters"
	exit 30

elif [ ! -d "$1" ] && [ ! -e "$1/$2" ]; then # if neither DB nor table exists
	echo "Error: DB and table do not exist"
	exit 32

elif [ ! -d "$1" ]; then # if DB does not exist
	echo "Error: DB does not exist"
	exit 34

elif [ ! -e "$1/$2" ]; then # if table does not exist
	echo "Error: table does not exist"
	exit 36
else

	# target file checking complete
	# now must check that number of fields to be inserted matches the number of columns in existing table

	# find number of columns in table
	file="$1"/"$2"
	columns=$( head -n 1 "$file" ) # assign first line of file to variable columns
	arrcolumns=("${columns//,/ }") # create array from columns, replacing all instances of comma , with a space
	numcols="${#arrcolumns[@]}" # number of elements of columns array assigned to variable numcols

	# we then perform the same operation on the data to be inserted

	data="$3"
	arrfields=("${data//,/ }")
	numfields="${#arrfields[@]}"

	if [ "$numcols" -eq "$numfields" ]; then
		echo "OK: data inserted"
		echo "$3">>"$file" # append target file with data in third parameter
		exit 0
	else
		echo "Error: number of columns in tuple does not match schema"
		exit 38
	fi

fi
