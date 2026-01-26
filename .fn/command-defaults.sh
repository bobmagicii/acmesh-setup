################################################################################
## ashbox.sh default: ##########################################################

AshboxRegisterCommandFunction "default:letsencrypt" "CommandDefaultLetsEncrypt"
AshboxRegisterCommandFunction "default:zerossl" "CommandDefaultZeroSSL"

################################################################################
################################################################################

function CommandDefaultLetsEncrypt() {(

	bash "${ASHBIN}" $ASHCFG --set-default-ca --server "letsencrypt"

	exit $KTHXBAI
)};

function CommandDefaultZeroSSL() {(

	bash "${ASHBIN}" $ASHCFG --set-default-ca --server "zerossl"

	exit $KTHXBAI
)};
