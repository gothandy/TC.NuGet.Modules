param($installPath, $toolsPath, $package)

$toolsPath = "C:\TC\TC.Nuget.Modules\TC.NuGet.Modules\tools"

$path = Join-Path $toolsPath "*.psm1"
Get-Item $path | ForEach-Object { Import-Module (Join-Path $toolsPath $_.Name) -Verbose –NoClobber }