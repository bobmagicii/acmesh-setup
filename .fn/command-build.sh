################################################################################
## ashbox.sh build #############################################################

AshboxCommandRegister "build" "CommandBuildRelease"

################################################################################
################################################################################

function CommandBuildRelease() {(

	local Version=$1
	local Tarball="ashbox-${Version}.tar.gz";
	local Zipfile="ashbox-${Version}.zip";
	local Include="ashbox.sh .fn .docs";

	local CmdTar="tar -czf ${Tarball} ${Include}"
	local CmdZip="zip -r ${Zipfile} ${Include}"

	sed -i "s/declare -r AppVersion.*/declare -r AppVersion=\"${Version}\"/" ashbox.sh

	$CmdTar >/dev/null
	$CmdZip >/dev/null

	exit $KTHXBAI
)};
