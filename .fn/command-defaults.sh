
CommandDefaultLetsEncrypt() {

	bash $ASHBIN $ASHCFG --set-default-ca --server letsencrypt

	exit 0
}

CommandDefaultZeroSSL() {

	bash $ASHBIN $ASHCFG --set-default-ca --server zerossl

	exit 0
}
