@echo on
rem *******************************************************
rem
rem NIT-ssh.64.install.cmd
rem This Script Install and Tunes OpenSSH Service on Windows
rem
rem This Script is only for Windows x64 architecture
rem The Script needs Chocolatey and PowerShell Installation
rem Script must be Run with Elevated Privigeges
rem
rem *******************************************************
@echo on

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

title Installing Packages 
:: BatchGotAdmin
::-------------------------------------
REM  --> CheckING for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" ^
   "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\NIT-ssh.64.install.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\NIT-ssh.64.install.vbs"

    %wscriptexe% "%temp%\NIT-ssh.64.install.vbs"
    del "%temp%\NIT-ssh.64.install.vbs"
    exit /B

:gotAdmin
choco install -y openssh
powershell -NoProfile -WindowStyle Normal ^
 -ExecutionPolicy Bypass ^
 -File "C:\Program Files\OpenSSH-Win64\install-sshd.ps1"
netsh advfirewall firewall ^
 add rule name="OpenSSH Server allow" ^
 dir=in action=allow ^
 program="C:\Program Files\OpenSSH-Win64\sshd.exe" ^
 enable=yes
netsh advfirewall firewall add rule ^
 name="OpenSSH Client allow" dir=out action=allow ^
 program="C:\Program Files\OpenSSH-Win64\ssh.exe" ^
 enable=yes
sc config ssh-agent start= auto
sc config sshd start= auto
net start ssh-agent
net start sshd
