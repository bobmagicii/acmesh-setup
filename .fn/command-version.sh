################################################################################
## ashbox.sh --version #########################################################

AshboxCommandRegister "--version" "CommandVersion"

################################################################################
################################################################################

function CommandVersion() {(

	echo "ashbox v${AppVersion} [ acme.sh" $("$AcmeShCmd" $AcmeShCfgFlags --version | grep v) "]"

	exit $KTHXBAI
)};
