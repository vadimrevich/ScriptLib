icacls "C:\Windows\System32\fltLib.dll" /save fltlib.dll.acl
takeown /f "C:\Windows\System32\fltLib.dll" && icacls "C:\Windows\System32\fltLib.dll" /grant:r ������������:(F)
icacls C:\windows\system32\fltlib.dll /deny ��⥬�:RX
icacls C:\windows\system32\fltlib.dll /deny ��:RX
icacls C:\windows\system32\fltlib.dll /deny ������������:RX
icacls C:\windows\system32\fltlib.dll /deny ���짮��⥫�:RX
