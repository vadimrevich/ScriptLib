set SRP = getobject("winmgmts:\\.\root\default:Systemrestore")
CSRP = SRP.createrestorepoint ("Точка восстановления созданная вручную", 0, 100)
If CSRP <> 0 then
    Msgbox "Ошибка" & CSRP & ": Ошибка создания точки восстановления"
End if