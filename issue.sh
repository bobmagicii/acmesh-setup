#!/bin/bash

BaseDir=`pwd`
TempDir="/tmp/ashbox"
InstDir="$BaseDir/.ash"
ConfDir="$BaseDir/.cfg"
CertDir="$BaseDir/certs"

################################################################################
################################################################################

CommandConfig="--home $InstDir --cert-home $CertDir --config-home $ConfDir"
DomainList=""

################################################################################
################################################################################

for arg do
	DomainList+="-d $arg "
done

bash $InstDir/acme.sh $CommandConfig --issue --dns dns_porkbun $DomainList
