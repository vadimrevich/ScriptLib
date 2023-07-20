@echo on
rem *******************************************************
rem wusa.TLS12.Win61.x64.bat
rem This Script Installs a Support of the TLS 1.2
rem at Windows 6.1 x64 Machines
rem *******************************************************
@echo off

rem Set Path
set pathCMD=%SystemRoot%\System32
set WUSAEXE=%pathCMD%\wusa.exe
set MSUFILE=c:\pub1\Distrib\LIB\LIB-REG\Enable-TLS\TLS12.fix\windows6.1-kb3140245-x64.msu

echo Check Integrity
if not exist %WUSAEXE% echo %WUSAEXE% is not found && exit /b 1
if not exist %MSUFILE% echo %MSUFILE% is not found && exit /b 1

echo Run Payloads...
%WUSAEXE% %MSUFILE% /quiet /norestart

:End
echo The end of the Script %0
exit /b 0
