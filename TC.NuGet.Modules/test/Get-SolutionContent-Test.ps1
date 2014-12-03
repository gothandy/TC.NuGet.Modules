$projectPath = "C:\TC\TC.Nuget.Modules\TC.NuGet.Modules"

Remove-Module "Get-SolutionContent"
Import-Module (Join-Path $projectPAth "tools\Get-SolutionContent.psm1") -Verbose -NoClobber

$project = [PSCustomObject]@{
    FileName = Join-Path $projectPath "project.csproj"
}

[xml]$xml = Get-SolutionContent $project "test.xml"

Write-Host $xml.Test.Item
