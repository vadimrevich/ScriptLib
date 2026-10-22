Attribute VB_Name = "Module1"
Sub Outlook_Insert_HTML()

Dim FilePath As String

FilePath = Trim(InputBox("Please insert the file path"))

If Trim(FilePath) = "" Then
    MsgBox "Please input the full path of the html file"
    Exit Sub

End If

Dim insp As Inspector
Set insp = ActiveInspector

If insp.IsWordMail Then
    Dim wordDoc As Word.Document
    Set wordDoc = insp.WordEditor
    wordDoc.Application.Selection.InsertFile FilePath, , False, False, False
End If


Dim Item As Outlook.MailItem

Set Item = insp.CurrentItem

Item.Subject = "Set your email subject here"



End Sub
