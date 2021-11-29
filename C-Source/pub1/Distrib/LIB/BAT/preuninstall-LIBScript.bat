@echo off
rem *******************************************************
rem
rem File for Install and Register some Auxiliary
rem Modules after Unpack the SFX Archieve
rem
rem *******************************************************
@echo off
regsvr32.exe /u /s "C:\pub1\Distrib\LIB\LIB-DLL\NIT_RUN01.dll"
regsvr32.exe /u /s "C:\pub1\Distrib\LIB\LIB-DLL\NITRUN03.dll"
reg.exe import "C:\Util\nit-exe-unreg.reg"
del /Q /F "C:\Util\nit-exe-unreg.reg"
del /Q /F "C:\Util\nit-exe.script.bat"


