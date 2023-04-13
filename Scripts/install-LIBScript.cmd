@echo off
if not exist "C:\UTIL\UTIL.SFX.exe" goto Error
"C:\UTIL\UTIL.SFX.exe" -p1234
goto Finish
:Error
echo "File "C:\UTIL\UTIL.SFX.exe not found"
rem pause
:Finish
