#Module vars
$ModulePath = $PSScriptRoot

# Credit to https://github.com/ramblingcookiemonster for the structure of this module
# Get public and private function definition files.
$Public = Get-ChildItem $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue
$Private = Get-ChildItem $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue
[string[]]$PrivateModules = Get-ChildItem $PSScriptRoot\Private -ErrorAction SilentlyContinue |
    Where-Object {$_.PSIsContainer} |
    Select -ExpandProperty FullName

# Dot source the files
if ($Private) {
    Write-Host "Private: $Private"
    Foreach ($import in @($Public + $Private)) {
        Try {
            . $import.fullname
        }
        Catch {
            Write-Error "Failed to import function $($import.fullname): $_"
        }
    }
}
else {
    Foreach ($import in $Public) {
        Try {
            Write-Output "Import: $($import.fullname)"
            . $import.fullname
        }
        Catch {
            Write-Error "Failed to import function $($import.fullname): $_"
        }
    }
}
Write-Host "Public: $($Private.count)"

# Load up dependency modules
foreach ($Module in $PrivateModules) {
    Try {
        Import-Module $Module -ErrorAction Stop
    }
    Catch {
        Write-Error "Failed to import module $Module`: $_"
    }
}