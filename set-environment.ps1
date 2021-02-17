param (
	[string]$tier
 )
 
function Main() {

	 if( [string]::IsNullOrWhitespace( $tier) ) {
		Write-Host -foregroundcolor 'green' 'Please specify an environment name.'
	 }
	 
	$isAdmin = Is-Admin;
	if( $isAdmin ) {

		[System.Environment]::SetEnvironmentVariable('ASPNETCORE_ENVIRONMENT', $tier, [System.EnvironmentVariableTarget]::Machine)
		Write-Host "ASPNETCORE_ENVIRONMENT will be set to '$tier' on the next login."
		
	} else {
		Write-Host -foregroundcolor 'red' "This script must be run with elevated privileges.";
	}
}

function Is-Admin {
 $id = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent());
 $id.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);
}

Main;

