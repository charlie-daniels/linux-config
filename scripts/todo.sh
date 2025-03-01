#!/bin/bash

LOGFILE="$HOME/.todo"

helpFunction() {
	echo "Usage: todo [OPTION] [INDEX]"
	echo "Add tasks to a list of todos while in the CLI."
	echo ""
	echo -e "Option\t\t Definition"
	echo -e "-l\t\t Show list of all tasks and corresponding indices"
	echo -e "-i <index>\t Show task at specified index"
	echo -e "-r <index>\t Remove item at specified index"
	echo -e "-a\t\t Add new task"
	echo -e "-h\t\t Show this help menu"
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
	# seperate number and task index
	while IFS='=' read -r index task; do
		echo "$index - $task"
	done < "$LOGFILE"
}

addTask() {
	# create task index and assign
	local count=$(wc -l "$LOGFILE" | cut -d' ' -f1)
	echo "$count=$1" >> $LOGFILE
}

OPTSTRING="lr:a:h"

checkLog

while getopts ${OPTSTRING} opt; do
	case ${opt} in
		l)
			getList;;
		r)
			echo "remove triggered";;
		a)
			addTask "${OPTARG}";;
		h)
			helpFunction;;
		#:)
		#	echo "Warning: -${OPTARG} requires an argument."
		?)
			echo "Warning: invalid option -${OPTARG}."
			helpFunction
			exit 1;;
	esac
done
