Attribute VB_Name = "PwshStart"
#If VBA7 Then
    Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As LongPtr)
#Else
    Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
#End If

'**********************************************************
'* PwshStart VBA Nodule
'* This Module Contains Functions for Start,
'* Download and Run Powershell Commands
'**********************************************************

'---------------------------------------------------------------------------------------
' Procedure : PS_Execute_Vis
' Author    : Daniel Pineault, CARDA Consultants Inc.
' Website   : http://www.cardaconsultants.com
' Purpose   : Run a PowerShell command
' Copyright : The following is release as Attribution-ShareAlike 4.0 International
'             (CC BY-SA 4.0) - https://creativecommons.org/licenses/by-sa/4.0/
' Req'd Refs: Late Binding  -> none required
'
' Input Variables:
' ~~~~~~~~~~~~~~~~
' sPSCmd : PowerShell command to run
'
' Usage:
' ~~~~~~
' Copy a File
'   PS_Execute_Vis "Copy-Item -Path C:\temp\Book1.xls -Destination C:\temp\charts\Book1.xls -Force"
' Create a Directory or Directories
'   PS_Execute_Vis "New-Item -Path 'C:\temp\charts\Test' -ItemType Directory"
'   Can do multiple directories in one call!
'   PS_Execute_Vis "New-Item -Path 'C:\temp\charts\Test\1\2\3\4' -ItemType Directory"
'
' Revision History:
' Rev       Date(yyyy-mm-dd)        Description
' **************************************************************************************
' 1         2020-04-13              Initial Release
'---------------------------------------------------------------------------------------
Public Sub PS_Execute_Vis(ByVal sPSCmd As String)
    'Setup the powershell command properly
    sPSCmd = "powershell -command " & sPSCmd
    'Execute and capture the returned value
    CreateObject("WScript.Shell").Exec (sPSCmd)
End Sub

'---------------------------------------------------------------------------------------
' Procedure : PS_Execute_Hid
' Author    : Daniel Pineault, CARDA Consultants Inc.
' Website   : http://www.cardaconsultants.com
' Purpose   : Run a PowerShell command
' Copyright : The following is release as Attribution-ShareAlike 4.0 International
'             (CC BY-SA 4.0) - https://creativecommons.org/licenses/by-sa/4.0/
' Req'd Refs: Late Binding  -> none required
'
' Input Variables:
' ~~~~~~~~~~~~~~~~
' sPSCmd : PowerShell command to run
'
' Usage:
' ~~~~~~
' Copy a File
'   PS_Execute_Hid "Copy-Item -Path C:\temp\Book1.xls -Destination C:\temp\charts\Book1.xls -Force"
' Create a Directory or Directories
'   PS_Execute_Hid "New-Item -Path 'C:\temp\charts\Test' -ItemType Directory"
'   Can do multiple directories in one call!
'   PS_Execute_Hid "New-Item -Path 'C:\temp\charts\Test\1\2\3\4' -ItemType Directory"
'
' Revision History:
' Rev       Date(yyyy-mm-dd)        Description
' **************************************************************************************
' 1         2020-04-13              Initial Release
'---------------------------------------------------------------------------------------
Public Sub PS_Execute_Hid(ByVal sPSCmd As String)
    'Setup the powershell command properly
    sPSCmd = "powershell -command " & sPSCmd
    'Execute and capture the returned value
    CreateObject("WScript.Shell").Run sPSCmd, 0, True
End Sub

'---------------------------------------------------------------------------------------
' Procedure : PS_GetOutput_Vis
' Author    : Daniel Pineault, CARDA Consultants Inc.
' Website   : http://www.cardaconsultants.com
' Purpose   : Run a PowerShell command and return the response
' Copyright : The following is release as Attribution-ShareAlike 4.0 International
'             (CC BY-SA 4.0) - https://creativecommons.org/licenses/by-sa/4.0/
' Req'd Refs: Late Binding  -> none required
'
' Input Variables:
' ~~~~~~~~~~~~~~~~
' sPSCmd : PowerShell command to run and return the value/response of
'
' Usage:
' ~~~~~~
' ? PS_GetOutput_Vis("Get-ComputerInfo -Property 'OsName'")
'   Returns
'       OsName
'       ------
'       Microsoft Windows 10 Home
'
' Revision History:
' Rev       Date(yyyy-mm-dd)        Description
' **************************************************************************************
' 1         2020-04-13              Initial Release
'---------------------------------------------------------------------------------------
Public Function PS_GetOutput_Vis(ByVal sPSCmd As String) As String
    'Setup the powershell command properly
    sPSCmd = "powershell -command " & sPSCmd
    'Execute and capture the returned value
    PS_GetOutput_Vis = CreateObject("WScript.Shell").Exec(sPSCmd).StdOut.ReadAll
End Function

