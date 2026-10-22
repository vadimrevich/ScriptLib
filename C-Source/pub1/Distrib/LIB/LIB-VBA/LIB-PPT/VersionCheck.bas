Attribute VB_Name = "VersionCheck"
Option Explicit

#If Win64 Then
    Private Declare PtrSafe Function GetVersion Lib "kernel32" () As Long
    Private Declare PtrSafe Function GetVersionEx Lib "kernel32" Alias "GetVersionExA" (lpVersionInformation As OSVERSIONINFO) As Long
#Else
    Private Declare Function GetVersion Lib "kernel32" () As Long
    Private Declare Function GetVersionEx Lib "kernel32" Alias "GetVersionExA" (lpVersionInformation As OSVERSIONINFO) As Long
#End If

Private Type OSVERSIONINFO
    dwOSVersionInfoSize As Long
    dwMajorVersion As Long
    dwMinorVersion As Long
    dwBuildNumber As Long
    dwPlatformId As Long
    szCSDVersion As String * 128
End Type
 
Private Sub GetComputerOSandVersion()
 
    Dim OSInfo As OSVERSIONINFO
    OSInfo.dwOSVersionInfoSize = Len(OSInfo)
    Dim PId As String
 
    If GetVersionEx(OSInfo) = 0 Then MsgBox$ "Error Getting Version Information": Exit Sub
    Select Case OSInfo.dwPlatformId
        Case 0
            PId = "Windows 32s"
        Case 1
            PId = "Windows 95/98"
        Case 2
            PId = "Windows NT"
    End Select
 
    Dim OS As String
    Dim WinVersion As String
    Dim Build As String

    'XP - Windows NT
    OS = "OS: " + PId
    'XP - 5,1
    WinVersion = "Win version:" + Str$(OSInfo.dwMajorVersion) + "." + LTrim(Str(OSInfo.dwMinorVersion))
    'XP - 2600
    Build = "Build: " + Str(OSInfo.dwBuildNumber)
    MsgBox$ OS & Chr(13) & WinVersion & Chr(13) & Build
 
End Sub
Public Function GetWinOSType() As String
    Dim xOS As String
    #If Win64 Then
        xOS = "amd64"
    #Else
        xOS = "x86"
    #End If
    GetWinOSType = xOS
End Function

Public Function GetWinVersion() As String
    Dim Ver As Long, WinVer As Long
    Ver = GetVersion()
    WinVer = Ver And &HFFFF&
    'retrieve the windows version
    GetWinVersion = Format((WinVer Mod 256) + ((WinVer \ 256) / 100), "Fixed")
End Function
Private Sub Form_Load()
'KPD-Team 1999
'URL: [url]http://www.allapi.net/[/url]
'E-Mail: [email]KPDTeam@Allapi.net[/email]
MsgBox "Windows version: " + GetWinVersion
End Sub
' *******************************************************
' Procedure GetOffice_Version
' This Function will Check the Version of the
' Microsoft Office Aplication and Put it into a Message Box
' *******************************************************

Public Sub GetOffice_Version()
    Dim version As String
    Dim anApplication As String
    Dim anApplicationFullPath As String
    Dim fso As Object
    Dim bFlag As Boolean
    
    Dim major As String
    Dim majorup As String
    Dim minor As String
    Dim minorup As String
    
    Set fso = CreateObject("Scripting.FileSystemObject")
    anApplication = "POWERPNT.EXE"
    anApplicationFullPath = Application.Path + "\" + anApplication

    ' List of references
        version = fso.GetFileVersion(anApplicationFullPath)
        major = RetrievePart(version, 0)
        majorup = RetrievePart(version, 1)
        minor = RetrievePart(version, 2)
        minorup = RetrievePart(version, 3)

        MsgBox anApplication & " : " & major & "." & majorup & "." & minor & "." & minorup
        
        version = Application.version
        major = RetrievePart(version, 0)
        majorup = RetrievePart(version, 1)
        minor = Application.Build
        ' minorup = RetrievePart(version, 3)

        MsgBox Application.Name & " : " & major & "." & majorup & "." & minor
        
        MsgBox "Windows Version: " & GetWinVersion & vbNewLine & "Windows Type: " & GetWinOSType & vbNewLine
        
        GetComputerOSandVersion
        bFlag = CheckComputerOSandOfficeVersion()
        If Not bFlag Then
            MsgBox "Ошибка при проверки версии операционной системы и офиса." & vbNewLine & _
            "Данный документ откроется только в 64-х битной операционной" & vbNewLine & _
            "системе Microsoft Windows 8.1/10/11 или Windows Server" & vbNewLine & _
            "2012R2/2016/2019/2022 и установленным Microsoft Office 2007 и выше." & vbNewLine & vbNewLine & _
            "Пожалуйста, обновите Вашу систему!", vbCritical Or vbOKOnly, "System Error"
        End If
        
