$projectPath = "C:\TC\TC.Nuget.Modules\TC.NuGet.Modules"

Remove-Module "Copy-Files"
Import-Module (Join-Path $projectPAth "tools\Copy-Files.psm1") -Verbose -NoClobber

$installPath = (Join-Path $projectPath "package\")

$project = [PSCustomObject]@{
    FileName = Join-Path $projectPath "project\project.csproj"
}

Write-Output $project.FileName

Copy-Files $installPath $project "sitecore"

Remove-Item (Join-Path $projectPath "project\*") -Recurse -Verbose