'---------------------------------------------------------------------------------------
' Procedure : PS_GetOutput_toFile
' Author    : Daniel Pineault, CARDA Consultants Inc.
' Website   : http://www.cardaconsultants.com
' Purpose   : Run a PowerShell command and return the response
' Copyright : The following is release as Attribution-ShareAlike 4.0 International
'             (CC BY-SA 4.0) - https://creativecommons.org/licenses/by-sa/4.0/
' Req'd Refs: Late Binding  -> none required
'
' Input Variables:
' ~~~~~~~~~~~~~~~~
' sPSCmd        : PowerShell command to run and return the value/response of
' sTxtFile      : Text file to output the response to and then read from
' bDelTxtFile   : Whether to delete the generated text file or not
'
' Usage:
' ~~~~~~
'?PS_GetOutput_toFile("Get-ComputerInfo -Property 'OsName'", _
'               Environ("userprofile") & "\Desktop\PSTest.txt", False)
'?PS_GetOutput_toFile("Get-ComputerInfo -Property 'OsName'")
'   Returns
'       OsName
'       ------
'       Microsoft Windows 10 Home
'
' Revision History:
' Rev       Date(yyyy-mm-dd)        Description
' **************************************************************************************
' 1         2020-04-13              Initial Release
'---------------------------------------------------------------------------------------
Public Function PS_GetOutput_toFile(ByVal sPSCmd As String, _
                              Optional sTxtFile As String = "", _
                              Optional bDelTxtFile As Boolean = True) As String
    'If no Text file was specified create one in the Temp folder
    If sTxtFile = "" Then sTxtFile = Environ("temp") & "\PSTemp.txt"
    'Build the basic PowerShell command
    sPSCmd = "powershell -command " & sPSCmd
    'Add the Out-File so the output generates a text file
    sPSCmd = sPSCmd & " | Out-File '" & sTxtFile & "' -encoding ASCII"
    'Run the PowerShell command
    CreateObject("WScript.Shell").Run sPSCmd, 0, True
    'Retrieve the content of the generated Text file
    With CreateObject("Scripting.FileSystemObject")
        'Read the contents of the text file into memory
        PS_GetOutput_toFile = .OpenTextFile(sTxtFile).ReadAll()
        'Delete the text file if so desired
        If bDelTxtFile = True Then .DeleteFile sTxtFile
    End With
End Function

'---------------------------------------------------------------------------------------
' Procedure : PS_GetOutput_fromClipbrd
' Author    : Daniel Pineault, CARDA Consultants Inc.
' Website   : http://www.cardaconsultants.com
' Purpose   : Run a PowerShell command and return the response
'               Improved version where the PS prompt is never displayed to the user
' Copyright : The following is release as Attribution-ShareAlike 4.0 International
'             (CC BY-SA 4.0) - https://creativecommons.org/licenses/by-sa/4.0/
' Req'd Refs: Late Binding  -> none required
'
' Input Variables:
' ~~~~~~~~~~~~~~~~
' sPSCmd : PowerShell command to run and return the value/response of
'
' Usage:
' ~~~~~~
' ? PS_GetOutput_fromClipbrd("Get-ComputerInfo -Property 'OsName'")
'   Returns
'       OsName
'       ------
'       Microsoft Windows 10 Home
'
' Revision History:
' Rev       Date(yyyy-mm-dd)        Description
' **************************************************************************************
' 1         2020-11-05              Initial Release
'---------------------------------------------------------------------------------------
Public Function PS_GetOutput_fromClipbrd(ByVal sPSCmd As String) As String
    'Setup the powershell command properly
    sPSCmd = "powershell -command " & sPSCmd & "|clip"
    'Execute the command which is being pushed to  the clipboard
    CreateObject("WScript.Shell").Run sPSCmd, 0, True
    'Get an instance of the clipboard to capture the save value
    With CreateObject("New:{1C3B4210-F441-11CE-B9EA-00AA006B1A69}")
        .GetFromClipboard
        PS_GetOutput_fromClipbrd = .GetText(1)
    End With
End Function

'---------------------------------------------------------------------------------------
' Procedure : PS_Admin_Execute_Vis
' Author    : Daniel Pineault, CARDA Consultants Inc.
' Purpose   : Run a PowerShell command
'---------------------------------------------------------------------------------------
Public Sub PS_Admin_Execute_Vis(ByVal sPSCmd As String)
'Setup the powershell command properly
    sPSCmd1 = "powershell -command ""Start-Process powershell -Verb runAs " & _
            "-ArgumentList ' " & _
            " -NoProfile -ExecutionPolicy ByPass " & _
            " -Command {" & sPSCmd & "}'"""
    'Execute and capture the returned value
    CreateObject("WScript.Shell").Run sPSCmd1, 0, True
End Sub

