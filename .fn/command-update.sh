################################################################################
## ashbox.sh update ############################################################

function CommandUpdate() {(

	UpdateSelf() {

		local Command="${ASHGIT} pull"

		PrintH2 "Updating ashbox"
		echo
		$Command
		echo

		return $OK
	};

	UpdateASH() {

		local Command="bash ${ASHBIN} ${ASHCFG} --upgrade"

		PrintH2 "Updating acme.sh"
		echo
		$Command
		echo

		return $OK
	};

	UpdateSelf
	UpdateASH

	exit $KTHXBAI
)}

################################################################################
################################################################################

