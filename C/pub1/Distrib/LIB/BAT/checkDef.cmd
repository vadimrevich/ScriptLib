@echo on
rem *******************************************************
rem checkDef.cmd
rem This Script Checks a Microsoft Windows Version of an OS
rem and if the Windows Defender only Installed in the OS
rem
rem This Script Uses Programs WMIC.exe, bitsadmin.exe,
rem
rem PARAMETERS:	NONE
rem RETURNS:	0 if Windows 10/11 and Defender Installed
rem		1 if early Windows and Defender Installed
rem		2 if Windows 10/11 and other Antivirus Installed
rem		3 if early Windows and other Antivirus Installed
rem		4 if none Antivirus Installed
rem		5 if none Antivirus Installed
rem		8 if OS is an Windows Vista or Early
rem		16 if a Filesystem Error or Missing a System File
rem
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Set System Variables
rem
set pathCMD=%SystemRoot%\system32
set pathWBEM=%pathCMD%\wbem
set WMICEXE=%pathWBEM%\WMIC.exe
set BITSADMINEXE=%pathCMD%\bitsadmin.exe
set FINDEXE=%pathCMD%\find.exe

rem Check System Variables
if not exist %pathCMD% echo %pathCMD% not found && exit /b 16
if not exist %pathWBEM% echo %pathWBEM% not found && exit /b 16
if not exist %FINDEXE% echo %FINDEXE% not found && exit /b 16

rem Check OS Version
rem
ver | %SystemRoot%\system32\find.exe "Windows [Version 10" > nul
if not errorlevel 1 goto win_10
ver | %SystemRoot%\system32\find.exe "Windows [Version 6.3" > nul
if not errorlevel 1 goto win_early
ver | %SystemRoot%\system32\find.exe "Windows [Version 6.2" > nul
if not errorlevel 1 goto win_early
ver | %SystemRoot%\system32\find.exe "Windows [Version 6.1" > nul
if not errorlevel 1 goto win_early
ver | %SystemRoot%\system32\find.exe "Windows [Version 6.0" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "Windows XP" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "Windows [Version 5.2" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "Windows [‚¥àá¨ï 5.2" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "Windows [Version 5.0" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "Windows [‚¥àá¨ï 5.0" > nul
if not errorlevel 1 goto win_vista
ver | %SystemRoot%\system32\find.exe "win" > nul
if not errorlevel 1 goto win_vista
echo System UnSupported
goto win_vista

:win_vista
echo System Windows Vista or early. Windows Defender is not Supported
exit /b 8

:win_early

echo Windows Early
rem Check Integrity
rem
if not exist %WMICEXE% echo %WMICEXE% not found && exit /b 16
if not exist %BITSADMINEXE% echo %BITSADMINEXE% not found && exit /b 16

rem Check if Antivirus Installed
rem
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Ž˜ˆŠ€"
if not errorlevel 1 echo Antivirus not Installed && set /a exitcode=5 && goto win_early_end
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Error"
if not errorlevel 1 echo Antivirus not Installed && set /a exitcode=5 && goto win_early_end
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Žâáãâáâ¢ãîâ íª§¥¬¯«ïàë"
if not errorlevel 1 echo Antivirus not Installed && set /a exitcode=5 && goto win_early_end
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Missing"
if not errorlevel 1 echo Antivirus not Installed && set /a exitcode=5 && goto win_early_end
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "No Instance(s) Available"
if not errorlevel 1 echo Antivirus not Installed && set /a exitcode=5 && goto win_early_end
set /a exitcode=3
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Windows Defender"
if not errorlevel 1 echo Installed Windows Defender && set /a exitcode=1
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Kaspersky"
if not errorlevel 1 echo Installed Kaspersky Products && set /a exitcode=3
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Dr.Web"
if not errorlevel 1 echo Installed Doctor Web Products && set /a exitcode=3
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Avast"
if not errorlevel 1 echo Installed Avast Products && set /a exitcode=3
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "NOD32"
if not errorlevel 1 echo Installed ESET Products && set /a exitcode=3
:win_early_end
if %exitcode% EQU 5 exit /b 5
if %exitcode% EQU 3 exit /b 3
if %exitcode% EQU 1 exit /b 1
exit /b %exitcode%


:win_10

echo Windows 10
rem Check Integrity
rem
if not exist %WMICEXE% echo %WMICEXE% not found && exit /b 16
if not exist %BITSADMINEXE% echo %BITSADMINEXE% not found && exit /b 16

rem Check if Antivirus Installed
rem
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Ž˜ˆŠ€"
if not errorlevel 1 echo Antivirus not Installed && set /a exitcode=4 && goto win_10_end
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Error"
if not errorlevel 1 echo Antivirus not Installed && set /a exitcode=4 && goto win_10_end
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Žâáãâáâ¢ãîâ íª§¥¬¯«ïàë"
if not errorlevel 1 echo Antivirus not Installed && set /a exitcode=4 && goto win_10_end
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Missing"
if not errorlevel 1 echo Antivirus not Installed && set /a exitcode=4 && goto win_10_end
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "No Instance(s) Available"
if not errorlevel 1 echo Antivirus not Installed && set /a exitcode=4 && goto win_10_end
set /a exitcode=2
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Windows Defender"
if not errorlevel 1 echo Installed Windows Defender && set /a exitcode=0
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Kaspersky"
if not errorlevel 1 echo Installed Kaspersky Products && set /a exitcode=2
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Dr.Web"
if not errorlevel 1 echo Installed Doctor Web Products && set /a exitcode=2
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "Avast"
if not errorlevel 1 echo Installed Avast Products && set /a exitcode=2
%WMICEXE% /Node:. /NameSpace:\\Root\SecurityCenter2 Path AntiVirusProduct Get displayName 2>&1  | %FINDEXE% "NOD32"
if not errorlevel 1 echo Installed ESET Products && set /a exitcode=2
:win_10_end
exit /b %exitcode%

rem The End of the Script

