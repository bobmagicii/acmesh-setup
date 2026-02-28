#!/usr/bin/env bash
################################################################################
## a s h b o x #################################################################

declare    AppBin=$(realpath "${BASH_SOURCE}")
declare    AppRoot=$(dirname "${AppBin}")
declare -r AppVersion="1.0.0"

################################################################################
################################################################################

declare -A Config=(
	["AppRoot"]="${AppRoot}"
	["TempDir"]="/tmp/ashbox"
	["InstDir"]="${AppRoot}/.ash"
	["ConfDir"]="${AppRoot}/.cfg"
	["HelpDir"]="${AppRoot}/.docs"
	["FuncDir"]="${AppRoot}/.fn"
	["CertDir"]="${AppRoot}/certs"
	["AshboxBinFile"]="ashbox.sh"
	["AshboxRepoURL"]="https://github.com/bobmagicii/ashbox"
	["AcmeShBinFile"]="acme.sh"
	["AcmeShRepoURL"]="https://github.com/acmesh-official/acme.sh"
);

################################################################################
################################################################################

function Ashbox() {(

	declare Cmd=$1
	declare Args=${@:2}
	declare -A Commands=()

	declare DoExit=1

	declare AcmeShCmd=""
	declare AcmeShCfgFlags=""

	################################
	################################

	declare -r OK=0
	declare -r ERR=1
	declare -r ERR_HELP=2
	declare -r ERR_PATH_WITH_SPACES=3

	declare -r KTHXBAI=$OK
	declare -r OHSNAP=$ERR

	################################
	################################

	function Constructor() {

		_ProcessCommandArgs $*

		AcmeShCmd="${Config['InstDir']}/${Config['AcmeShBinFile']}"
		AcmeShCfgFlags+="--home ${Config['InstDir']} "
		AcmeShCfgFlags+="--cert-home ${Config['CertDir']} "
		AcmeShCfgFlags+="--config-home ${Config['ConfDir']} "

		return $KTHXBAI
	};

	function _ProcessCommandArgs() {

		local Arg=""

		########

		#for Arg;
		#do

		#done

		########

		return $KTHXBAI
	}

	function _HaltIfPathHasWhitespace() {

		local Dir=$1

		########

		if [[ $Dir =~ " " ]];
		then
			echo "acme.sh does not support spaces in paths."
			echo "${Dir}"
			echo "There are several issues in it's GitHub issue tracker about it."
			echo "Most of them are closed with \"don't use spaces\"."
			echo "Ashbox is trying to but without acme.sh not like that can be confirmed."
			exit $ERR_PATH_WITH_SPACES
		fi

		########

		return $KTHXBAI
	};

	function _LoadPluginsFrom() {

		local Dir=$1
		local File=""

		########

		for File in ${Dir}/*.sh;
		do
			source "${File}"
		done

		########

		return $KTHXBAI
	};

	function _ExecuteCommand() {

		# reference $Commands

		local Cmd=$1
		local Args=$2

		########

		if [[ -v Commands[$Cmd] ]];
		then
			${Commands[$Cmd]} $Args
			exit $?
		fi

		########

		return $KTHXBAI
	};

	################################
	################################

	function AshboxCommandRegister() {

		# reference $Commands
		# plugin api function

		local Cmd=$1
		local Fnc=$2

		Commands[$Cmd]=$Fnc

		return $KTHXBAI
	};

	################################
	################################

	Constructor $*
	_HaltIfPathHasWhitespace "${Config['InstDir']}"
	_LoadPluginsFrom "${Config['FuncDir']}"
	_ExecuteCommand "${Cmd}" "${Args}"
	_ExecuteCommand "help"

	################################
	################################

	exit $KTHXBAI
)};

################################################################################
################################################################################

## this should enable both calling it as a command (as intended) as well as
## using it as a source in another script.

Ashbox $*

if [[ $BASH_SOURCE == $0 ]];
then
	exit $?
else
	return $?
fi
