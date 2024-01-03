<#
.SYNOPSIS
    Rename part of fileName in directory
.DESCRIPTION
    Renames parts of a list of files from a directory
.EXAMPLE
    PS C:\> .\Replace-Part-Of-Filename.ps1
.LINK
    https://github.com/fabianosrc/PowerShell
#>

$path = ''
$partial = ''
$replace = ''

if (! (Test-Path -Path $path)) {
    Write-Host 'Directory path is invalid or not defined' -ForegroundColor Yellow
} else {
    Get-ChildItem -Path $path -Filter '*.*' -Recurse | ForEach-Object {
        Rename-Item -Path $_.FullName -NewName $_.Name.Replace($partial, $replace)
    }
}
