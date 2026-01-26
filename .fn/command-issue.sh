################################################################################
## ashbox.sh issue #############################################################

AshboxRegisterCommandFunction "issue" "CommandIssue"

################################################################################
################################################################################

function CommandIssue() {(

	local Arg=""
	local Domains=""
	local PArgs=""

	################################################################
	################################################################

	function IssueCertAcmeSh() {

		local Args=$1
		local Domains=$2

		########

		bash "${ASHBIN}" $ASHCFG --issue $Args $Domains

		return $KTHXBAI
	};

	################################################################
	################################################################

	for Arg;
	do
		if [[ $Arg =~ \. ]];
		then Domains+="-d ${Arg} "

		elif [[ $Arg == "--porkbun" ]];
		then PArgs+="--dns dns_porkbun "

		elif [[ $Arg == "--digitalocean" ]];
		then PArgs+="--dns dns_dgon "

		else
			PArgs+="${Arg} "
		fi
	done

	########

	if [[ -z $Domains ]];
	then
		ShowHelpFile "ashbox-issue.txt"
		exit 0
	fi

	########

	PrintH2Ln "Beinning acme.sh Certificate Issuing..."
	IssueCertAcmeSh "${PArgs}" "${Domains}"
	echo

	########

	exit $KTHXBAI
)};
