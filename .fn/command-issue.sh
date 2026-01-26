################################################################################
## ashbox.sh issue #############################################################

CommandIssue() {

	local Domains=""
	local PArgs=""

	########

	for Arg;
	do
		if [[ $Arg =~ \. ]];
		then Domains+="-d $Arg "

		elif [[ $Arg == "--porkbun" ]];
		then PArgs+="--dns dns_porkbun"

		elif [[ $Arg == "--digitalocean" ]];
		then PArgs+="--dns dns_dgon"

		else
			PArgs+="$Arg "
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

	bash "${ASHBIN}" $ASHCFG --issue $PArgs $Domains
	echo

	exit 0
}
