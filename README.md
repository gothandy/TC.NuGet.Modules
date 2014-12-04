# TC.NuGet.Modules

A solution level package that adds a number of general purpose modules to Package Manager Console via init.ps1.

## Cmdlets



### Files
#### Install-Files
#### Uninstall-Files
#### Get-SolutionContent
#### Remove-Files

### Databases
#### Mount Databases
#### Dismount Databases
#### Set-ConnectionStrings

### References
#### Set-AssemblyReferencesCopyLocal

### Security
#### Grant-EveryoneFullControl

## Uninstall Performance Issue
Currently the Uninstall-Files Cmdlet checks the project folder files against those in the package.#
For performence reasons this is the wrong way round to do it. 


