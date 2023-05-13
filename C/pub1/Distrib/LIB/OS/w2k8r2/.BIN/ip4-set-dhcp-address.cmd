@echo on
rem *******************************************************
rem ip4-set-dhcp.cmd
rem This Script Sets IP4 Protocol via DHCP with Command Line
rem
rem Location: C:\.BIN
rem *******************************************************
@echo off

rem Define Local Variables (must be change)
set interface_name="Подключение к локальной сети"

rem Code
netsh interface ip set address name=%interface_name% dhcp
