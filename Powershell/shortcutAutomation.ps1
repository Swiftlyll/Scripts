


### Desktop Path ###

<#
    This will obtain the full explicit path to a users desktop directory. If OneDrive
    is set-up for a user, it will fetch the OneDrive - Desktop folder instead.
#>

# Enumerates all special OS directories, such as Documents, Pictures, AppData etc.
$specialFolders = [Environment+SpecialFolder]::GetNames([Environment+SpecialFolder])
# Obtains the path of each of these directories. Not working, only saves last path.
foreach ($specialFolder in $specialFolders) {
    try {
        $specialPath = [Environment]::GetFolderPath($specialFolder)
    }
    catch {
        Write-Warning "Not able to determine path for $specialFolder."
    }
}

Write-Output $specialPath
