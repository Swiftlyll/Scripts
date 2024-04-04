<#
.NOTES
    Author: Kennet Morales
    Date: 03/29/2024
    GitHub: https://github.com/swiftlyll
#>

# Tests for 32-bit Session
$is32bit = [IntPtr]::Size -eq 4

if ($is32bit) {
    # Starts 64-bit PowerShell Session
    Write-Output "PowerShell is currently running as 32-bit process, starting 64-bit session..."
    & "$env:WINDIR\SysNative\WindowsPowershell\v1.0\PowerShell.exe" -File .\uninstall-driver.ps1
} 
else {
    Write-Output "Powershell is currently running as 64-bit process."

    try {
        #Retrives Printer Information
        Write-Output "Retrieving printer information..."
        $ricohPrinters = Get-Printer | Where-Object -FilterScript {$_.DriverName -eq "RICOH IM C6000 PCL 6"} -ErrorAction Continue

        foreach ($ricohPrinter in $ricohPrinters) {
            Remove-Printer -Name $ricohPrinter.Name -Confirm:$false -ErrorAction SilentlyContinue # This utilizes methods to call on specific properties, in this case "Name."
            Write-Output "Removed $($ricohPrinter.Name)."
            Remove-PrinterPort -Name $ricohPrinter.PortName -Confirm:$false -ErrorAction SilentlyContinue
            Write-Output "Removed printer ports associated with $($ricohPrinter.Name)."
        }

        # Removes RICOH driver and associated driver store.
        Write-Output "Attempting RICOH driver removal..."
        Remove-PrinterDriver -Name "RICOH IM C6000 PCL 6" -ErrorAction Stop
        Write-Output "Successfully removed RICOH driver."
        
        Write-Output "Attempting removal of driver store..."
        pnputil.exe /delete-driver .\oemsetup.inf /uninstall /force
        Write-Output "Driver store successfully removed."

        Write-Output "Process finished, exiting..."

        Exit 0

    }
    catch {
        Write-Output "Driver removal has failed, please contact support."
        Exit 1
    }

}