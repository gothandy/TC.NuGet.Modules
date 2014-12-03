function Set-ConnectionStrings
{
	param($project, $config, $sqlInstance, $sqlInstanceOwner, $sqlPassword)

	# Too Sitecore specific. Needs moving.

	#$config = "App_Config\ConnectionStrings.config"

	$projectName = $project.Name
	$connectionStringsFileName = Join-Path $projectFolderName $config

	$content = (Get-Content $connectionStringsFileName);

	$replace = 'Data Source=\(server\)';
	$with = ('Data Source=' + $sqlInstance);
	$content = $content -replace $replace,$with;
	#Write-Host "Replaced '$replace' with '$with' in $connectionStringsFileName";

	$replace = 'Database=Sitecore_';
	$with = ('Database=' + $projectName + ".");
	$content = $content -replace $replace,$with;
	#Write-Host "Replaced '$replace' with '$with' in $connectionStringsFileName";


	$replace = 'user id=[^;]*;password=[^;]*';
	$with = ('user id='+$sqlInstanceOwner + ';password=' + $sqlpassword);
	$content = $content -replace $replace,$with | Set-Content $connectionStringsFileName;
	#Write-Host "Replaced '$replace' with '$with' in $connectionStringsFileName";
}