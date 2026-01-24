#!/usr/bin/env bash

################################################################################
################################################################################

BaseBin=$(realpath "$0")
BaseDir=$(dirname "${BaseBin}")
InstDir="${BaseDir}/.ash"
ConfDir="${BaseDir}/.cfg"
HelpDir="${BaseDir}/.docs"
FuncDir="${BaseDir}/.fn"
CertDir="${BaseDir}/certs"
TempDir="/tmp/ashbox"

RepoURL="https://github.com/acmesh-official/acme.sh"

################################################################################
################################################################################

ASHBIN="${InstDir}/acme.sh"
ASHCFG="--home ${InstDir} --cert-home ${CertDir} --config-home ${ConfDir}"
ASHCMD=$1
ASHARG=${@: 2}
ASHGIT="git -C ${BaseDir}"

################################################################################
################################################################################

if [[ $InstDir =~ " " ]];
then
	echo "acme.sh does not support spaces in paths."
	echo "There are several issues in it's GitHub issue tracker about it."
	echo "Most of them are closed with \"don't use spaces\" lol."
	exit 1
fi

################################################################################
################################################################################

source "$FuncDir/util.sh"
source "$FuncDir/config-acmesh.sh"
source "$FuncDir/config-apache.sh"
source "$FuncDir/command-defaults.sh"
source "$FuncDir/command-help.sh"
source "$FuncDir/command-install.sh"
source "$FuncDir/command-issue.sh"
source "$FuncDir/command-list.sh"
source "$FuncDir/command-remove.sh"
source "$FuncDir/command-update.sh"

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

elif [ "$ASHCMD" == 'update' ];
then CommandUpdate

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
