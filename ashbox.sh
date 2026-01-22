#!/usr/bin/env bash

################################################################################
################################################################################

BaseDir=`dirname "$(realpath $0)"`
TempDir="/tmp/ashbox"
InstDir="$BaseDir/.ash"
ConfDir="$BaseDir/.cfg"
HelpDir="$BaseDir/.docs"
FuncDir="$BaseDir/.fn"
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

source $FuncDir/util.sh
source $FuncDir/config-acmesh.sh
source $FuncDir/config-apache.sh
source $FuncDir/command-defaults.sh
source $FuncDir/command-help.sh
source $FuncDir/command-install.sh
source $FuncDir/command-issue.sh
source $FuncDir/command-list.sh
source $FuncDir/command-remove.sh

################################################################################
################################################################################

if [ "$ASHCMD" == 'issue' ];
then CommandIssue $ASHARG

elif [ "$ASHCMD" == 'remove' ];
then CommandRemove $ASHARG

elif [ "$ASHCMD" == 'list' ];
then CommandList $ASHARG

elif [ "$ASHCMD" == 'install' ];
then CommandInstall $ASHARG

elif [ "$ASHCMD" == 'default:letsencrypt' ];
then CommandDefaultLetsEncrypt

elif [ "$ASHCMD" == 'default:zerossl' ];
then CommandDefaultLetsEncrypt

elif [ "$ASHCMD" == 'conf:acmesh' ];
then CommandConfigForAcmeShCLI $ASHARG

elif [ "$ASHCMD" == 'conf:apache' ];
then CommandConfigForApacheConf $ASHARG

fi

################################################################################
################################################################################

CommandHelp
