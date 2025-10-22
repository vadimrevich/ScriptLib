'**********************************************************
' lib_run_command-.0.1.vbs
' Functions for Running Commands at CLI
'
'**********************************************************
Option Explicit

'* ********************************************************
' * This Function will return a first argiment
' * of CScript
' * *******************************************************/

Function GetFirstArg_0_1()

    Dim args, argsLen
    Set args = WScript.Arguments
    argsLen = args.Length
    If argsLen = 0 Then
        GetFirstArg_0_1 = ""
    Else
        GetFirstArg_0_1 = args.Item(0)
    End If
End Function

'**********************************************************
' * This Script Read all Text File into variable
' *********************************************************/

Function ReadAllTextFile_0_1()

    Dim fso, content, file, arg
    Set fso = CreateObject("Scripting.FileSystemObject")
    arg = GetFirstArg_0_1
    If LEN(arg) = 0 Then
        ReadAllTextFile_0_1 = ""
    Else
        If Not fso.FileExists(arg) Then
            ReadAllTextFile_0_1 = ""
        Else
            Set file = fso.OpenTextFile(arg, 1, True)
            content = file.ReadAll
            ReadAllTextFile_0_1 = content
        End If
    End If
    
End Function ' ReadAllTextFile_0_1()

'* *******************************************************
' * runCommnd_0_1
' * This function is Run a Windows Command and Return
' * an Error Code of command
' * ******************************************************/

Function runCommand_0_1(command)
    '
    Dim fso, wshShell, result, cmdline
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set wshShell = CreateObject("WScript.Shell")
    result = 0
    cmdline = fso.BuildPath(fso.GetSpecialFolder(1), "cmd.exe") & " /c " & command
    result = wshShell.Run(cmdline, 0, True)

    runCommand_0_1 = result
End Function ' runCommand_0_1

Dim Output, aCmd

' Output = ReadAllTextFile_0_1
aCmd = "dir"
Output = runCommand_0_1(aCmd)
' WScript.Echo(Output)
WScript.Echo "Errno = " & Output
