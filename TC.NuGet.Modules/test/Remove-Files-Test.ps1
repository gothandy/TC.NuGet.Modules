$projectPath = "C:\TC\TC.Nuget.Modules\TC.NuGet.Modules"

Remove-Module "Remove-Files"
Import-Module (Join-Path $projectPAth "tools\Remove-Files.psm1") -Verbose -NoClobber

$installPath = (Join-Path $projectPath "package\")

Copy-Item "empty.txt" "../package/sitecore/"
New-Item -Path "../package/sitecore/empty" -ItemType Directory -Force
Copy-Item "empty.txt" "../package/sitecore/empty/"

Remove-Files $installPath "sitecore/**/empty.txt"