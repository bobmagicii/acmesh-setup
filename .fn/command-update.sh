################################################################################
## ashbox.sh update ############################################################

AshboxRegisterCommandFunction "update" "CommandUpdate"

################################################################################
################################################################################

function CommandUpdate() {(

	function UpdateSelf() {

		local Command="${ASHGIT} pull"

		PrintH2 "Updating ashbox"
		echo
		$Command
		echo

		return $OK
	};

	function UpdateASH() {

		local Command="bash ${ASHBIN} ${ASHCFG} --upgrade"

		PrintH2 "Updating acme.sh"
		echo
		$Command
		echo

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
