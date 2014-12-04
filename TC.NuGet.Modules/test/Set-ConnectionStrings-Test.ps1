$projectPath = "C:\TC\TC.Nuget.Modules\TC.NuGet.Modules"

Remove-Module "Set-ConnectionStrings"
Import-Module (Join-Path $projectPAth "tools\Set-ConnectionStrings.psm1") -Verbose -NoClobber

$installPath = (Join-Path $projectPath "package\")

$project = [PSCustomObject]@{
    FileName = Join-Path $projectPath "project.csproj"
    Name = "Mount.Databases.Test"
}

Copy-Item -Path (Join-Path $projectPath "databases\ConnectionStrings.txt") -Destination (Join-Path $projectPath "databases\ConnectionStrings.config") -Force

Set-ConnectionStrings $project "databases\ConnectionStrings.config" "(local)" "sa" "Password123" "Sitecore_"
