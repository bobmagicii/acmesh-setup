################################################################################
## ashbox.sh conf:apache ########################################################

AshboxCommandRegister "conf:apache" "CommandConfigForApacheConf"

################################################################################
################################################################################

CommandConfigForApacheConf() {(

	Domain=$1

	if [ -z $Domain ]; then
		Domain='$SSLDomain'
	fi

	########

	echo
	echo "VHOST SSL CONFIG"
	echo "================"
	echo
	echo "SSLCertificateFile    ${Config['CertDir']}/${Domain}_ecc/$Domain.cer"
	echo "SSLCertificateKeyFile ${Config['CertDir']}/${Domain}_ecc/$Domain.key"
	echo "SSLCACertificateFile  ${Config['CertDir']}/${Domain}_ecc/fullchain.cer"
	echo

	exit $KTHXBAI
)}
