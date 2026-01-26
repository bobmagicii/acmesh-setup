################################################################################
## ashbox.sh install ###########################################################

AshboxCommandRegister "install" "CommandInstall"

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
		bash ./acme.sh $AcmeShCfgFlags --install -m "${Email}" &>/dev/null
		bash "${AcmeShCmd}" $AcmeShCfgFlags --set-default-ca --server "${DefaultCert}" &>/dev/null
		cd "${AppRoot}"

		echo "++" $(du -sh "${InstDir}")
		echo

		return $OK
	};

	function CleanupAcmeShInstall() {

		local RepoDir=$1

		########

		cd "${AppRoot}"

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
	FetchAcmeShInstall "${Config['AcmeShRepoURL']}" "${Config['TempDir']}"
	SetupAcmeShInstall "${Config['TempDir']}" "${ContactEmail}" "${DefaultCertAuth}"
	CleanupAcmeShInstall "${Config['TempDir']}"

	################################################################
	################################################################

	exit $OK
)};
