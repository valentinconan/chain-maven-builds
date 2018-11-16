#location of maven setting.xml file
$mavenSettings="C:\work\apps\maven\apache-maven-3.3.9\conf\settings.xml"
#profiles to use in mvn clean install command
$mavenProfiles="docker,front,!cobertura"

$startDirectory = pwd
 foreach ($tree in $args[0]) {
	$tempCount = $tree.LastIndexOf('\')+1;
	if( $tempCount -gt 1 ){
		$tempName = $tree.Substring($tempCount);
		cd $tree
		pwd
		sleep(2)
		mvn -s $mavenSettings -DskipTests=true clean install -P $mavenProfiles > $startDirectory\logs\build-$tempName.txt
		$isSuccess = Select-String -Path $startDirectory"\logs\build-"$tempName".txt" -Pattern "BUILD SUCCESS"
		if($isSuccess.length -lt 1){
      # if error happened, return to base directory and throw exception
			cd $startDirectory
			throw "Build failed on project "+$tree+" check logs "+$startDirectory+"\logs\build-"+$tempName+".txt"
		}
	}
 }

cd $startDirectory
