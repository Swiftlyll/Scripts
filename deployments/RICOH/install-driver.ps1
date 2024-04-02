<#
.SYNOPSIS
    Name: Kennet Morales
    Date: 03/29/2024
#>

# For future referece the $ENV:PROCESSOR_ARCHITEW6432 variable only works
# on 32-bit PS sessions as it was designed specifically for that. If ran in a 32-bit session,
# and it returns "AMD64" then that means its running 32-bit on a 64-bit system.
# Note: IntuneExtions is 32-bit, Program x86

# Checks if running 32-bit on 64-bit system
if ($ENV:PROCESSOR_ARCHITEW6432 -eq "AMD64") {

    try {
        & "$ENV:WINDIR\SysNative\WindowsPowershell\v1.0\PowerShell.exe" -File .\install.ps1
    }
    catch {
        Write-Output "Failed to run installation script."
    }

}

else {

    try {
        # Extracts driver store with pnputil.exe and installs specified RICOH driver.
        pnputil.exe /add-driver .\oemsetup.inf
        Add-PrinterDriver -Name "RICOH IM C6000 PCL 6" -ErrorAction Stop
    }
    catch {
        Write-Output "Driver installation failed."
    }

}


