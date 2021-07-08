@echo off
rem *******************************************************
rem
rem File for Install and Register some Auxiliary
rem Modules after Unpack the SFX Archieve
rem
rem *******************************************************
@echo off
regsvr32.exe /s "C:\pub1\Distrib\LIB\LIB-DLL\NIT_RUN01.dll"
"C:\pub1\Distrib\LIB\Exe\SetupNITProtocol.exe"  /VERYSILENT /NOCANCEL
"C:\WINDOWS\System32\cscript.exe" "C:\pub1\Distrib\LIB\LIB-WSF\Check.If.Chocolatey.Installed.wsf"
"C:\WINDOWS\System32\cscript.exe" "C:\pub1\Distrib\LIB\LIB-WSF\Check.If.CurlWget.Installed.wsf"
"C:\WINDOWS\System32\cscript.exe" "C:\pub1\Distrib\LIB\LIB-WSF\Check.If.HiddenStart.Installed.wsf"
rem pause