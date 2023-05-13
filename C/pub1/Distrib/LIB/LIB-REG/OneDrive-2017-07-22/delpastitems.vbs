'Удаление "Прежних элементов" из настройки значков в области уведомлений
'c Pavel Kravchenko (https://mvp.support.microsoft.com/profile/Pavel.Kravchenko)
'Скачано с www.oszone.net

Message = "Для корректной работы окно будет закрыто." & vbCR
Message = Message & "Будет перезапущена оболочка (Windows Explorer shell)." & vbCR
Message = Message & "Это не вызовет никаких неполадок в работе системы." & vbCR & vbCR
Message = Message & "Продолжить?"

X = MsgBox(Message, vbYesNo, "Notice")

If X = 6 Then

On Error Resume Next

Set WshShell = WScript.CreateObject("WScript.Shell")

WshShell.RegDelete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TrayNotify\IconStreams"
WshShell.RegDelete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TrayNotify\PastIconsStream"

Set WshShell = Nothing

On Error GoTo 0

For Each Process in GetObject("winmgmts:"). _
  ExecQuery ("select * from Win32_Process where name='explorer.exe'")
   Process.terminate(0)
Next

MsgBox "Изменения внесены успешно." & vbcr & vbcr, 4096, "Завершено"

Else 

MsgBox "Изменения не внесены." & vbcr & vbcr, 4096, "Отменено пользователем"

End If