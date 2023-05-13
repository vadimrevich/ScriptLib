'xp_mydocsopens.vbs
'Copyright 2004 - Doug Knox
'downloaded from http://www.dougknox.com

On Error Resume Next

Set WSHShell = WScript.CreateObject("WScript.Shell")

Set fso = CreateObject("Scripting.FileSystemObject")

SysDir = fso.GetSpecialFolder(1)

SysDir = SysDir & "\userinit.exe,"

WshShell.RegWrite "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\UserInit",SysDir,"REG_SZ"

Set FSO = Nothing
Set WshShell = Nothing

MsgBox "Изменения внесены успешно."