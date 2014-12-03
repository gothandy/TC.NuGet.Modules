function Dismount-Databases
{
	param($project, $database, $config, $sqlInstanceName, $replace, $with)

	#$database = "App_Data\databases"
	#$config = "App_Config\ConnectionStrings.config"
	#$replace = "Sitecore."
	#$with = "."

	$projectFolderName = Split-Path -parent $project.FileName
	$projectName = $project.Name
	$databaseFolder = Join-Path $projectFolderName $database
	$connectionStringsFileName = Join-Path $projectFolderName $config

	[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.Smo') | out-null
	$server = new-Object Microsoft.SqlServer.Management.Smo.Server($sqlInstanceName)
	if ($server -eq $null)
	{
		Write-Host "Cannot connect to SQL Server Instance";
		return -1;
	}


	function detachDatabase([Microsoft.SqlServer.Management.Smo.Server] $server, $databaseName) 
	{   
  
	  $server.DetachDatabase($databaseName, $False);
	  Write-Host "Sitecore Databases - $databasename detached.";
	}

	foreach ($file in (dir $databaseFolder\*.mdf)){
		if (Test-Path ($file.fullname -replace '.mdf','.ldf')){
			detachDatabase $server ($projectName + ($file.basename -replace $replace,$with));
		}
	}
}