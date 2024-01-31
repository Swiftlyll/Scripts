<# Makes Winget available for ease of software installation.
Install-PackageProvider -Name NuGet -Force
Set-PSRepository WingetTools -InstallationPolicy Trusted 
Install-Module -Name WingetTools -Confirm:$false #>


# List of applications.
$installedApplications = Get-Package

# Google Chrome #
$google = "Google Chrome"
$googleTrue = $installedApplications | Where-Object {$_.Name -eq $google}
$googleVersion = $googleTrue | Select-Object -ExpandProperty Version

# Office 365 #
$office = "Office 16 Click-to-Run Extensibility Component"
$officeTrue = $installedApplications | Where-Object {$_.Name -eq $office}
$officeVersion = $officeTrue | Select-Object -ExpandProperty Version


# Actual Script
if ($null -ne $googleTrue) {
    Write-Host -ForegroundColor Yellow "$google Installed."
    Write-Host -ForegroundColor Yellow "Version Number: $googleVersion"
    
} else {
    Write-Host -ForegroundColor Red "$google is not installed."
    Write-Output "Attempting to install $google..."
}

""

if ($null -ne $officeTrue) {
    Write-Host -ForegroundColor Yellow "Office 365 Installed."
    Write-Host -ForegroundColor Yellow "Version Number: $officeVersion"
    
} else {
    Write-Host -ForegroundColor Red "Office 365 is not installed."
    Write-Output "Attempting to install Office 365..."
}
