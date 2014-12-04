function Set-AssemblyReferencesCopyLocal
{
	param($package, $project, $copyLocal)

	$assemblies = $package.AssemblyReferences | %{$_.Name}

	foreach ($reference in $project.Object.References)
	{
	  if ($assemblies -contains $reference.Name + ".dll")
	  {
		$reference.CopyLocal = $copyLocal
		Write-Host ($reference.Name + ".CopyLocal = $copyLocal")
	  }
	}
}

