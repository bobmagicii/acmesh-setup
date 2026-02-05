################################################################################
## ashbox.sh conf:ssl ########################################################

AshboxCommandRegister "conf:ssl" "CommandConfigForBasicSSL"

################################################################################
################################################################################

function CommandConfigForBasicSSL() {(

	Domain=$1

	if [ -z $Domain ]; then
		echo "Missing Domain Name"
		exit 1
	fi

	########

	echo
	echo "Certificates: ${Domain}"
	echo "=================================="

	echo "Key File:     ${Config['CertDir']}/${Domain}_ecc/${Domain}.key"
	echo "Domain Cert:  ${Config['CertDir']}/${Domain}_ecc/${Domain}.cer"
	echo "CA Cert:      ${Config['CertDir']}/${Domain}_ecc/ca.cer"
	echo "Fullchain:    ${Config['CertDir']}/${Domain}_ecc/fullchain.cer"
	echo

	exit $KTHXBAI
)}
