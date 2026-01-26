################################################################################
## ashbox.sh list ##############################################################

AshboxRegisterCommandFunction "list" "CommandList"

################################################################################
################################################################################

function CommandList() {(

	local Arg=""
	local Format="default"
	local Delim=$'\t'

	local Raw=""
	local Buffer=""
	local Lines=()
	local Headers=()
	local Rows=()

	################################################################
	################################################################

	function FetchRawDataAcmeSh() {

		bash "${ASHBIN}" $ASHCFG --list --listraw

		return $KTHXBAI
	};

	function BackfillRawIntoLines() {

		# reference $Raw
		# backfills $Lines=()

		local Line=""
		local IFS=$'\n'

		########

		for Line in $Raw;
		do
			Lines+=($Line)
		done

		########

		return $KTHXBAI
	};

	function BackfillLinesIntoHeadersRows() {

		# reference $Lines
		# backfills $Headers=()
		# backfills $Rows=()

		local Line=""
		local IFS='|'

		########

		for Line in "${Lines[@]}";
		do
			if [[ ${#Headers[@]} -eq 0 ]];
			then
				Headers=($Line)
			else
				Rows+=("$Line")
			fi
		done

		########

		return $KTHXBAI
	};

	function BackfillRowToBits() {

		# reference $Row
		# backfills $Row

		local IFS='|'

		Row=${Row//"||"/"|-|"}
		Row=(${Row[@]})

		return $KTHXBAI
	};

	function BackpackRowIntoBufferJSON() {

		# reference $Headers
		# reference $Row
		# backfills $Buffer

		########

		Buffer+=$'\t'
		Buffer+="{ "
		Buffer+="\"${Headers[0]}\": \"${Row[0]}\", "
		Buffer+="\"${Headers[1]}\": ${Row[1]}, "
		Buffer+="\"${Headers[2]}\": \"${Row[2]}\", "
		Buffer+="\"${Headers[3]}\": \"${Row[3]}\", "
		Buffer+="\"${Headers[4]}\": \"${Row[4]}\", "
		Buffer+="\"${Headers[5]}\": \"${Row[5]}\", "
		Buffer+="\"${Headers[6]}\": \"${Row[6]}\" "
		Buffer+=" },"
		Buffer+=$'\n'

		########

		return $KTHXBAI
	};

	function PrintJSON() {

		# reference $Rows

		local Row=""
		local Buffer=""

		########

		for Row in "${Rows[@]}";
		do
			BackfillRowToBits
			BackpackRowIntoBufferJSON
		done

		echo '['
		echo "${Buffer:0:${#Buffer}-2}"
		echo ']'

		########

		return $KTHXBAI
	};

	function PrintDelimited() {

		# reference $Rows

		local Row=""

		########

		echo $(ArrayJoin "$Delim" ${Headers[@]})

		for Row in "${Rows[@]}";
		do
			Row=${Row//"||"/"|-|"}
			echo $(ArrayJoin "$Delim" ${Row[@]//"|"/" "})
		done

		########

		return $KTHXBAI
	};

	function PrintRaw() {

		# reference $Raw

		echo "${Raw}"

		return $KTHXBAI
	};

	################################################################
	################################################################

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

	Raw=$(FetchRawDataAcmeSh)
	BackfillRawIntoLines
	BackfillLinesIntoHeadersRows

	################################################################
	################################################################

	if [[ $Format == 'tsv' ]] || [[ $Format == 'csv' ]] || [[ $Format == 'ssv' ]];
	then PrintDelimited
	elif [[ $Format == 'json' ]];
	then PrintJSON
	elif [[ $Format == 'default' ]];
	then PrintRaw
	fi

	################################################################
	################################################################

	exit $KTHXBAI
)};
