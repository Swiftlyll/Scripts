$userDesktop = [Environment]::GetFolderPath("DesktopDirectory")
$excelShortcut = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Excel.lnk"

<# if (Test-Path -Path $excelShortcut) {
    Write-Output "Creating Excel Shortcut..."
    Copy-Item -Path $excelShortcut -Destination $userDesktop
} else {
    Write-Host -ForegroundColor Red "Could not determine if Excel exists. Verify Office 365 exits or manually add Excel shortcut."
}
#>


# else if => test path is not true ! then check if the excel path exists and create shortcut but if it
# does not print that it does not exist

if (Test-Path -Path $userDesktop\Excel.lnk) {
    Write-Host -ForegroundColor Yellow "Excel shortcut already exists on Desktop... Skipping..."
    break
} elseif (!(Test-Path -Path $userDesktop\Excel.lnk)) {
    Write-Output "Verifying Excel Exists..."
    
    if (Test-Path -Path $excelShortcut){
        Write-Output "Creating Excel Shortcut..."
        Copy-Item -Path $excelShortcut -Destination $userDesktop
    } else {
        Write-Host -ForegroundColor Red "Could not determine Excel installation. Verify Office 365 is installed or manually add Excel shortcut."
    }
}

Write-Host "Done."
