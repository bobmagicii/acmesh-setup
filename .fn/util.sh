
################################################################################
## terminal functions ##########################################################

QueryTerminalWidth() {
	tput cols
	return $OK
}

GetTerminalWidth() {

	local Width=$(QueryTerminalWidth)

	if [[ $Width -le 80 ]];
	then
		echo $Width
		return $OK
	fi

	echo 80
	return $OK
}

################################################################################
## string utility ##############################################################

ArrayJoin() {

	local IFS=$1

	shift
	echo "$*"

	return $OK
}

StringRepeat() {

	local Char=$1
	local Num=$2

	for ((i=1; i<=$Num; i++));
	do echo -n $Char; done

	echo
	return $OK
}

################################################################################
## update functions ############################################################

UpdateSelf() {

	local Command="${ASHGIT} pull"

	echo "Updating Ashbox"
	echo "==============="
	echo
	$Command
	echo

	return $OK
}

UpdateASH() {

	local Command="bash ${ASHBIN} ${ASHCFG} --upgrade"

	echo "Updating acme.sh"
	echo "================"
	echo
	$Command
	echo

	return $OK
}

################################################################################
################################################################################

CommandHeader() {
	
	local Char="#"
	local Msg="${Char}${Char} ashbox v${Version} "

	StringRepeat "${Char}" $(GetTerminalWidth)
	echo -n "${Msg}"
	StringRepeat "${Char}" $(GetTerminalWidth)-${#Msg}
	echo
	
	echo
	return $OK
}

ShowHelpFile() {
	echo
	cat $HelpDir/$1
	echo
}

