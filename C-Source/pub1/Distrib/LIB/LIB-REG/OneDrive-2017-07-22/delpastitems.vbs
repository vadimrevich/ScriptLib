'�������� "������� ���������" �� ��������� ������� � ������� �����������
'c Pavel Kravchenko (https://mvp.support.microsoft.com/profile/Pavel.Kravchenko)
'������� � www.oszone.net

Message = "��� ���������� ������ ���� ����� �������." & vbCR
Message = Message & "����� ������������ �������� (Windows Explorer shell)." & vbCR
Message = Message & "��� �� ������� ������� ��������� � ������ �������." & vbCR & vbCR
Message = Message & "����������?"

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

MsgBox "��������� ������� �������." & vbcr & vbcr, 4096, "���������"

Else 

MsgBox "��������� �� �������." & vbcr & vbcr, 4096, "�������� �������������"

End If