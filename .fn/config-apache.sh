
CommandConfigForApacheConf() {

	Domain=$1

	if [ -z $Domain ]; then
		Domain='$SSLDomain'
	fi

	########

	echo
	echo "VHOST SSL CONFIG"
	echo "================"
	echo
	echo "SSLCertificateFile    ${CertDir}/${Domain}_eec/$Domain.cer"
	echo "SSLCertificateKeyFile ${CertDir}/${Domain}_eec/$Domain.key"
	echo "SSLCACertificateFile  ${CertDir}/${Domain}_eec/fullchain.cer"
	echo

	exit 0
}
