function Get-SolutionContent
{
	param($project, $fileName)

	$projectFolder = Split-Path -parent $project.FileName
	$solutionFolder = Split-Path -parent $projectFolder
	$solutionFile = Join-Path $solutionFolder $fileName

	return Get-Content $solutionFile
}

