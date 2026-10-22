'**********************************************************
'* Module Echo
'* A Script Module to Run Message Boxes
'* with Hello World Message
'**********************************************************

Sub theECHO ()
    MsgBox "Привет, мир!", vbOkOnly Or vbCritical, "System Error"
    MsgBox "Привет, мир!", vbOkOnly Or vbQuestion, "System Question"
    MsgBox "Привет, мир!", vbOkOnly Or vbInformation, "System Information"
End Sub