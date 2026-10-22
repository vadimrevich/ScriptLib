Attribute VB_Name = "AutoOpen"
'**********************************************************
'* Module Microsoft Word AutoOpen
'* This Module Run an AutoOpen Function
'* which Display a Turning on Macros Message Box
'* and Hide a Banner after it
'**********************************************************

' Event MyEvent with Trap of Application Close
'
Public myEvents As New clsEvents

' Start Event Loop
'
Public Sub StartEvents()
    Set myEvents.app = Word.Application
End Sub

' The End of Event Loop
'
Public Sub EndEvents()
    Set myEvents.app = Nothing
End Sub

' Word AutoOpen Module
'
'Public Sub AutoOpen()
'    Dim msgResult
'    ActiveDocument.Shapes(1).Name = "Protect Text"
'    msgResult = MsgBox("Turn On the Macros" & vbCrLf & "Are You Sure?", vbInformation Or vbYesNo Or vbDefaultButton1, "Включение макросов")
'    If msgResult = vbYes Then
'        ActiveDocument.Shapes("Protect Text").Visible = False
'    End If
'End Sub
