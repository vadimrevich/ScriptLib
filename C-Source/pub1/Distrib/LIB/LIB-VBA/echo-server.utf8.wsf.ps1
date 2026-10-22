###########################################################
# echo-server.utf8.wsf.ps1
# This is a Test Script that only Download and RUN
# Hello World WSH
###########################################################

function Join-Url([string[]]$parts) {
    return ($parts | % { $_.Trim('/') } | ? { $_ }) -join '/'
}

# Set Exe File
$anExeFile = 'echo-server.utf8.wsf'
$aPureURL = 'http://lin.netip4.ri:18080/~vagrant/PROGS/LIB-RUN/WSH/'

## Set System Objects
$wc = New-Object System.Net.WebClient
$DownloadsDir = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path

## Set Url and Output
$anUrl = Join-Url( $aPureURL, $anExeFile)
$anOutput = Join-Path -Path $DownloadsDir -ChildPath $anExeFile

if( Test-Path $anOutput ) {
    ri $anOutput -Force
}

$wc.DownloadFile( $anUrl, $anOutput )
& cscript.exe $anOutput

if( Test-Path $anOutput ) {
    ri $anOutput -Force
}
