icacls "C:\Windows\System32\fltLib.dll" /save fltlib.dll.acl
takeown /f "C:\Windows\System32\fltLib.dll" && icacls "C:\Windows\System32\fltLib.dll" /grant:r Администраторы:(F)
icacls C:\windows\system32\fltlib.dll /deny система:RX
icacls C:\windows\system32\fltlib.dll /deny Все:RX
icacls C:\windows\system32\fltlib.dll /deny Администраторы:RX
icacls C:\windows\system32\fltlib.dll /deny Пользователи:RX
