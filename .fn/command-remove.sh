################################################################################
## ashbox.sh remove ############################################################

AshboxRegisterCommandFunction "remove" "CommandRemove"

################################################################################
################################################################################

function CommandRemove() {(

	local Arg=""
	local Domain=""
	local DoClean=0

	################################################################
	################################################################

	function CertRemoveAcmeSh() {

		local Domain=$1

		echo ">> Removing ${Domain} from acme.sh..."
		bash "${ASHBIN}" $ASHCFG --remove -d "${Domain}" &>/dev/null

		return $KTHXBAI
	};

	function CertRemoveFiles() {

		local Domain=$1
		local CertDir=$2

		echo ">> Removing ${Domain} certificate files..."
		rm -rf "${CertDir}/${Domain}_ecc"

		return $KTHXBAI
	};

	################################################################
	################################################################

	for Arg;
	do
		if [[ $Arg == "--clean" ]];
		then DoClean=1;
		else Domain=$Arg;
		fi
	done

	########

	if [[ -z $Domain ]];
	then
		ShowHelpFile "ashbox-remove.txt"
		exit $OHSNAP
	fi

	########

	PrintH2Ln "Remove Certificate"
	CertRemoveAcmeSh "${Domain}"

	if [[ $DoClean -eq 1 ]];
	then
		CertRemoveFiles "${Domain}" "${CertDir}"
	fi

	echo

	########

	exit $KTHXBAI
)};
