#Connect-MgGraph -Onine -Scopes User.Read.All -NoWelcome


$name = Write-Host ""
$info = Get-MgUser -Filter "givenName -eq $name"

$licenses = ""


Write-Output "Display Name: $($info.DisplayName)"
Write-Output "Email: $($info.Mail)"
Write-Output "Licenses: "