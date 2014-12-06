function Get-Config
{
	param($installPath, $project, $fileName)

	$projectFolder = Split-Path -parent $project.FileName
	$solutionFolder = Split-Path -parent $projectFolder

	if (Test-Path (Join-Path $projectFolder $fileName))
	{
		return Get-Content (Join-Path $projectFolder $fileName)
	}
	
	if (Test-Path (Join-Path $solutionFolder $fileName))
	{
		return Get-Content (Join-Path $solutionFolder $fileName)
	}

	if (Test-Path (Join-Path $installPath $fileName))
	{
		return Get-Content (Join-Path $installPath $fileName)
	}

	Write-Host $fileName "not found in Project, Solution or Package root."
}

