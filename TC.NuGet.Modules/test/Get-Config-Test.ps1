$projectPath = "C:\TC\TC.Nuget.Modules\TC.NuGet.Modules"
$solutionPath = (Split-Path -parent $projectPath)
$installPath = (Join-Path $projectPath "package\")

Remove-Module "Get-Config"
Import-Module (Join-Path $projectPAth "tools\Get-Config.psm1") -Verbose -NoClobber

$project = [PSCustomObject]@{
    FileName = Join-Path $projectPath "project.csproj"
}

$projectFile = (Join-Path $projectPath "test.config")
$solutionFile = (Join-Path $solutionPath "test.config")
$packageFile = (Join-Path $installPath "test.config")

Set-Content -Path $projectFile -Value "<Text>Project</Text>"
Set-Content -Path $solutionFile -Value "<Text>Solution</Text>"
Set-Content -Path $packageFile -Value "<Text>Package</Text>"

Write-Host (Get-Config $installPath $project "test.config")
Remove-Item $projectFile

Write-Host (Get-Config $installPath $project "test.config")
Remove-Item $solutionFile

Write-Host (Get-Config $installPath $project "test.config")
Remove-Item $packageFile

Write-Host (Get-Config $installPath $project "test.config")
