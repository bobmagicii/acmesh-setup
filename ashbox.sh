#!/usr/bin/env bash

################################################################################
## a s h b o x #################################################################

readonly Version="1.0.0-dev"

declare BaseBin=$(realpath "$0")
declare BaseDir=$(dirname "${BaseBin}")
declare InstDir="${BaseDir}/.ash"
declare ConfDir="${BaseDir}/.cfg"
declare HelpDir="${BaseDir}/.docs"
declare FuncDir="${BaseDir}/.fn"
declare CertDir="${BaseDir}/certs"
declare TempDir="/tmp/ashbox"

declare RepoURL="https://github.com/acmesh-official/acme.sh"
 
################################################################################
################################################################################

declare ASHBIN="${InstDir}/acme.sh"
declare ASHCFG="--home ${InstDir} --cert-home ${CertDir} --config-home ${ConfDir}"
declare ASHCMD=$1
declare ASHARG=${@: 2}
declare ASHGIT="git -C ${BaseDir}"

readonly OK=0

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
source "$FuncDir/config-gitea.sh"
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

elif [ "$ASHCMD" == 'conf:gitea' ];
then CommandConfigForGitea $ASHARG

fi

################################################################################
################################################################################

CommandHeader
CommandHelp
