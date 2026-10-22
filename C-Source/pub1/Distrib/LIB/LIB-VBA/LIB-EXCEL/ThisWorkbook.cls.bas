VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Ёта нига"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
' ***************************************************************
'* This Workbook
'* This Module is for Event Traps for Open and Close Excel Workbook
' ***************************************************************

'****
'* Workbook_BeforeClose Procedure
'* This Procedure will
'* Type a Message Box, Save and Close Workbook
'****
Private Sub Workbook_BeforeClose(Cancel As Boolean)
  
  MsgBox "The Current Workbook is being closed and saved.", vbInformation Or vbOKOnly, "—охранение документа и его закрытие"
  
  ThisWorkbook.Save

End Sub

'**********
'* Workbook_Open Procedure
'* This Procedure will Type a Message Box
'**********

Private Sub Workbook_Open()
    Dim msgResult
    msgResult = MsgBox("Turn On the Macros" & vbCrLf & "Are You Sure?", vbInformation Or vbYesNo Or vbDefaultButton1, "¬ключение макросов")
    If msgResult = vbYes Then
        '
    End If
End Sub
