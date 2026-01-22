#!/bin/bash

################################################################################
################################################################################

BaseDir=`dirname "$(realpath $0)"`
TempDir="/tmp/ashbox"
InstDir="$BaseDir/.ash"
ConfDir="$BaseDir/.cfg"
CertDir="$BaseDir/certs"

RepoURL="https://github.com/acmesh-official/acme.sh"

################################################################################
################################################################################

ASHBIN="$InstDir/acme.sh"
ASHCFG="--home $InstDir --cert-home $CertDir --config-home $ConfDir"
ASHCMD=$1
ASHARG=${@: 2}

################################################################################
################################################################################

ShowInstallInfo() {
	echo "USAGE: $0 <ssl-contact-email>"
	echo ""
}

CommandApacheConf() {

	Domain=$1

	if [ -z $Domain ]; then
		Domain='$SSLDomain'
	fi

	echo
	echo "VHOST SSL CONFIG"
	echo "================"
	echo "SSLCertificateFile    ${CertDir}/${Domain}_eec/$Domain.cer"
	echo "SSLCertificateKeyFile ${CertDir}/${Domain}_eec/$Domain.key"
	echo "SSLCACertificateFile  ${CertDir}/${Domain}_eec/fullchain.cer"
	echo

	exit 0
}

CommandInstall() {

	ContactEmail=$1

	########

	if [ -z "$ContactEmail" ];
	then
		ShowInstallInfo
		exit 1
	fi

	########

	# grab the code.

	rm -rf $TempDir
	git clone $RepoURL $TempDir

	# run its installer with the config.

	cd $TempDir
	bash ./acme.sh $ASHCFG --install -m $ContactEmail
	bash $ASHBIN $ASHCFG --set-default-ca --server letsencrypt

	# cleanup the install.

	cd $BaseDir
	rm -rf $TempDir

	########

	exit 0
}

CommandIssue() {

	Domains=""

	########

	for Domain do
		Domains+="-d $Domain "
	done

	########

	bash $ASHBIN $ASHCFG --issue --dns dns_porkbun $Domains
	exit 0
}

CommandList() {

	bash $ASHBIN $ASHCFG --list
	exit 0
}

CommandHelp() {

	echo
	echo "* ashbox.sh issue <domain1> <...domain2> <...>"
	echo "  Issue SSL certs for new domains."
	echo
	echo "* ashbox.sh remove <domain1> <...domain2> <...>"
	echo "  Remove an SSL cert from the system."
	echo
	echo "* ashbox.sh list"
	echo "  List all the domains tracked by acme.sh."
	echo
	echo "* ashbox.sh apacheconf <domain>"
	echo "  Print the SSL config options for Apache configuration."
	echo
	echo "* ashbox.sh install"
	echo "  Install acme.sh and configure within ashbox."
	echo

	exit 0
}

CommandRemove() {

	Domains=""

	########

	for Domain do
		Domains+="-d $Domain "
	done

	########

	bash $ASHBIN $ASHCFG --revoke $Domains
	exit 0
}

################################################################################
################################################################################

if [ "$ASHCMD" == 'issue' ];
then
	CommandIssue $ASHARG

elif [ "$ASHCMD" == 'remove' ];
then
	CommandRemove $ASHARG

elif [ "$ASHCMD" == 'list' ];
then
	CommandList $ASHARG

elif [ "$ASHCMD" == 'install' ];
then
	CommandInstall $ASHARG

elif [ "$ASHCMD" == 'apacheconf' ];
then
	CommandApacheConf $ASHARG

else
	CommandHelp

fi

################################################################################
################################################################################
