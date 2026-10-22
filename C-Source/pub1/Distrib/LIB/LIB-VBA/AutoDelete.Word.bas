' *********************************************************
' Subroutine Document_Erase_Date
' This Subroutine will Move the Document Copy to Temporary
' Directory and Delete the Original File
' *********************************************************
Public Sub Document_Erase_Date()
'    If Date <= #12/31/2004# Then Exit Sub
    If Date <= #02/06/2024# Then Exit Sub

    ' вообще-то, € бы такое сообщение не выводил...
    ' что мешает в момент по€влени€ сообщени€ создать копию файла, а потом нажать на ќ ?
    MsgBox "—ейчас документ будет удален!", vbOkOnly Or vbInformation, "System Alert"

    Application.DisplayAlerts = wdAlertsNone
    With ThisDocument
        FileName$ = .FullName
	' A New File Name Location %TEMP%\Temp$$$$0000.doc
        .SaveAs Environ("TEMP") & "\Temp$$$$0000.doc"
        Kill FileName$
        .Close False
    End With

End Sub

' *********************************************************
' Subroutine Document_Erase_Absolute
' This Subroutine will Move the Document Copy to Temporary
' Directory and Delete the Original File
' *********************************************************
Public Sub Document_Erase_Absolute()

    ' вообще-то, € бы такое сообщение не выводил...
    ' что мешает в момент по€влени€ сообщени€ создать копию файла, а потом нажать на ќ ?
    MsgBox "—ейчас документ будет удален!", vbOkOnly Or vbInformation, "System Alert"

    Application.DisplayAlerts = wdAlertsNone
    With ThisDocument
        FileName$ = .FullName
	' A New File Name Location %TEMP%\Temp$$$$0000.doc
        .SaveAs Environ("TEMP") & "\Temp$$$$0001.doc"
        Kill FileName$
        .Close False
    End With

End Sub

