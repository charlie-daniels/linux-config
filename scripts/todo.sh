#!/bin/bash

LOGFILE="$HOME/.todo"

helpFunction() {
	echo "Usage: todo [OPTION] [ARGUMENT] | todo [ARGUMENT]"
	echo "Add tasks to a list of todos while in the CLI."
	echo ""
	echo -e "Option\t\t Definition"
	echo -e "-l\t\t Show list of all tasks"
	echo -e "-r <index>\t Remove task at index"
	echo -e "-a\t\t Add new task"
	echo -e "-b <index>\t Bump task to top"
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
	# read tasks line by line
	local index=1
	while IFS= read -r line; do
		echo "$index - $line"
		((index++))
	done < "$LOGFILE"
}

removeTask() {
	sed -i "${1}d" "$LOGFILE"
}

addTask() {
	echo "$1" >> $LOGFILE
}

bumpTask() {
	local LINE_CONTENT=$(sed -n "${1}p" "$LOGFILE")
	sed -i "${1}d" "$LOGFILE"
	sed -i "1i${LINE_CONTENT}" "$LOGFILE"
}

OPTSTRING=":lr:a:hb:"

checkLog

OPT_SELECTED=false

while getopts ${OPTSTRING} opt; do
	OPT_SELECTED=true
	case ${opt} in
		l)
			getList;;
		r)
			removeTask "${OPTARG}";;
		a)
			addTask "${OPTARG}";;
		b)
			bumpTask "${OPTARG}";;
		h)
			helpFunction;;
		:)
			echo "Warning: -${OPTARG} requires an argument."
			helpFunction
			exit 1;;
		?)
			echo "Warning: invalid option -${OPTARG}."
			helpFunction
			exit 1;;
	esac
done

if ! $OPT_SELECTED ; then
	if [[ -n $1 ]] ; then
		addTask "$1"
	else
		echo "Warning: no option or argument given."
		helpFunction
		exit 1
	fi
fi
