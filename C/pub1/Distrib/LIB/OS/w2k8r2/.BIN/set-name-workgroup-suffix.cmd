@echo on
rem *******************************************************
rem set-name-workgroup-suffix.cmd
rem This Script Sets Main DNS Suffix with Command Line
rem
rem Location: C:\.BIN
rem *******************************************************
@echo off

rem Define Local Variables (must be changed)
set main_dns_suffix=nit.local
set newcomputername=SERVER
set newworkgroup=NIT

rem Define Local Variables (must not be changed)
set pathcmd=%SystemRoot%\System32
set pathwmic=%pathcmd%\wbem
set regkey01=SearchList
set regkey02=Domain
set regnode01="HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters"
set oldcomputername=%COMPUTERNAME%

rem Code
@echo on
%pathwmic%\wmic.exe computersystem where name="%oldcomputername%" call joindomainorworkgroup name="%newworkgroup%"
%pathwmic%\wmic.exe computersystem where name="%oldcomputername%" call rename name="%newcomputername%"
%pathcmd%\reg.exe Add %regnode01% /V %regkey01% /D %main_dns_suffix% /F
%pathcmd%\reg.exe Add %regnode01% /V %regkey02% /D %main_dns_suffix% /F