End Sub

Private Function CheckComputerOSandOfficeVersion() As Boolean
    Dim officeVersion As String
    Dim osType As String
    Dim anOfficeMajor As Integer
    Dim aWindowsMajor As Long
    Dim aWindowsMinor As Long
    Dim OfficeMajor As String
    
    osType = GetWinOSType
    If StrComp(osType, "amd64") <> 0 Then
        CheckComputerOSandOfficeVersion = False
        MsgBox "Error! An OS Type is " & osType & vbNewLine & "which is not corresponded amd64.", vbCritical Or vbOKOnly, "System Error"
        Exit Function
    End If
    officeVersion = Application.version
    OfficeMajor = RetrievePart(officeVersion, 0)
    anOfficeMajor = CInt(OfficeMajor)
    If anOfficeMajor < 12 Then
        CheckComputerOSandOfficeVersion = False
        MsgBox "Error! A Microsoft Office Version is " & OfficeMajor & vbNewLine & "which is not corresponded Microsoft Office 2007 (15) and greater.", vbCritical Or vbOKOnly, "System Error"
        Exit Function
    End If
    Dim OSInfo As OSVERSIONINFO
    OSInfo.dwOSVersionInfoSize = Len(OSInfo)
    
    Dim PId As String
 
    If GetVersionEx(OSInfo) = 0 Then
        CheckComputerOSandOfficeVersion = False
        MsgBox$ "Error Getting Version Information." & vbNewLine & "May OS not to be Recognized?", vbCritical Or vbOKOnly, "System Error"
        Exit Function
    End If
    
    Select Case OSInfo.dwPlatformId
        Case 0
            PId = "Windows 32s"
        Case 1
            PId = "Windows 95/98"
        Case 2
            PId = "Windows NT"
    End Select
    
    If OSInfo.dwPlatformId <> 2 Then
        CheckComputerOSandOfficeVersion = False
        MsgBox$ "Error Getting OS Version Information." & vbNewLine & "OS must be Windows NT Series", vbCritical Or vbOKOnly, "System Error"
        Exit Function
    End If
 
    aWindowsMajor = OSInfo.dwMajorVersion
    aWindowsMinor = OSInfo.dwMinorVersion
    
    If aWindowsMajor < 6 Then
        CheckComputerOSandOfficeVersion = False
        MsgBox$ "Error Getting OS Version." & vbNewLine & "OS must be Windows 8.1 and greater", vbCritical Or vbOKOnly, "System Error"
        Exit Function
    End If
    
    If aWindowsMajor = 6 And aWindowsMinor < 3 Then
        CheckComputerOSandOfficeVersion = False
        MsgBox$ "Error Getting OS Version." & vbNewLine & "OS must be Windows 8.1 and greater", vbCritical Or vbOKOnly, "System Error"
        Exit Function
    End If
    CheckComputerOSandOfficeVersion = True
End Function

' *****************************************************
' Function RetrieveDllVersion
' This Function will Retrieve the Version of the DLL
' File by its Path
'
' PARAMETERS:   dll as String is a full path to dll file
' RETURNS:      as String the Version of the dll file
' *****************************************************
Private Function RetrieveDllVersion(ByVal dll As String) As String
  Dim fso As Object 'Scripting.FileSystemObject
  Set fso = CreateObject("Scripting.FileSystemObject")
  RetrieveDllVersion = fso.GetFileVersion(dll)
End Function

' *****************************************************
' Function RetrievePart
' The Function will Retrieve a Part of the String 'version'
' in Position 'pos' Delimited per dots
'
' PARAMETERS:   version as Sring is a Version Sring with dot delimiter
'               pos as Integer is a position of string withing delimiter (begin with 0)
' RETURNS:      as String a part of the splited string with version at ponted position
'******************************************************
Private Function RetrievePart(ByVal version As String, ByVal pos As Integer) As String
    RetrievePart = Split(version, ".")(pos)
End Function



