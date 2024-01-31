### Desktop Path ###

<#
    This will obtain the full explicit path to a users desktop directory. If OneDrive
    is set-up for a user, it will fetch the OneDrive - Desktop folder instead.
#>

# Creates an empty hashtable to store folders and paths below.
$table = @{}

# Enumerates and lists all special OS directories, such as Documents, ProgramFiles, AppData etc.
$specialFolders = [Environment+SpecialFolder]::GetNames([Environment+SpecialFolder])

# Goes through each special folder and looks for its path.
foreach ($specialFolder in $specialFolders) {

    # Actually conducts the search and creates a key within the hashtable where
    # Key=specialFolder and Value=specialPath
    if ($specialPath = [Environment]::GetFolderPath($specialFolder)) {
        $table[$specialFolder] = $specialPath
    }
}

# Stores the path to the desktop directory 
$desktopDirectory = $table["DesktopDirectory"]
