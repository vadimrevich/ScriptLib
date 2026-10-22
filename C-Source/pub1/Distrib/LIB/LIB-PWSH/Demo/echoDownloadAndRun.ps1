#Requires -Version 5.1

<#
.SYNOPSIS
    This Script will Download and Run an echo.wsf Script
.DESCRIPTION
    This Script will Download and Run an echo.wsf Script
    to Local Computer and Adjust It
.NOTES
    File name: echoDownloadAndRun.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2026-01-16
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2024-09-04) Script created
    1.0.1 - 
#>
# param([switch]$Elevated)

###########################################################
# echoDownloadAndRun.ps1
# This Script will Download and Run echo.wsf
# script file on Windows Computers
###########################################################

# Set Functions

### Set Functions
#

Function Check-DownloadShellFolder() {
    try {
        $DownloadShellFolder=(New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
    }
    catch {
        Write-Host "Download Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "Download Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "Download Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

function Get-MyDocumentsShellFolder() {
    $MyDocuments = 5 #System.Environment.SpecialFolder.MyDocuments
    [System.Environment]::GetFolderPath($MyDocuments)
}

function Get-MyVideoFolder(){
    $MyVideo = 14 #System.Environment.SpecialFolder.MyVideo
    [System.Environment]::GetFolderPath($MyVideo)
}

function Get-MyPicturesFolder(){
    $MyPictures = 39 #System.Environment.SpecialFolder.MyVideo
    [System.Environment]::GetFolderPath($MyPictures)
}

function Get-MyMusicFolder(){
    $MyMusic = 13 #System.Environment.SpecialFolder.MyVideo
    [System.Environment]::GetFolderPath($MyMusic)
}

function Get-UserProfileShellFolder() {
    if( !$env:USERPROFILE ) {
        return $null
    }
    else {
        $env:USERPROFILE
    }
}


Function Check-MyDocumentsShellFolder() {
    try {
        $DownloadShellFolder=Get-MyDocumentsShellFolder
    }
    catch {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "My Documents Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

Function Check-UserProfileShellFolder() {
    try {
        $DownloadShellFolder=Get-UserProfileShellFolder
    }
    catch {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }

    if( !$DownloadShellFolder ) {
        Write-Host "User Profile Shell Folder is not Defined"
        return $false
    }


    if( Test-Path $DownloadShellFolder ) {
        Write-Host "User Profile  Shell Folder is $DownloadShellFolder"
        return $true
    }
    else {
        Write-Host "$DownloadShellFolder is not Found"
        return $false
    }
}

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function UploadFromInternet() {
    param (
        [string]$URL,
        [string]$Dir,
        [string]$FileName
    )
    $anURL = $URL + $FileName
    $aDir = Join-Path -Path $Dir -ChildPath $FileName
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile( $anURL, $aDir )
}

function DownloadFomFTP() {
    param (
        [string]$URL,
        [string]$Dir,
        [string]$FileName,
        [string]$UserName,
        [string]$Pass
    )
    $anURL = $URL + $FileName
    $aDir = Join-Path -Path $Dir -ChildPath $FileName
    $wc = New-Object System.Net.WebClient
    $wc.Credentials = New-Object System.Net.NetworkCredential($UserName, $Pass) 
    $wc.DownloadFile( $anURL, $aDir )
}

function RunWsfScript() {
    param (
        [string]$Dir,
        [string]$FileName
    )
    $aPath = Join-Path -Path $Dir -ChildPath $FileName
    $CScriptEXE = Join-Path -Path $env:SystemRoot -ChildPath "system32\cscript.exe"
    & $CScriptEXE //NoLogo $aPath
}
## Set System Objects
if( Check-DownloadShellFolder ) {
    $DownloadsDir = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
}
else {
    Write-Host "Check Integrity Error! Download Folder is not Found."
    Exit 1
}
$MyDesktop = [Environment]::GetFolderPath("Desktop")

### Test Output
Write-Host "Mu Documents: $(Get-MyDocumentsShellFolder)"
Write-Host "My Desktop: $MyDesktop"
Write-Host "My Pictures: $(Get-MyPicturesFolder)"
Write-Host "My Music: $(Get-MyMusicFolder)"
Write-Host "My Video: $(Get-MyVideoFolder)"

### Set Global Variables
$strURLPath = "http://win.netip4.ru/Scripts/LIB-TEST/"
$FileName = "echo.wsf"
$strURLFTP = "ftp://files.netip4.ru/Progs/Scripts/LIB-TEST/"

$UserName = "mssqlsr"
$Pass = "Admin01234"

# UploadFromInternet -URL $strURLPath -Dir $DownloadsDir -FileName $FileName
DownloadFomFTP -URL $strURLFTP -FileName $FileName -Dir $DownloadsDir -UserName $UserName -Pass $Pass

### Run Payloads

#if ((Test-Admin) -eq $false)  {
#    if ($elevated) {
#        # tried to elevate, did not work, aborting
#    } else {
##        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
#        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -Window Normal -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    #}
    #exit
#}

# 'running with full privileges'

RunWsfScript -Dir $DownloadsDir -FileName $FileName
