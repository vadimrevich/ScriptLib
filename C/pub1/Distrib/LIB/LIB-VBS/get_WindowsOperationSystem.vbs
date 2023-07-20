' *********************************************************
' getWindowsOperationSystemType
' This Function Gets Windows Operation System Types
' *********************************************************

Function getWindowsOperationSystemType()
    strComputer = "."
    Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
    Set colOperatingSystems = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")
    For Each objOperatingSystem in colOperatingSystems
        'Wscript.Echo objOperatingSystem.Caption & "  " & objOperatingSystem.Version
        strOS = objOperatingSystem.Version
    Next
    If InStr(1, strOS, "6.1.", vbTextCompare ) Then
        getWindowsOperationSystemType = "6.1"
    elseif InStr(1, strOS, "6.3.", vbTextCompare) Then
        getWindowsOperationSystemType = "6.3"
    elseif InStr(1, strOS, "10.0.22", vbTextCompare) Then
        getWindowsOperationSystemType = "11"
    elseif InStr(1, strOS, "10.0.", vbTextCompare) Then
        getWindowsOperationSystemType = "10"
    Else
        getWindowsOperationSystemType = "Other"
    End If
End Function

Function getWindowsOSArchitecture()
    strComputer = "."
    Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
    Set colOperatingSystems = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")
    For Each objOperatingSystem in colOperatingSystems
        'Wscript.Echo objOperatingSystem.Caption & "  " & objOperatingSystem.Version
        strArch = objOperatingSystem.OSArchitecture
    Next
    If InStr(1, strArch, "32", vbTextCompare ) Then
        getWindowsOSArchitecture = "x86"
    elseif InStr(1, strArch, "64", vbTextCompare) Then
        getWindowsOSArchitecture = "x64"
    Else
        getWindowsOSArchitecture = "Other"
    End If
End Function ' getWindowsOSArchitecture

Function getWindowsOSLanguage()
    strComputer = "."
    Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
    Set colOperatingSystems = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")
    For Each objOperatingSystem in colOperatingSystems
        'Wscript.Echo objOperatingSystem.Caption & "  " & objOperatingSystem.Version
        strLang = objOperatingSystem.OSLanguage
    Next
    If InStr(1, strLang, "1049", vbTextCompare ) Then
        getWindowsOSLanguage = "Russian"
    elseif InStr(1, strLang, "1033", vbTextCompare) Then
        getWindowsOSLanguage = "English"
    Else
        getWindowsOSLanguage = "Other"
    End If
End Function ' getWindowsOSLanguage

Function getIfWindowsOSServer()
    strComputer = "."
    Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
    Set colOperatingSystems = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")
    For Each objOperatingSystem in colOperatingSystems
        'Wscript.Echo objOperatingSystem.Caption & "  " & objOperatingSystem.Version
        strServer = objOperatingSystem.ProductType
    Next
    If InStr(1, strServer, "1", vbTextCompare ) Then
        getIfWindowsOSServer = "Client"
    elseif InStr(1, strServer, "2", vbTextCompare) Then
        getIfWindowsOSServer = "Server Domain Controller"
    elseif InStr(1, strServer, "3", vbTextCompare) Then
        getIfWindowsOSServer = "Server Standalone"
    Else
        getIfWindowsOSServer = "Other"
    End If
End Function ' getWindowsOSLanguage

Function getIfWindowsOSCore()
    Dim fso, wsh, envProc, pathExplorer
    ' Create ActiveX Objects
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set wsh = CreateObject("WScript.Shell")
	Set envProc = wsh.Environment("PROCESS")
    ' Set Windows Explorer Path
    pathExplorer = envProc("SystemRoot") & "\explorer.exe"
    ' Check If a file explorer.exe is present
    If fso.FileExists(pathExplorer) Then
        getIfWindowsOSCore = "Desktop"
    Else
        getIfWindowsOSCore = "Core"
    End If
End Function

'WScript.Echo "Windows " & getWindowsOperationSystemType & " " & getWindowsOSArchitecture & " " & getWindowsOSLanguage & " " & getIfWindowsOSServer & " " & getIfWindowsOSCore
