
ShowHelpFile() {
	echo
	cat $HelpDir/$1
	echo
}

ArrayJoin() {
	local IFS=$1

	shift
	echo "$*"
}
