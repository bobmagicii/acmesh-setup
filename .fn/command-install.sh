################################################################################
## ashbox.sh install############################################################

CommandInstall() {

	ContactEmail=$1
	DefaultCertAuth="letsencrypt"

	########

	if [[ -z $ContactEmail ]];
	then
		ShowHelpFile ashbox-install.txt
		exit $ERR
	fi

	########

	# grab the code.

	PrintH2Ln "Installing acme.sh..."
	FetchAcmeShInstall "${AcmeShRepoURL}" "${TempDir}"
	SetupAcmeShInstall "${TempDir}" "${ContactEmail}" "${DefaultCertAuth}"
	CleanupAcmeShInstall "${TempDir}"

	########

	exit $OK
}

################################################################################
################################################################################

FetchAcmeShInstall() {

	local RepoURL=$1
	local RepoDir=$2

	echo ">> Downloading ${RepoURL}..."
	rm -rf "${RepoDir}"
	git clone "${RepoURL}" "${RepoDir}" &>/dev/null

	echo "++" $(du -sh "${RepoDir}")
	echo

	return $OK
}

SetupAcmeShInstall() {

	local RepoDir=$1
	local Email=$2
	local DefaultCert=$3

	echo ">> Setting up acme.sh..."

	cd "${RepoDir}"
	bash ./acme.sh $ASHCFG --install -m "${Email}" &>/dev/null
	bash "${ASHBIN}" $ASHCFG --set-default-ca --server "${DefaultCert}" &>/dev/null
	cd "${BaseDir}"

	echo "++" $(du -sh "${InstDir}")
	echo

	return $OK
}

CleanupAcmeShInstall() {

	local RepoDir=$1

	########

	cd "${BaseDir}"

	########

	echo ">> Removing installer files..."
	echo "--" $(du -sh "${RepoDir}")
	rm -rf "${RepoDir}"
	echo

	########

	return $OK
}