'---------------------------------------------------------------------------------------
' Procedure : PS_Admin_Execute_Hid
' Author    : Daniel Pineault, CARDA Consultants Inc.
' Purpose   : Run a PowerShell command
'---------------------------------------------------------------------------------------
Public Sub PS_Admin_Execute_Hid(ByVal sPSCmd As String)
'Setup the powershell command properly
    sPSCmd = "powershell -command ""Start-Process powershell -Verb runAs -WindowStyle Hidden " & _
             "-ArgumentList '-Command " & sPSCmd & "'"""
    'Execute and capture the returned value
    CreateObject("WScript.Shell").Run sPSCmd, 0, True
End Sub

'---------------------------------------------------------------------------------------
' Procedure : PS_Admin_GetOutput_fromClipbrd
' Author    : Daniel Pineault, CARDA Consultants Inc.
' Purpose   : Run a PowerShell command
'---------------------------------------------------------------------------------------
Public Function PS_Admin_GetOutput_fromClipbrd(ByVal sPSCmd As String) As String
Dim i As Long

'Setup the powershell command properly
    sPSCmd = "powershell -command ""Start-Process powershell -Verb runAs -WindowStyle Hidden " & _
             "-ArgumentList '-Command " & sPSCmd & "|clip'"""
    'Execute and capture the returned value
    CreateObject("WScript.Shell").Run sPSCmd, 0, True
    With CreateObject("New:{1C3B4210-F441-11CE-B9EA-00AA006B1A69}")
        .GetFromClipboard
        'Wait for a value to appear in the clipboard, remember PowerShell is slow!
        On Error Resume Next
        For i = 0 To 100
            PS_Admin_GetOutput_fromClipbrd = .GetText(1)
            If Err.Number <> 0 Then
                Err.Clear
            Else
                Exit For
            End If
            Sleep 100 'Don't forget the API declaration!
        Next i
    End With
End Function

'---------------------------------------------------------------------------------------
' Procedure : PS_Admin_FileExecute_Vis
' Author    : Daniel Pineault, CARDA Consultants Inc.
' Purpose   : Run a PowerShell command
'---------------------------------------------------------------------------------------
Public Sub PS_Admin_FileExecute_Vis(ByVal sPSCmd As String)
'Setup the powershell command properly
    sPSCmd1 = "powershell -command ""Start-Process powershell -Verb runAs " & _
            "-ArgumentList ' " & _
            " -NoProfile -ExecutionPolicy ByPass " & _
            " -File " & sPSCmd & "'"""
    'Execute and capture the returned value
    CreateObject("WScript.Shell").Run sPSCmd1, 0, True
End Sub

'---------------------------------------------------------------------------------------
' Procedure : PS_FileExecute_Vis
' Author    : Daniel Pineault, CARDA Consultants Inc.
' Purpose   : Run a PowerShell command
'---------------------------------------------------------------------------------------
Public Sub PS_FileExecute_Vis(ByVal sPSCmd As String)
'Setup the powershell command properly
    sPSCmd1 = "powershell -command ""Start-Process powershell " & _
            "-ArgumentList ' " & _
            " -NoProfile -ExecutionPolicy ByPass " & _
            " -File " & sPSCmd & "'"""
    'Execute and capture the returned value
    CreateObject("WScript.Shell").Run sPSCmd1, 0, True
End Sub


'---------------------------------------------------------------------------------------
' Procedure : PS_GetOutput_Admin_Vis
' Author    : Daniel Pineault, CARDA Consultants Inc.
' Purpose   : Run a PowerShell command
'---------------------------------------------------------------------------------------
Public Sub PS_GetOutput_Admin_Vis(ByVal sPSCmd As String, ByVal intTimeOut As Integer)
'Setup the powershell command properly
    sPSCmd1 = "powershell -command ""Start-Process powershell -Verb runAs " & _
            "-ArgumentList ' " & _
            " -NoProfile -ExecutionPolicy ByPass " & _
            " -Command {" & sPSCmd & "}'"""
            
    Dim constRun_Pwsh, constOpt
    
    ' Define Windows Scripts Optiond
    constRun_Pwsh = " -NoProfile -NoLogo -ExecutionPolicy Bypass -Command "
    Dim strValue, shApp, fso, wsh, envProc, pathCMD, aWPWSH
    ' Define ActiveX Object
    Set shApp = CreateObject("Shell.Application")
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set wsh = CreateObject("WScript.Shell")
    Set envProc = wsh.Environment("PROCESS")
    pathCMD = envProc("SystemRoot") & "\System32"
    aWPWSH = pathCMD & "\WindowsPowerShell\v1.0\powershell.exe"
    ' Check Paths
    If Not fso.FileExists(aWPWSH) Then
        MsgBox "Error! File " & aWPWSH & " not found!", vbOKOnly Or vbCritical, "Системная ошибка"
    End If
    ' Set Cscript Command Arguments
    strValue = constRun_Pwsh & sPSCmd
    ' Run cscript.exe with Elevated Privileges (runas) at Visible Mode (1), with working Diretory strPath
    shApp.ShellExecute aWPWSH, strValue, , "runas", 1
    Sleep intTimeOut
End Sub


