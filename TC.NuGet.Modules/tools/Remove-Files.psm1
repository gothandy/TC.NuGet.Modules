function Remove-Files
{
	param($installPath, $filter)

    #Add a log file to only do this once per install.

	Get-ChildItem (Join-Path $installPath $filter) -Recurse |
	ForEach-Object { Remove-Item $_.FullName }
}

