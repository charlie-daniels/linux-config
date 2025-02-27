#!/bin/bash

LOGFILE="$HOME/.todo"

helpFunction() {
	echo "Usage: todo <option> <item>"
	echo -e "\t-l list all todo items"
	echo -e "\t-r remove specified item"
	echo -e "\t-a add specified item"
	echo -e "\t-h show this help menu"
}

checkLog() {
	if [ ! -f "$LOGFILE" ]; then
		echo "Creating log file..."
		touch ~/.todo
	fi
}

getList() {
	if [ ! -s "$LOGFILE" ]; then
		echo "No entries found."
		return 0;
	fi
	# seperate number and task id
	while IFS='=' read -r id task; do
		echo "$id - $task"
	done < "$LOGFILE"
}

OPTSTRING=":lrah"

checkLog

while getopts ${OPTSTRING} opt; do
	case ${opt} in
		l)
			getList;;
		r)
			echo "remove triggered";;
		a)
			echo "add triggered";;
		h)
			helpFunction;;
		?)
			echo "Warning: invalid option -${OPTARG}"
			helpFunction
			exit 1;;
	esac
done
