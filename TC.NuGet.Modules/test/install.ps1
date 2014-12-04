## FOR TESTING ##

# When faking $package or $project just isn't enough.

param($installPath, $toolsPath, $package, $project)

Write-Host "TESTING TESTING"

Remove-Module "Set-AssemblyReferencesCopyLocal"

Import-Module (Join-Path $toolsPath "Set-AssemblyReferencesCopyLocal.psm1") -Verbose –NoClobber

Set-AssemblyReferencesCopyLocal $package $project $false
