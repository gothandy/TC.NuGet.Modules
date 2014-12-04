$projectPath = "C:\TC\TC.Nuget.Modules\TC.NuGet.Modules"

Remove-Module "Install-Files" -ErrorAction Ignore
Remove-Module "Uninstall-Files" -ErrorAction Ignore
Import-Module (Join-Path $projectPAth "tools\Install-Files.psm1") -Verbose -NoClobber
Import-Module (Join-Path $projectPAth "tools\Uninstall-Files.psm1") -Verbose -NoClobber

$installPath = (Join-Path $projectPath "package\")

$project = [PSCustomObject]@{
    FileName = Join-Path $projectPath "project\project.csproj"
}

Install-Files $installPath $project "sitecore"
Get-Item ($projectPath + "\project\*")

Uninstall-Files $installPath $project "sitecore"
Get-Item ($projectPath + "\project\*")