<#
.SYNOPSIS
    This function will install and adjust Windows Server 2016+  
    WebDav Client Service
.DESCRIPTION
    This script will install and adjust Windows Server 2016+ WebDav Client Service
.NOTES
    File name: NIT-Install-WebDAVClient-Service-001.ps1
    VERSION: 1.0.0a
    AUTHOR: New Internet Technologies Inc.
    Created:  2023-06-25
    Licensed under the BSD license.
    Please credit me if you find this script useful and do some cool things with it.
.VERSION HISTORY:
    1.0.0 - (2023-06-25) Script created
    1.0.1 - 
#>

## Install Service
##
&dism.exe /Online /Enable-Features /FeatureName:WebDAV-Redirector /All

## Startup Adjust
##
Set-Service WebClient -StartupType Automatic
Set-Service MRxDAV -StartupType Automatic

##
## Set Paremeters of Service
##
## Set Basic Authentication both https and http protocols
##
Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\WebClient\Parameters\ -Name BasicAuthLevel -Value 2
##
## Set Max Size of the Transfer File 1 Gb
##
Set-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\WebClient\Parameters\ -Name FileSizeLimitInBytes -Value 1073741824

## Start Services
##
Start-Service WebClient
Start-Service MRxDAV

Out-Host The Script is Done.
