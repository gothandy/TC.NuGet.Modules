function Dismount-Databases
{
	param($project, $folder, $instance, $replace, $with)

	#$folder = "App_Data\databases"
	#$replace = "Sitecore."
	#$with = "."

	$projectFolderName = Split-Path -parent $project.FileName
	$projectName = $project.Name
	$databaseFolder = Join-Path $projectFolderName $folder

	[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.Smo') | out-null
	$server = new-Object Microsoft.SqlServer.Management.Smo.Server($instance)
	if ($server -eq $null)
	{
		Write-Host "Cannot connect to SQL Server Instance";
		return -1;
	}


	function detachDatabase([Microsoft.SqlServer.Management.Smo.Server] $server, $databaseName) 
	{   
  
	  $server.DetachDatabase($databaseName, $False);
	  Write-Host "DetachDatabase $databasename";
	}

	foreach ($file in (dir $databaseFolder\*.mdf)){
		if (Test-Path ($file.fullname -replace '.mdf','.ldf')){
			detachDatabase $server ($projectName + ($file.basename -replace $replace,$with));
		}
	}
}