VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "ThisDocument"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
' ***************************************************************
'* This Document
'* This Module is for Event Traps for Open and Close Documents
' ***************************************************************

'****
'* Document_Close Procedure
'* This Procedure will Make Visible a Text Box,
'* Type a Message Box, Save and Close Documents
'****
Public Sub Document_Close()
  
  ActiveDocument.Shapes(1).Name = "Protect Text"
  ActiveDocument.Shapes("Protect Text").Visible = True
  
  MsgBox "The Current document is being closed and saved.", vbInformation Or vbOKOnly, "Сохранение документа и его закрытие"
  
  ActiveDocument.Save

End Sub

'**********
'* Document_Open Procedure
'* This Procedure will Type a Message Box and
'* Make Hidden a Text Box
'**********

Public Sub Document_Open()
    Dim msgResult
    msgResult = MsgBox("Turn On the Macros" & vbCrLf & "Are You Sure?", vbInformation Or vbYesNo Or vbDefaultButton1, "Включение макросов")
    If msgResult = vbYes Then
        ActiveDocument.Shapes(1).Visible = False
    End If
End Sub


