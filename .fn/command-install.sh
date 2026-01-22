
CommandInstall() {

	ContactEmail=$1

	########

	if [ -z "$ContactEmail" ];
	then
		ShowHelpFile ashbox-install.txt
		exit 1
	fi

	########

	# grab the code.

	rm -rf $TempDir
	git clone $RepoURL $TempDir

	# run its installer with the config.

	cd $TempDir
	bash ./acme.sh $ASHCFG --install -m $ContactEmail
	bash $ASHBIN $ASHCFG --set-default-ca --server letsencrypt

	# cleanup the install.

	cd $BaseDir
	rm -rf $TempDir

	########

	exit 0
}
