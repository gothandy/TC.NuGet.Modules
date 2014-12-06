function Uninstall-Files 
{
	param($installPath, $project, $folder)

	$sitecoreFolder = Join-Path $installPath $folder;
	$projectFolder = Split-Path -parent $project.FileName;

	function deleteFileFromProject ($sitecoreObject)
	{
		$commonPath = $sitecoreObject.FullName.Substring($sitecoreFolder.Length)
		$projectPath = Join-Path $projectFolder $commonPath

		if (Test-Path $projectPath)
		{
			$projectObject = Get-Item -Path $projectPath

			if ($sitecoreObject.LastWriteTime -eq $projectObject.LastWriteTime)
			{
				Remove-Item $projectPath -Force
			}
			else
			{
				Write-Host "File modified" $commonPath
			}
		}
	}

	function deleteFolderFromProject ($sitecoreObject)
	{
		$commonPath = $sitecoreObject.FullName.Substring($sitecoreFolder.Length)
		$projectPath = Join-Path $projectFolder $commonPath

		if (Test-Path $projectPath)
		{
			$projectObject = Get-Item -Path $projectPath

			if (($projectObject.GetDirectories().Count -eq 0) -and ($projectObject.GetFiles().Count -eq 0))
			{
				Remove-Item $projectPath -Force
			}
			else
			{
				Write-Host "Folder not empty" $commonPath
			}
		}
	}

	Write-Host "Remove Files."
	Get-ChildItem -Path $sitecoreFolder -Recurse -File |
	ForEach-Object { deleteFileFromProject($_) }

    #Sort by deepest folders first.
	Write-Host "Remove Folders."
	Get-ChildItem -Path $sitecoreFolder -Recurse -Directory |
	sort -Property @{ Expression = {$_.FullName.Split('\').Count} } -Desc |
	ForEach-Object { deleteFolderFromProject($_) }
}




