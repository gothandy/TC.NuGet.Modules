function Mount-Databases
{
	param($project, $folder, $instance, $owner, $replace, $with)

	#$database = "App_Data\databases"
	#$replace = "Sitecore."
	#$with = "."

	$projectFolder = Split-Path -parent $project.FileName
	$projectName = $project.Name
	$databaseFolder = Join-Path $projectFolder $folder
                         
	[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.Smo') | out-null;

	$server = New-Object Microsoft.SqlServer.Management.Smo.Server($instance);

	if ($server -eq $null)
	{
		Write-Host "Cannot connect to SQL Server: $instance";
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

	  $server.AttachDatabase($databaseName, $files, $owner, [Microsoft.SqlServer.Management.Smo.AttachOptions]::None);

	  Write-Host  "AttachDatabase $databaseName";
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