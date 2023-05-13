@echo off
takeown /f %1 /r /d y && icacls %1 /grant Администраторы:F /t