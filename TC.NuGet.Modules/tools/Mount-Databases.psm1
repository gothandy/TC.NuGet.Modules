function Mount-Databases
{
	param($project, $database, $config, $sqlInstanceName, $sqlOwner, $replace, $with)

	#$database = "App_Data\databases"
	#$config = "App_Config\ConnectionStrings.config"
	#$replace = "Sitecore."
	#$with = "."

	$projectFolder = Split-Path -parent $project.FileName
	$projectName = $project.Name
	$databaseFolder = Join-Path $projectFolder $database
	$connectionStringsFileName = Join-Path $projectFolder $config
                         
	[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.Smo') | out-null;

	$server = New-Object Microsoft.SqlServer.Management.Smo.Server($sqlInstanceName);

	if ($server -eq $null)
	{
		Write-Host "Cannot connect to SQL Server: $sqlInstanceName";
		return -1;
	}

	function attachDatabase([Microsoft.SqlServer.Management.Smo.Server] $server, $databaseName, $fileName) 
	{ 
	  foreach ($database in $server.Databases)
	  {
  		if ($database.Name.Equals($databaseName))                  
		{
		  Write-Host "Database $databaseName already exists. Skipping.";
		  return;
  		}
	  }

	  $files = new-object System.Collections.Specialized.StringCollection;
	  $files.Add($databaseFolder + '\' + $fileName + '.mdf') | out-null;
	  $files.Add($databaseFolder + '\' + $fileName + '.ldf') | out-null;

	  $server.AttachDatabase($databaseName, $files, $sqlOwner, [Microsoft.SqlServer.Management.Smo.AttachOptions]::None);

	  Write-Host  "Sitecore Databases - $databaseName Attached.";
	}

	foreach ($file in (dir $databaseFolder\*.mdf))
	{
		#Write-Host $file.FullName;

		if (Test-Path ($file.FullName -replace '.mdf','.ldf'))
		{
			attachDatabase $server ($projectName + ($file.basename -replace $replace,$with)) ($file.BaseName);
		}
	}
}