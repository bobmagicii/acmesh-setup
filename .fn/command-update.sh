################################################################################
## ashbox.sh update ############################################################

AshboxCommandRegister "update" "CommandUpdate"

################################################################################
################################################################################

function CommandUpdate() {(

	function UpdateSelf() {

		local Command=""
		local GitDir="${Config['AppRoot']}/.git"

		########

		if [[ ! -d $GitDir ]];
		then
			PrintH2Ln "Updating ashbox"
			echo "skipping self update: not installed via git"
			echo
			return $KTHXBAI
		fi

		printf -v Command "git -C %s pull" "${Config['AppRoot']}"

		########

		PrintH2Ln "Updating ashbox"
		$Command
		echo

		########

		return $KTHXBAI
	};

	function UpdateASH() {

		local Command=""

		########

		printf -v Command "bash %s ${AcmeShCfgFlags} --upgrade" "${AcmeShCmd}"

		########

		PrintH2Ln "Updating acme.sh"
		$Command
		echo

		########

		return $OK
	};

	################################################################
	################################################################

	UpdateSelf
	UpdateASH

	################################################################
	################################################################

	exit $KTHXBAI
)};
