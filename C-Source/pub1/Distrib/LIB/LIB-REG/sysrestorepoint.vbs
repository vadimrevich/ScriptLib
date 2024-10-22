'Unattended System Restore Point
'sysrestorepoint.vbs
'© Doug Knox - rev 02/11/2002
'Downloaded from www.dougknox.com 
'Extracted from original code by Bill James - www.billsway.com
'
'*****Editing by Pavel Kravchenko*****
'- Removed msg about successfully creating new restore point
'* Translated in russian msg about failed creation restore point
'* Translated in russian name of new restore point
'*****End Edidting by Pavel Kravchenko*****

Set sr = getobject("winmgmts:\\.\root\default:Systemrestore")

If (sr.createrestorepoint("Точка восстановления создана вручную", 0, 100)) = 0 Then

Else
    MsgBox "Не удалось создать точку восстановления"
End If
