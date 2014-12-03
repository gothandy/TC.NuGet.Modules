function Remove-Files 
{
	param($installPath, $project, $folder)

	$sitecoreFolder = Join-Path $installPath $folder;
	$projectFolder = Split-Path -parent $project.FileName;

	function deleteIfSitecoreFile ($projectObject)
	{
		$commonPath = $projectObject.FullName.Substring($projectFolder.Length)
		$sitecorePath = Join-Path $sitecoreFolder $commonPath

		if (Test-Path $sitecorePath)
		{
			$sitecoreObject = Get-Item -Path $sitecorePath

			if ($projectObject.LastWriteTime -eq $sitecoreObject.LastWriteTime)
			{
				$projectObject.Delete();
			}
			else
			{
				Write-Host "Sitecore file modified " $commonPath
			}
		}
	}

	function deleteIfSitecoreFolder ($projectObject)
	{

		if ($projectObject.GetDirectories().Count -eq 0)
		{
			$commonPath = $projectObject.FullName.Substring($projectFolder.Length)
			$sitecorePath = Join-Path $sitecoreFolder $commonPath

			if ((Test-Path $sitecorePath) -or ($projectObject.Name -eq "debug"))
			{
				$projectObject.Delete();
			}
		}
	}

	Write-Host "Remove Files."
	Get-ChildItem -Path $projectFolder -Recurse -File |
	ForEach-Object { deleteIfSitecoreFile($_) }

	Write-Host "Remove Folders."
	Get-ChildItem -Path $projectFolder -Recurse -Directory |
	Where-Object { $_.GetFiles().Count -eq 0 } |
	sort -Property @{ Expression = {$_.FullName.Split('\').Count} } -Desc |
	ForEach-Object { deleteIfSitecoreFolder($_) }

}




