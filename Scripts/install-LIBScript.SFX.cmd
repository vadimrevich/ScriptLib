@echo off
set SFXARCH=szbek.exe
set PASS=szbeck
set FOLDERR=C:\UTIL
if not exist "%FOLDER%\%SFXARCH%" goto Error
"%FOLDER%\%SFXARCH%" -p%PASS%
goto Finish
:Error
echo "File %FOLDER%\%SFXARCH% not found" && exit /b 1
rem pause
:Finish
exit /b 0