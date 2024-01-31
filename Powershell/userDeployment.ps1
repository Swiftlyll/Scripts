
<### Prerequisites ###>

# Winget # 
<#
Install-PackageProvider -Name NuGet -Force
Set-PSRepository WingetTools -InstallationPolicy Trusted 
Install-Module -Name WingetTools -Confirm:$false
#>

<### List of Applications ###>

# Google Chrome #
$google = "Google Chrome"
$googleTrue = Get-Package | Where-Object {$_.Name -eq $google} -ErrorAction SilentlyContinue
$googleVersion = $googleTrue | Select-Object -ExpandProperty Version -ErrorAction SilentlyContinue

if ($null -ne $googleTrue) {
    Write-Host -ForegroundColor Yellow "$google Installed."
    Write-Host -ForegroundColor Yellow "Version Number: $googleVersion"
    
} else {
    Write-Host -ForegroundColor Red "$google is not installed."
    Write-Output "Attempting to install $google..."
}

# Office 365 #




$userDesktop = [Environment]::GetFolderPath("DesktopDirectory")

