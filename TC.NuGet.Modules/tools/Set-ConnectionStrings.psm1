function Set-ConnectionStrings
{
	param($project, $config, $sqlInstance, $sqlInstanceOwner, $sqlPassword, $database)

	# Too Sitecore specific. Needs moving.

	#$config = "App_Config\ConnectionStrings.config"

	$projectFolder = Split-Path -parent $project.FileName
	$projectName = $project.Name
	$connectionStringsFileName = Join-Path $projectFolder $config

    # Need a test here for if the file exists.

	$content = (Get-Content $connectionStringsFileName);

	$replace = "Data Source=\(server\)";
	$with = ('Data Source=' + $sqlInstance);
	$content = $content -replace $replace,$with;
	#Write-Host "Replaced '$replace' with '$with' in $connectionStringsFileName";

	$replace = "Database=$database"
	$with = ("Database=" + $projectName + ".");
	$content = $content -replace $replace,$with;
	#Write-Host "Replaced '$replace' with '$with' in $connectionStringsFileName";


	$replace = "user id=[^;]*;password=[^;]*";
	$with = ("user id=" + $sqlInstanceOwner + ";password=" + $sqlpassword);
	$content = $content -replace $replace,$with | Set-Content $connectionStringsFileName;
	#Write-Host "Replaced '$replace' with '$with' in $connectionStringsFileName";
}