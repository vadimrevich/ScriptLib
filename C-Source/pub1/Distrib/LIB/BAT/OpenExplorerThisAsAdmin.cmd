@echo on
rem *******************************************************
rem OpenExplorerThisAsAdmin.cmd
rem This Script Opens Explorer Window at Current Folder as Administrator
rem *******************************************************
@echo off
rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=
set PRODUCT_NAME_FOLDER=
set FIRM_NAME=NIT
set OS_ARCH=

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem
rem Set Vaariables...
rem
set CURRENTDIR=%~dp0
set EXPLOREREXE=%SystemRoot%\explorer.exe

echo Check Integrity...
rem
if not exist %CURRENTDIR% echo %CURRENTDIR% is not Found && exit /b 1
if not exist %EXPLOREREXE% echo %EXPLOREREXE% is not Found && exit /b 1

rem goto gotPayload

rem
echo Download and Run Payloads...
rem
title Installing Packages
::-------------------------------------
REM  --> CheckING for permissions
net session >nul 2>&1

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
rem Lock Data
rem exit /b 17
rem
set getadminvbs=nit-%~n0.vbs
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TPDL%\%getadminvbs%"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%TPDL%\%getadminvbs%"

    %wscriptexe% "%TPDL%\%getadminvbs%"
    del "%TPDL%\%getadminvbs%"
    exit /B 0

:gotAdmin
echo Run as Admin...

rem Download and Execute Payloads
rem

:gotPayload
echo Run Payload...
rem
start %EXPLOREREXE% %CURRENTDIR%

:End
echo The End of the Script %0
exit /b 0
