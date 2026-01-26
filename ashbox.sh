#!/usr/bin/env bash
################################################################################
## a s h b o x #################################################################

declare    AshboxBin=$(realpath "$0")
declare    AshboxRoot=$(dirname "${AshboxBin}")
declare -r AshboxVersion="1.0.0-dev"

################################################################################
################################################################################

declare -A AshboxConfig=(
	["Root"]="${AshboxRoot}"
	["TempDir"]="/tmp/ashbox"
	["InstDir"]="${AshboxRoot}/.ash"
	["ConfDir"]="${AshboxRoot}/.cfg"
	["HelpDir"]="${AshboxRoot}/.docs"
	["FuncDir"]="${AshboxRoot}/.fn"
	["CertDir"]="${AshboxRoot}/.certs"
	["AshboxRepoURL"]="https://github.com/bobmagicii/ashbox"
	["AcmeShRepoURL"]="https://github.com/acmesh-official/acme.sh"
);

################################################################################
################################################################################

function Ashbox() {(

	declare    AshboxCmd=$1
	declare    AshboxArgs=${@:2}
	declare    AshboxGitCmd=""
	declare -A AshboxCmdFuncs=()
	declare    AcmeShCmd=""
	declare    AcmeShCfgFlags=""

	################################
	################################

	declare -r OK=0
	declare -r ERR=1
	declare -r ERR_HELP=2
	declare -r ERR_PATH_WITH_SPACES=3

	declare -r KTHXBAI=$OK
	declare -r OHSNAP=$ERR
	declare -r NAHIDK=$ERR_UNKNOWN

	################################
	################################

	function Constructor() {
		_BackfillAshboxConfig
		_BackfillAcmeShConfig
		return $KTHXBAI
	};

	function _BackfillAshboxConfig() {

		AshboxGitCmd="git -C ${AshboxConfig['Root']}"

		return $KTHXBAI
	};

	function _BackfillAcmeShConfig() {

		# acme.sh command path.

		AcmeShCmd="${AshboxConfig['InstDir']}/acme.sh"

		# arguments to make acme.sh put things where we want them
		# to be put and stuff.

		AcmeShCfgFlags+="--home ${AshboxConfig['InstDir']} "
		AcmeShCfgFlags+="--cert-home ${AshboxConfig['CertDir']} "
		AcmeShCfgFlags+="--config-home ${AshboxConfig['ConfDir']} "

		########

		return $KTHXBAI
	};

	################################
	################################

	function AshboxCommandRegister() {

		# reference $AshboxCmdFuncs

		local Cmd=$1
		local Fnc=$2

		########

		AshboxCmdFuncs[$Cmd]=$Fnc

		return $KTHXBAI
	};

	function AshboxCommandExecute() {

		# reference $AshboxCmdFuncs
		# reference $AshboxArgs

		local Cmd=$1

		########

		if [[ -v AshboxCmdFuncs[$Cmd] ]];
		then
			${AshboxCmdFuncs[$Cmd]} $AshboxArgs
			exit $?
		fi

		########

		return $KTHXBAI
	};

	function AshboxPluginLoader() {

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

	function AshboxHaltIfPathHasWhitespace() {

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

	################################
	################################

	Constructor

	AshboxHaltIfPathHasWhitespace "${InstDir}"
	AshboxPluginLoader "${AshboxConfig['FuncDir']}"

	AshboxCommandExecute "${AshboxCmd}"
	AshboxCommandExecute "help"

	################################
	################################

	exit $KTHXBAI
)};

################################################################################
################################################################################

Ashbox $*
exit $?
