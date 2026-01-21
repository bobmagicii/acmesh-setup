#!/bin/bash

# Install acme.sh in a standardised way on the system to allow multiple
# services to access the SSL certs.

################################################################################
################################################################################

export InstDir="/opt/acmesh"
export TempDir="/tmp/acmesh"
export ConfDir="$InstDir/local/confs"
export CertDir="$InstDir/local/certs"

export RepoURL="https://github.com/acmesh-official/acme.sh"

################################################################################
################################################################################

# after acme.sh does its job then my apache configurations tend to look like
# this here.

# SSLCertificateFile    "/opt/acmesh/local/certs/$SSLDomain_ecc/$SSLDomain.cer"
# SSLCertificateKeyFile "/opt/acmesh/local/certs/$SSLDomain_ecc/$SSLDomain.key"
# SSLCACertificateFile  "/opt/acmesh/local/certs/$SSLDomain_ecc/ca.cer"

################################################################################
################################################################################

OriginDir=`pwd`
ContactEmail=$1

ShowUsageInfo() {
	echo "USAGE: $0 <ssl-contact-email>"
	echo ""
}

################################################################################
################################################################################

if [ -z "$ContactEmail" ];
then
	ShowUsageInfo
	exit 1
fi

if [ -d $InstDir ];
then
	echo "there appears an install already at $InstDir"
	exit 2
fi

################################################################################
################################################################################

OptInstall="--home $InstDir --cert-home $CertDir --config-home $ConfDir"

# grab the code.

rm -rf $TempDir
git clone $RepoURL $TempDir

# run its installer with the config.

cd $TempDir
bash ./acme.sh --install $OptInstall -m $ContactEmail
bash ./acme.sh --set-default-ca --server letsencrypt

# cleanup the install.

cd $OriginDir
rm -rf $TempDir

exit 0
