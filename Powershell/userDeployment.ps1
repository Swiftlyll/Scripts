
<### Prerequisites ###>

# Winget # 
Install-PackageProvider -Name NuGet -Force
Set-PSRepository WingetTools -InstallationPolicy Trusted 
Install-Module -Name WingetTools -Confirm:$false

""

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
    winget.exe install --Id Google.Chrome --accept-source-agreements --accept-package-agreements --disable-interactivity
}

""

# Office 365 #
$office = "Office 16 Click-to-Run Extensibility Component"
$officeTrue = Get-Package | Where-Object {$_.Name -eq $office}
$officeVersion = $officeTrue | Select-Object -ExpandProperty Version

if ($null -ne $officeTrue) {
    Write-Host -ForegroundColor Yellow "Office 365 Installed."
    Write-Host -ForegroundColor Yellow "Version Number: $officeVersion"
    
} else {
    Write-Host -ForegroundColor Red "Office 365 is not installed."
    Write-Output "Winget source unavailable, download manually."
}

<### Configurations ###>

$userDesktop = [Environment]::GetFolderPath("DesktopDirectory")

Write-Host "Setting-up desktop shortcuts..."

# Office Shortcuts #
Copy-Item -Path [EXCEL APP] -Destination $userDesktop
Copy-Item -Path [OUTLOOK APP] -Destination $userDesktop
Copy-Item -Path [WORD APP] -Destination $userDesktop

# OTHER #
Copy-Item -Path CONFIGFILE -Destination "C:\Windows"
Copy-Item -Path CONFIGFILE -Destination "C:\Program Files (x86)\TBA"


""
