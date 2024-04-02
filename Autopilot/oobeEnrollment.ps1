<#
.SYNOPSIS
    Author: Kennet Morales
    Date: March 14, 2024
    GitHub: https://github.com/swiftlyll
#>

''

# TLS 1.2 for Data-in-Transit Encryption
Write-Host -ForegroundColor Yellow "Configuring Data-In-Transit Encryption..."
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Write-Output "Done"

# Install Autopilot Script
Write-Host -ForegroundColor Yellow "Installing Autopilot Script..."
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass # Prevents any blocking or errors when downloading scripts for just this session
Install-Script -name Get-WindowsAutopilotInfo -Force # downloads script
Write-Output "Done"

# Enable Script Execution for Current Session
Write-Host -ForegroundColor Yellow "Setting Execution Policy..."
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
Write-Output "Done"

# Collect Hash and Send to Intune.
Write-Host -ForegroundColor Yellow "Enrolling... Please Log-In with Admin."
Get-WindowsAutopilotInfo -Online
Write-Output "Sucessfully Enrolled"