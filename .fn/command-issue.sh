
CommandIssue() {

	Domains=""
	PArgs=""

	########

	for Arg;
	do
		if [[ $Arg =~ \. ]];
		then Domains += "-d $Arg "

		elif [[ $Arg == "--porkbun" ]];
		then PArgs += "--dns dns_porkbun"

		elif [[ $Arg == "--digitalocean" ]];
		then PArgs += "--dns dns_dgon"

		else
			PArgs += "$Arg "
		fi
	done

	########

	if [[ -z $Domains ]];
	then
		ShowHelpFile ashbox-issue.txt
		exit 0
	fi

	########

	bash $ASHBIN $ASHCFG --issue $PArgs $Domains
	exit 0
}
