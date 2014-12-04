$projectPath = "C:\TC\TC.Nuget.Modules\TC.NuGet.Modules"

Remove-Module "Mount-Databases"
Import-Module (Join-Path $projectPAth "tools\Mount-Databases.psm1") -Verbose -NoClobber

Remove-Module "Dismount-Databases"
Import-Module (Join-Path $projectPAth "tools\Dismount-Databases.psm1") -Verbose -NoClobber

$installPath = (Join-Path $projectPath "package\")

$project = [PSCustomObject]@{
    FileName = Join-Path $projectPath "project.csproj"
    Name = "Mount.Databases.Test"
}

Mount-Databases $project "databases" "(local)" "sa" "Sitecore." "."

Dismount-Databases $project "databases" "(local)" "Sitecore." "."
