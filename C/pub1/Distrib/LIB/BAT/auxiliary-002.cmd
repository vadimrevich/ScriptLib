@echo on
rem ***************************************************************************
rem
rem load-and-install.bat
rem
rem This file Downloads and Installs Main Exponenta Files and Plugins
rem on local computer
rem
rem ALGORITHM
rem This Command Script Install some packets over Private Chocolatey Repository
rem and some packets over Download and Install Scripts
rem
rem PARAMETERS: NO
rem RETURN:	NO
rem
rem ***************************************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Deny Shutdown and Restart Options
rem Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d "145" /f
rem Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoClose" /t REG_DWORD /d "1" /f
rem Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "shutdownwithoutlogon" /t REG_DWORD /d "0" /f

rem Set Directories Path
set curdirforurl=%CD%
set home_dir=c:\Util
set DEST_DIR=C:\NIT.SYSUPDATE
set PUB1=C:\pub1

rem Initialization Download Variables

set http_pref1=http
set http_host1=file.netip4.ru
set http_port1=80
set http_dir1=/Exponenta/Distrib/bin/
set http_dir0=/Exponenta/

set http_pref2=http
set http_host2=win.netip4.ru
set http_port2=80
set http_clientsdir2=/Clients/all-clients/
set http_clientsbin2=%http_clientsdir2%bin-scripts/
set http_clientstasks2=%http_clientsdir2%Tasks/
set http_clientstasksbin2=%http_clientsdir2%bin-tasks/

set ftp_pref1=ftp
set ftp_host1=files.netip4.ru
set ftp_port1=21
set ftp_user=user1550954_anonymous
set ftp_pass=Admin01234

rem Derivatives Variables
set host=%http_pref1%://%http_host1%:%http_port1%%http_dir1%
set host0=%http_pref1%://%http_host1%:%http_port1%%http_dir0%
set hoststaskbin=%http_pref2%://%http_host2%:%http_port2%%http_clientstasksbin2%
set LocalFolder=%PUB1%\Distrib

rem Set Files

set EXCLUSIONS=Set-Param-Exclusion-1234.bat

rem Download
%SystemRoot%\System32\bitsadmin /Transfer STEA_TRANSFER /DOWNLOAD /Priority FOREGROUND %host0%wget.exe %LocalFolder%\wget.exe %host0%/LIBCURL.DLL %LocalFolder%\libcurl.dll %host0%/CURL.EXE %LocalFolder%\curl.exe

Set xOS=x64 & If "%PROCESSOR_ARCHITECTURE%"=="x86" If Not Defined PROCESSOR_ARCHITEW6432 Set xOS=x32

rem Install LiteFullUpdate Packets
set LITEFULLUPDATEBAT=LITEFULLUPDATE.bat
set host0=%http_pref1%://%http_host1%:%http_port1%%http_dir0%
curl %host0%/%LITEFULLUPDATEBAT% -o %DEST_DIR%\%LITEFULLUPDATEBAT%
call %DEST_DIR%\%LITEFULLUPDATEBAT%

rem Install Chocolatey Packages

rem Main Files

rem Additional Packets

choco install -y --source=http://win.netip4.ru:8624/nuget/choco-feed/ sordum.org
choco install -y --source=http://win.netip4.ru:8624/nuget/choco-feed/ utils-pack.nit
rem choco install -y --source=http://win.netip4.ru:8624/nuget/choco-feed/ kms-tools-download

rem  Download Direct Install Packets

wget %host%/java-install.bat -O %LocalFolder%\java-install.bat -c -t 38 -w 120 -T 1800
wget %host%/DTLiteInstaller.exe -O %LocalFolder%\DTLiteInstaller.exe -c -t 38 -w 120 -T 1800
wget %host%/duck-Install.bat -O %LocalFolder%\duck-Install.bat -c -t 38 -w 120 -T 1800
wget %host%/pwshcore-install.bat -O %LocalFolder%\pwshcore-install.bat -c -t 38 -w 120 -T 1800
wget %host%/Hstart_4.9-setup.exe  -O %LocalFolder%\Hstart_4.9-setup.exe -c -t 38 -w 120 -T 1800

echo Downloads and install NIT-Scheduler.bat...
rem
DEL /F /Q "%LocalFolder%\NIT-Scheduler.bat"
wget %host%/NIT-Scheduler.bat -O %LocalFolder%\NIT-Scheduler.bat -c -t 38 -w 120 -T 1800
call %LocalFolder%\NIT-Scheduler.bat

rem Install Direct Install Packets

%LocalFolder%\Hstart_4.9-setup.exe /S
call %LocalFolder%\java-install.bat
call %LocalFolder%\pwshcore-install.bat
call %LocalFolder%\duck-Install.bat
rem 
rem Install Services
rem sc config RManService start= auto
rem net start RManService

rem Restore ShutDown and Restart Options
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d "145" /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoClose" /f
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "shutdownwithoutlogon" /t REG_DWORD /d "1" /f

