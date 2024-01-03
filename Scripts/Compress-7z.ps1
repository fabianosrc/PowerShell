<#
.SYNOPSIS
    Compress files in 7z format
.DESCRIPTION
    compress multiple files from a directory in 7-zip format
.EXAMPLE
    PS C:\> .\Compress-7z.ps1
.LINK
    https://github.com/fabianosrc/PowerShell/Scripts/Compress-7z.ps1
#>

$BackupDirectory = ''

$OSArchitecture = (Get-CimInstance -ClassName Win32_OperatingSystem).OSArchitecture

if (Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*' | Select-Object -Property DisplayName | Where-Object { $_ -match '7-Zip' }) {
    switch ($OSArchitecture) {
        '32-bit' { Set-Location -Path 'C:\Program Files (x86)\7-Zip' }
        '64-bit' { Set-Location -Path 'C:\Program Files\7-Zip' }
    }

    if (! (Test-Path -Path $BackupDirectory)) {
        Write-Host 'Directory path is invalid or not defined' -ForegroundColor Yellow
    } else {
        Get-ChildItem -Path $BackupDirectory -Filter '*.*' -Recurse | ForEach-Object {
            7z.exe a -t7z -m0=lzma2 -mx=8 -aoa -mfb=64 -md=32m -ms=on -md=512m -mhe -mmt=off "$($_.DirectoryName)\$($_.BaseName).7z" $_.FullName
        }
    }

    Set-Location -Path $PSScriptRoot
} else {
    Write-Host 'Please, you need to install 7-Zip before proceeding. Click here to download: https://www.7-zip.org/' -ForegroundColor Yellow
}
