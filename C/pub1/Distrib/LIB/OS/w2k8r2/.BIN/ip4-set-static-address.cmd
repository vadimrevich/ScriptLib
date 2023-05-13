@echo on
rem *******************************************************
rem ip4-set-static-address.cmd
rem This Script Sets IP4 Protocol with Command Line
rem
rem Location: C:\.BIN
rem *******************************************************
@echo off

rem Define Local Variables (must be change)
set interface_name="Подключение к локальной сети"
set ip_address=192.168.1.17
set ip_mask=255.255.255.0
set ip_gateway=192.168.1.1

rem Code
@echo on
netsh interface ip set address name=%interface_name% static %ip_address% %ip_mask% %ip_gateway%

