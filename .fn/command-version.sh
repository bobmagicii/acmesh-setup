################################################################################
## ashbox.sh --version #########################################################

AshboxRegisterCommandFunction "--version" "CommandVersion"

################################################################################
################################################################################

function CommandVersion() {(

	echo "ashbox v${Version} [ acme.sh" $("$ASHBIN" $ASHCFG --version | grep v) "]"

	exit $KTHXBAI
)};
