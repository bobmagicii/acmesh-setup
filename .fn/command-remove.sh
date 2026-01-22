
CommandRemove() {

	Domains=""

	########

	for Domain do
		Domains+="-d $Domain "
	done

	if [[ -z $Domains ]];
	then
		ShowHelpFile ashbox-remove.txt
		exit 0
	fi

	########

	bash $ASHBIN $ASHCFG --revoke $Domains
	bash $ASHBIN $ASHCFG --remove $Domains
	exit 0
}
