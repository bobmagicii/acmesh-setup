#!/bin/bash

# Install acme.sh in a standardised way on the system to allow multiple
# services to access the SSL certs.

################################################################################
################################################################################

BaseDir=`pwd`
TempDir="/tmp/ashbox"
InstDir="$BaseDir/.ash"
ConfDir="$BaseDir/.cfg"
CertDir="$BaseDir/certs"

RepoURL="https://github.com/acmesh-official/acme.sh"

################################################################################
################################################################################

# after acme.sh does its job then my apache configurations tend to look like
# this here.

# SSLCertificateFile    "/opt/ashbox/certs/$SSLDomain_ecc/$SSLDomain.cer"
# SSLCertificateKeyFile "/opt/ashbox/certs/$SSLDomain_ecc/$SSLDomain.key"
# SSLCACertificateFile  "/opt/ashbox/certs/$SSLDomain_ecc/ca.cer"

################################################################################
################################################################################

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

#if [ -d $InstDir ];
#then
#	echo "there appears an install already at $InstDir"
#	exit 2
#fi

echo " * BaseDir: $BaseDir"
echo " * InstDir: $InstDir"
echo " * ConfDir: $ConfDir"
echo " * CertDir: $CertDir"

################################################################################
################################################################################

OptInstall="--home $InstDir --cert-home $CertDir --config-home $ConfDir"

# grab the code.

rm -rf $TempDir
git clone $RepoURL $TempDir

# run its installer with the config.

cd $TempDir
bash ./acme.sh $OptInstall --install -m $ContactEmail
bash $InstDir/acme.sh $OptInstall --set-default-ca --server letsencrypt

# cleanup the install.

cd $BaseDir
rm -rf $TempDir

exit 0
