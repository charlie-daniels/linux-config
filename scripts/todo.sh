#!/bin/bash

helpFunction() {
	echo "Usage: todo <option> <item>"
	echo -e "\t-l list all todo items"
	echo -e "\t-r remove specified item"
	echo -e "\t-a add specified item"
	echo -e "\t-h show this help menu"
}

OPTSTRING=":lrah"

while getopts ${OPTSTRING} opt; do
	case ${opt} in
		l)
			echo "list triggered";;
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
