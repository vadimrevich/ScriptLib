@echo on
rem *******************************************************
rem set_downloads_var.bat
rem This Script Gets a Windows Users Download Folder Name
rem and Puts it on console
rem *******************************************************
@echo off
FOR /f "tokens=3" %%Z in ('Reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" ^|findstr /i "REG_"') do SET Downloads=%%Z

echo Downloads = %Downloads%
