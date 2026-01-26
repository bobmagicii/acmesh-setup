################################################################################
## ashbox.sh install ###########################################################

AshboxRegisterCommandFunction "install" "CommandInstall"

################################################################################
################################################################################

function CommandInstall() {(

	local ContactEmail=$1
	local DefaultCertAuth="letsencrypt"

	################################################################
	################################################################

	function FetchAcmeShInstall() {

		local RepoURL=$1
		local RepoDir=$2

		echo ">> Downloading ${RepoURL}..."
		rm -rf "${RepoDir}"
		git clone "${RepoURL}" "${RepoDir}" &>/dev/null

		echo "++" $(du -sh "${RepoDir}")
		echo

		return $OK
	};

	function SetupAcmeShInstall() {

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
	};

	function CleanupAcmeShInstall() {

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
	};

	################################################################
	################################################################

	if [[ -z $ContactEmail ]];
	then
		ShowHelpFile "ashbox-install.txt"
		exit $ERR
	fi

	################################################################
	################################################################

	PrintH2Ln "Installing acme.sh..."
	FetchAcmeShInstall "${AcmeShRepoURL}" "${TempDir}"
	SetupAcmeShInstall "${TempDir}" "${ContactEmail}" "${DefaultCertAuth}"
	CleanupAcmeShInstall "${TempDir}"

	################################################################
	################################################################

	exit $OK
)};
