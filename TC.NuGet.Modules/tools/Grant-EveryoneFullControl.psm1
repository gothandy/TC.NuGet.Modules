function Grant-EveryoneFullControl
{ 
	Param ($project)

	$folder = Split-Path -parent $project.FileName;

	$acl = Get-Acl $folder;
	$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "FullControl", "ContainerInherit, ObjectInherit", "InheritOnly", "Allow")
	$acl.AddAccessRule($rule);

	Set-Acl $folder $acl;

	Write-Host "Everyone has full control to $folder";
}