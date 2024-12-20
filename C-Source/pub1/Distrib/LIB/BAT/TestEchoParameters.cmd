@echo on
rem *******************************************************
rem TestEchoParameters.cmd
rem This Test Script Simply Run a %1 Script
rem The Script Runs with Elevated Privileges
rem
rem RETURNS:	0 if Success
rem		1 if Check Integrity Folder Error
rem		2 if Check Integrity File Error
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=InitialAdjust
set FIRM=NIT

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem
rem Set Directories Path
set pathCMD=%SystemRoot%\System32
set curdirforurl=%CD%
set PAR1=%1

echo Check if FileSystem correct...
rem
echo Check if Folder Presents...
if not exist %SystemRoot% echo "%SystemRoot% not Exist" && exit /b 1
if not exist "%TPDL%" echo "TEMP not Exist" && exit /b 1
if not exist %pathCMD% echo %pathCMD% not Exist && exit /b 1
if not exist "%pathCMD%\wbem" echo "%pathCMD%\wbem not Exists" && exit /b 1
if not exist "%pathCMD%\WindowsPowerShell\v1.0" echo "%pathCMD%\WindowsPowerShell\v1.0 not Exists" && exit /b 1

rem Check if System File Present at FileSystem
echo check if System File Present...

if not exist "%COMSPEC%" echo "COMSPEC not Exists" && exit /b 2
if not exist "%PATHCMD%\cmd.exe" echo "%PATHCMD%\cmd.exe not Exists" && exit /b 2
if not exist "%PATHCMD%\reg.exe" echo "%PATHCMD%\reg.exe not Exists" && exit /b 2
if not exist "%PATHCMD%\attrib.exe" echo "%PATHCMD%\attrib.exe not Exists" && exit /b 2
if not exist "%PATHCMD%\cscript.exe" echo "%PATHCMD%\cscript.exe not Exists" && exit /b 2
if not exist "%PATHCMD%\wscript.exe" echo "%PATHCMD%\wscript.exe not Exists" && exit /b 2
if not exist "%PATHCMD%\shutdown.exe" echo "%PATHCMD%\shutdown.exe not Exists" && exit /b 2
if not exist "%PATHCMD%\find.exe" echo "%PATHCMD%\find.exe not Exists" && exit /b 2
if not exist "%PATHCMD%\wbem\WMIC.exe" echo "%PATHCMD%\wbem\WMIC.exe not Exists" && exit /b 2
rem if not exist "%PATHCMD%\bitsadmin.exe" echo "%PATHCMD%\bitsadmin.exe not Exists" && exit /b 2
if not exist "%PATHCMD%\WindowsPowerShell\v1.0\powershell.exe" echo "%PATHCMD%\WindowsPowerShell\v1.0\powershell.exe not Exists" && exit /b 2
if not exist "%PAR1%" echo "The File PAR1 = %PAR1% not found" && exit /b 2

:EndSysFilesCheck
echo End System Files Check!

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

echo Run Payloads...
rem call %UserProfile%\echo-hello.bat

if not exist "%PAR1%" echo "The File PAR1 is not Exist" && exit /b 2
call %PAR1%

rem End Payloads

rem The End of the Script
:End
echo End Check Integrity!
exit /b 0
