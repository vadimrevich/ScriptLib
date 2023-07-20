@echo om
rem *******************************************************
rem Обнаружение компьютеров в Windows 10 Rus
rem SetNetDiscovery.cmd
rem This Script make Computer Visible from a Network
rem *******************************************************
@echo off

rem
rem Set paths...
rem
set pathCMD=%SystemRoot%\System32
rem
rem Set Files...
rem
set NETEXE=%pathCMD%\net.exe
set NETSHEXE=%pathCMD%\netsh.exe
set SCEXE=%pathCMD%\sc.exe
set REGEXE=%pathCMD%\reg.exe

echo Run Payload...
rem

echo Start Services...
rem
%SCEXE% config FDResPub start= auto
%SCEXE% config upnphost start= auto
%SCEXE% config SSDPSRV start= auto
%SCEXE% config fdPHost start= auto
%SCEXE% config Browser start= auto
net start FDResPub
net start upnphost
net start SSDPSRV
net start fdPHost
net start Browser

echo Set Firewall Rules...
rem
%NETSHEXE% advfirewall firewall set rule group="Обнаружение сети" new enable=Yes
%NETSHEXE% advfirewall firewall set rule group="Общий доступ к файлам и принтерам" new enable=Yes

rem English version...
%NETSHEXE% advfirewall firewall set rule group="Network Discovery" new enable=Yes
%NETSHEXE% advfirewall firewall set rule group="File and Printer Sharing" new enable=Yes

echo Enable Smb1 protocol...
rem
Dism /online /Enable-Feature /FeatureName:"SMB1Protocol"
Dism /online /Enable-Feature /FeatureName:"SMB1Protocol-Client"
Dism /online /Enable-Feature /FeatureName:"SMB1Protocol-Server"

echo Add Registry Keys...
rem
%REGEXE% add "HKLM\SYSTEM\CurrentControlSet\services\dnscache" /v Start /t REG_DWORD /d 2 /f