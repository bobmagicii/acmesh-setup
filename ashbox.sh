#!/bin/bash

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

if [ $ASHCMD == 'issue' ];
then
	CommandIssue $ASHARG

elif [ $ASHCMD == 'remove' ];
then
	CommandRemove $ASHARG

elif [ $ASHCMD == 'list' ];
then
	CommandList $ASHARG

elif [ $ASHCMD == 'install' ];
then
	CommandInstall $ASHARG

fi

################################################################################
################################################################################
