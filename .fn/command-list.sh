
CommandList() {

	Format="default"
	Delim=$'\t'
	Output=""

	Lines=()
	Headers=()
	Rows=()

	########

	for Arg;
	do
		if [[ $Arg == "--csv" ]];
		then
			Format="csv"
			Delim=","
		elif [[ $Arg == '--ssv' ]];
		then
			Format="ssv"
			Delim=" "
		elif [[ $Arg == '--tsv' ]];
		then
			Format="tsv"
			Delim=$'\t'
		elif [[ $Arg == '--json' ]];
		then
			Format="json"
		fi
	done

	## get the data from acme.sh

	Output=$(bash $ASHBIN $ASHCFG --list --listraw)

	## break the output by new line.

	IFS=$'\n'
	for Line in $Output;
	do Lines+=($Line); done
	IFS=' '

	## digest the output into structures.

	IFS='|'
	for Line in "${Lines[@]}";
	do
		if [[ ${#Headers[@]} -eq 0 ]];
		then Headers=($Line);
		else Rows+=("$Line");
		fi
	done
	IFS=' '

	########

	if [[ $Format == 'tsv' ]] || [[ $Format == 'csv' ]] || [[ $Format == 'ssv' ]];
	then
		echo $(ArrayJoin "$Delim" ${Headers[@]})

		for Row in "${Rows[@]}";
		do
			echo $(ArrayJoin "$Delim" ${Row[@]//"|"/" "})
		done
	elif [[ $Format == 'json' ]];
	then

		Buffer=""

		for Row in "${Rows[@]}";
		do
			Row=${Row//"||"/"|-|"}
			Row=(${Row[@]//"|"/" "})

			Buffer+="	{ "
			Buffer+="\"${Headers[0]}\": \"${Row[0]}\", "
			Buffer+="\"${Headers[1]}\": ${Row[1]}, "
			Buffer+="\"${Headers[2]}\": \"${Row[2]}\", "
			Buffer+="\"${Headers[3]}\": \"${Row[3]}\", "
			Buffer+="\"${Headers[4]}\": \"${Row[4]}\", "
			Buffer+="\"${Headers[5]}\": \"${Row[5]}\", "
			Buffer+="\"${Headers[6]}\": \"${Row[6]}\" "
			Buffer+=" },"
		done

		echo '['
		echo ${Buffer:0:${#Buffer}-1}
		echo ']'

	elif [[ $Format == 'default' ]];
	then
		echo $Output
	fi

	########

	exit 0
}
