# Load .NET assembly used for password generation
# Only works with PS 5 due to CIRE not supporing system.web.dll
Add-Type -AssemblyName System.Web

# Generate password
$pass = [System.Web.Security.Membership]::GeneratePassword(15, 5) | ConvertTo-SecureString -AsPlainText -Force

# Create user
New-LocalUser -Name "Helpdesk" -Description "LAPS Admin Account" -Password $pass



<# Found Online

$newAdminUsername = "Admin-Username"
$newPassword = "password"
$secPassword = ConvertTo-SecureString -String $newPassword -AsPlainText -Force

New-LocalUser -Name $newAdminUsername -Password $secPassword
Add-LocalGroupMember -Group "Administrators" -Member $newAdminUsername

#>