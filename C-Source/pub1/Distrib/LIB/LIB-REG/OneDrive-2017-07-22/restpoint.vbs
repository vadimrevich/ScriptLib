set SRP = getobject("winmgmts:\\.\root\default:Systemrestore")
CSRP = SRP.createrestorepoint ("����� �������������� ��������� �������", 0, 100)
If CSRP <> 0 then
    Msgbox "������" & CSRP & ": ������ �������� ����� ��������������"
End if