<#
.SYNOPSIS
    Script used to obtain basic system information and troubleshoot domain-related issues.

.NOTES
    Author         : Kennet Morales
    Date           : January 01, 2024    
    GitHub         : https://github.com/Swiftlyll
#>

<# Device Information #>
$deviceName=$env:computerName
$domainHostName=[System.Net.Dns]::GetHostByName($env:computerName).HostName

# Device has multiple network interfaces, this pulls the IP for only valid addresses. This means it will filter out IPv6, loopback, and other unused interfaces.
$ipv4 = (Get-NetIPAddress | Where-Object -FilterScript {$_.AddressFamily -eq "IPv4" -and $_.ValidLifetime -lt ([TimeSpan]::MaxValue) }).IPAddress

# Same as above execept it pulls the subnet mask for the address above.
$prefixLength = (Get-NetIPAddress | Where-Object -FilterScript {$_.AddressFamily -eq "IPv4" -and $_.ValidLifetime -lt ([TimeSpan]::MaxValue) }).PrefixLength

# Obtains default gateway and dns servers.
$defaultGateway = (Get-NetRoute -DestinationPrefix 0.0.0.0/0).NextHop
$dns = (Get-DnsClientServerAddress -AddressFamily IPV4).ServerAddresses -join ", "

''

Write-Host "Fetching System Information..."

Write-Output "FQDN Name: $domainHostName"
Write-Output "Device Name: $deviceName"
Write-Output "IP Address: $ipv4/$prefixLength"
Write-Output "Default Gateway: $defaultGateway"
Write-Output "DNS Servers: $dns" 

''

<# Domain Information #>
Write-Host "Fetching Domain Information..."
try {
    $domainName=[System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain().Name
    Write-Host "Device is part of the $domainName domain." -ForegroundColor Yellow
    
    <# DC Ping Test #>
    Write-Host "Testing network connectivity to $domainName..."
    $connectionTest = Test-Connection -ComputerName $domainName -Quiet

    if ($connectionTest -eq $true) {
        Write-Host "Connection to domain controller successful." -ForegroundColor Yellow
        
        <# Verify Trust Relationships #>
        Write-Host "Verifying the status of secure channel between the local computer and the domain..." -ForegroundColor Yellow

        if (!(Test-ComputerSecureChannel)) {
            Write-Host "The secure channel between the local computer and the domain is broken." -ForegroundColor Red
            Write-Host "Fix: Try readding the device to the domain." -ForegroundColor Red
        }
        
        else {
            Write-Verbose "The secure channel between the local computer and the domain is in good condition. No action needed." -Verbose
        }
    }

    elseif ($connectionTest -eq $false) {
        Write-Host "Domain controller is not reachable. Verify connection status and ensure device compliance." -ForegroundColor Red
    }

}    

catch {
    $null
}

if ($null -eq $domainName) {
    Write-Host "Domain Status: Device is not part of a domain." -ForegroundColor Yellow
} 

''

<# Option to Run GPUPDATE #>
$gpQuery = Read-Host "Run GPUPDATE? Yes/No"

if ($gpQuery -eq "Yes") { 
    gpupdate /force
    Write-Host "Exiting..." -ForegroundColor Yellow
}

elseif ($gpQuery -eq "No") {
    Write-Host "Exiting..." -ForegroundColor Yellow
    Exit
}

else {
    Write-Host "Input not valid. Nothing will be ran, exiting." -ForegroundColor Yellow
    Exit 
}
