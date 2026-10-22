VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "clsEvents"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public WithEvents app As Word.Application
Attribute app.VB_VarHelpID = -1

Private Sub app_DocumentBeforeClose(ByVal Doc As Document, Cancel As Boolean)
  
  ActiveDocument.Shapes(1).Name = "Protect Text"
  ActiveDocument.Shapes("Protect Text").Visible = True
  
  MsgBox "The document " & Doc.FullName & " is being closed."
  
  On Error GoTo errorHandler
  ActiveDocument.Close _
    SaveChanges:=wdPromptToSaveChanges, _
    OriginalFormat:=wdPromptUser
errorHandler:
  If Err = 4198 Then MsgBox "Document was not closed"
End Sub
