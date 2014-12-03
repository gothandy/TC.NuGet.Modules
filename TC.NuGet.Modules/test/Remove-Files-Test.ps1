$projectPath = "C:\TC\TC.Nuget.Modules\TC.NuGet.Modules"

Remove-Module "Copy-Files" -ErrorAction Ignore
Remove-Module "Remove-Files" -ErrorAction Ignore
Import-Module (Join-Path $projectPAth "tools\Copy-Files.psm1") -Verbose -NoClobber
Import-Module (Join-Path $projectPAth "tools\Remove-Files.psm1") -Verbose -NoClobber

$installPath = (Join-Path $projectPath "package\")

$project = [PSCustomObject]@{
    FileName = Join-Path $projectPath "project\project.csproj"
}

Copy-Files $installPath $project "sitecore"
Get-Item ($projectPath + "\project\*")

Remove-Files $installPath $project "sitecore"
Get-Item ($projectPath + "\project\*")