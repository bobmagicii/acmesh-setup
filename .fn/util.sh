
################################################################################
## terminal functions ##########################################################

function QueryTerminalWidth() {

	tput cols

	return $OK
}

function GetTerminalWidth() {

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

function ArrayJoin() {

	local IFS=$1

	shift
	echo "$*"

	return $OK
}

function StringRepeat() {

	local Char=$1
	local Num=$2

	for ((i=1; i<=$Num; i++));
	do echo -n $Char; done

	echo
	return $OK
}

################################################################################
## pretty printing functions ###################################################

function PrintH1() {

	local Msg=$1
	local Char="/"

	echo $(StringRepeat "${Char}" $(GetTerminalWidth))
	echo "${Char}${Char} ${Msg}" $(StringRepeat "${Char}" $(GetTerminalWidth)-${#Msg}-4)

	return $OK
}

function PrintH1Ln() {

	PrintH1 "$1"
	echo

	return $OK
}

function PrintH2() {

	local Msg=$1
	local Char="/"

	echo "${Char}${Char} ${Msg}" $(StringRepeat "${Char}" $(GetTerminalWidth)-${#Msg}-4)

	return $OK
}

function PrintH2Ln() {

	PrintH2 "$1"
	echo

	return $OK
}

################################################################################
################################################################################

function ShowHelpFile() {

	echo
	cat "${Config['HelpDir']}/$1"
	echo

	return $OK
}

