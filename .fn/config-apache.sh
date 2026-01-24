
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
	echo "SSLCertificateFile    ${CertDir}/${Domain}_ecc/$Domain.cer"
	echo "SSLCertificateKeyFile ${CertDir}/${Domain}_ecc/$Domain.key"
	echo "SSLCACertificateFile  ${CertDir}/${Domain}_ecc/fullchain.cer"
	echo

	exit 0
}
