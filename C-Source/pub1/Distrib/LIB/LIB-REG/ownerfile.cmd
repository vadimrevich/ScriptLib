@echo off
takeown /f %1 && icacls %1 /grant Администраторы:(F)
