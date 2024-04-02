$netInterface = Get-NetIPAddress | Where-Object -FilterScript {$_.AddressFamily -eq "IPv4" -and $_.ValidLifetime -lt ([TimeSpan]::MaxValue) }
$defaultRoute = Get-NetRoute -InterfaceIndex $netInterface.InterfaceIndex -DestinationPrefix "0.0.0.0/0"
$dnsServers = Get-DnsClientServerAddress -InterfaceIndex $netInterface.InterfaceIndex


Write-Host "Device Information" -ForegroundColor Yellow
Write-Output "Device Name: $env:computerName"

Write-Host "Network Information" -ForegroundColor Yellow 
Write-Output "IP Address: $($netInterface.IPAddress)/$($netInterface.PrefixLength)"
Write-Output "Default Gateway: $($defaultRoute.NextHop)"
Write-Output "DNS Servers: $($dnsServers.ServerAddresses -join ", ")"

Write-Host "Domain Information" -ForegroundColor Yellow

# Verifies domain association and tests connection to the DC
try {   
    
    $domainName = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().Name # Creates an error if not associated with a domain
    Write-Output "Domain: $domainName"
    
    try {
        
        Test-Connection -ComputerName $domainName -Quiet -ErrorAction Stop
        Write-Output "Connection Status: Reachable"
        
        if (!(Test-ComputerSecureChannel)) {
            Write-Output "Secure Channel: Channel Broken... Attempting Repair..."
            
            try {
                Test-ComputerSecureChannel -Repair -Quiet -ErrorAction Stop
                Write-Output "Successfully repaired secure channel."
            }
            catch {
                Write-Output "Failed to repair secure channel."
            }
            
        } else {
            Write-Output "Secure Channel: Healthy"
        }

    }
    catch {
        Write-Output "Connection Status: Not Reachable"
    }

}
catch {
    Write-Output "Domain: Device is not associated with a domain."
}