# A script to allow marktext to be opened from the CLI, so long as the file is of type .md.
# An alias for marktext can be added to .bashrc linking to this script after downloading the marktext app image.

# to handle marktext file opening or creation
marktext() {
	if [ -z "$1" ]; then
		~/Apps/marktext.AppImage
		return 0;
	fi

	if [[ ! "${1##*.}" == "md"  && ! -d "$1" ]]; then
		echo "Aborted: '$1' is not a markdown file (*.md) or a folder." >&2
		return 1
	fi

	if [ -d "$1" ]; then
		~/Apps/marktext.AppImage "$1"
	else
		# ensure directory exists
		mkdir -p "$(dirname "$1")"
		# create file if not
		touch "$1"
		# open file
		~/Apps/marktext.AppImage "$1"
	fi
}
