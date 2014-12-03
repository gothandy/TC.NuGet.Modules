function Copy-Files
{
	param($installPath, $project, $folder)

	$sourceFolder = Join-Path $installPath ($folder + "\*")
	$projectFolder = Split-Path -parent $project.FileName

	Copy-Item -Path $sourceFolder -Destination $projectFolder -Recurse -Force
}

