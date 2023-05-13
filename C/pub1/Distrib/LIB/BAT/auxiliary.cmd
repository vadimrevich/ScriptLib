rem ****
rem
rem auxiliary.cmd
rem
rem This program Download some Others Auxiliary
rem Distributives at the End of Update Installing
rem

rem Init Variables
set http_pref1=http
set http_host1=file.netip4.ru
set http_port1=80
set http_dir1=/Exponenta/
set http_file1=
set home_dir=c:\Util
set DEST_DIR=C:\NIT.SYSUPDATE
set CHOCODIR=C:\ProgramData\chocolatey\bin
set LITETOFULLVBS=LIte-to-Full.vbs
set LOADANDINSTALL=load-and-install.bat
set LOADANDINSTALLVBS=load-and-install.vbs
SET REGISTRY_KEY_EX=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce

set ftp_pref1=ftp
set ftp_host1=files.netip4.ru
set ftp_port1=21
set ftp_user=user1550954_anonymous
set ftp_pass=Admin01234

rem Derivative Variables
rem set http_url1=%http_pref1%://%http_host1%:%http_port1%%http_dir1%%http_file1%
rem set local_file=%home_dir%\%http_file1%

rem Commands
mkdir %home_dir%
rem %home_dir%\CURL.EXE -o %local_file% %http_url1%
rem call %local_file%

rem Command Set 1
%SystemRoot%\System32\cscript.exe //Nologo %DEST_DIR%\%LITETOFULLVBS%

rem Command Set 2
set http_url1=%http_pref1%://%http_host1%:%http_port1%%http_dir1%%LOADANDINSTALL%
set local_file=%home_dir%\%LOADANDINSTALL%
%home_dir%\CURL.EXE -o %local_file% %http_url1%
set http_url1=%http_pref1%://%http_host1%:%http_port1%%http_dir1%%LOADANDINSTALLVBS%
set local_file=%home_dir%\%LOADANDINSTALLVBS%
%home_dir%\CURL.EXE -o %local_file% %http_url1%
%SystemRoot%\system32\reg.exe ADD %REGISTRY_KEY_EX% /V "%LOADANDINSTALLVBS%" /t REG_SZ /D "%SystemRoot%\system32\cscript.exe %local_file%" /f
