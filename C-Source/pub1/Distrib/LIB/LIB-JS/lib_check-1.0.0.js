/************************************************************
*
* LIB_CHECK.JS
* This file contain main modules for System Checks
* and Install
* 
* Revision 1.0.0.1 (Basic Beta). May be Present
* This Library links on lib_func-1.1.0.js 
* and lib_check-1.0.0.js
*
************************************************************/

/* *********************************************************
'
' ChecksIfChocolateyInstalled
'
' This function Checks If Chocolatey Packets Installed and Install it if no
'
' PPARAMETERS:	NONE
' RETURNS:	0 if Chocolatey Installed
'		    1 if not Installed
'			2 if Installation Error Occur
'
' *********************************************************/
function ChecksIfChocolateyInstalled () {
	// body... 
	var strVar, iFlag;
	strVar = "ChocolateyInstall";
	iFlag = CheckIfFolderVariableDefined (strVar);
	if( iFlag == 0 )
		return iFlag;
	else {
		iFlag = ChocolateyInstall ();
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
function ChecksIfCurlWgetInstalled (){
	// body... 
	var iFlagCurl, iFlagWget;
	var strVar, iFlag, wsh, envProc, fso;
	// Define ActiveX Variables
    wsh = new ActiveXObject("WScript.Shell");
    envProc = wsh.Environment("PROCESS");
    fso = new ActiveXObject("Scripting.FileSystemObject");
	// Define Variables
	strVar = "ChocolateyInstall";
	iFlag = CheckIfFolderVariableDefined (strVar);
	if( iFlag > 0 ){
		iFlag = ChocolateyInstall ();
		return 3;
	}
	else {
		var strFolder, strCurl, strWget;
		strFolder =envProc(strVar);
		strFolder += "\\bin";
		iFlag = 0;
		var strCurl, strWget, bFlag1;
		strCurl =  "curl.exe";
		strWget = "wget.exe";
		// Check if curl Not Installed
		iFlagCurl = CheckIfFileOrFolderExist( strCurl, strFolder );
		if( iFlagCurl == 2 ){
			return 2;
		}
		else if (iFlagCurl == 1) {
			iFlag = CurlInstall();
			if( iFlag == 2 ) return 2;
			iFlagCurl = 0;
		}
		iFlagWget = CheckIfFileOrFolderExist( strWget, strFolder );
		if( iFlagWget == 2 ){
			return 2;
		}
		else if (iFlagWget == 1) {
			iFlag = WgetInstall();
			if( iFlag == 2 ) return 2;
			iFlagWget = 0;
		}
		if (iFlagCurl == 0 && iFlagWget == 0 ) {
			return 0;
		}
		else {
			return 1;
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
' PPARAMETERS:	NONE
' RETURNS:		0 if Chocolatey Installed
'		    	1 if not Installed
'				3 if Chocolatey Not Installed'
'
' *********************************************************/
function ChecksIfHiddenStartInstalled () {
	// body... 
	var strVar, iFlag, wsh, envProc, fso;
	// Define ActiveX Variables
    wsh = new ActiveXObject("WScript.Shell");
    envProc = wsh.Environment("PROCESS");
    fso = new ActiveXObject("Scripting.FileSystemObject");
	// Define Variables
	strVar = "ChocolateyInstall";
	iFlag = CheckIfFolderVariableDefined (strVar);
	if( iFlag > 0 ){
		iFlag = ChocolateyInstall ();
		return 3;
	}
	else {
		iFlag = 0;
		var strFilePath, bFlag1;
		strFilePath = "C:\\Program Files\\Hidden Start\\hstart.exe";
		// Check if curl Not Installed
		bFlag1 = fso.FileExists( strFilePath );
		if( bFlag1 == false ){
			iFlag = HiddenStartInstall();
			if( iFlag != 0 ){
				iFlag = 1;
			}
		}
	}
	return iFlag;
}

/* *********************************************************
'
' NIT_ShedulerReinstall
'
' This function Force Reinstall NIT-Schedule Packet 
'
' PPARAMETERS:	NONE
' RETURNS:		0 if Chocolatey Installed
'		    	2 if Error Occur
'				3 if Chocolatey Not Installed'
'
' *********************************************************/
function NIT_ShedulerReinstall() {
	// body... 
	var iFlag;
	iFlag = ChecksIfCurlWgetInstalled ()
	if( iFlag == 3 ) {
		return 3;
	}
	if( iFlag != 0 ) {
		return 2;
	}
	iFlag = NITScheduleInstall();
	if (iFlag != 0) {
		return 2;
	}
	return 0;
}

/* *********************************************************
'
' NIT_RevMonReinstall
'
' This function Force Reinstall Reverse Monitoring Packet 
'
' PPARAMETERS:	NONE
' RETURNS:		0 if Chocolatey Installed
'		    	2 if Error Occur
'
' *********************************************************/
function NIT_RevMonReinstall() {
	// body... 
	var iFlag;
	iFlag = ChecksIfChocolateyInstalled ()
	if( iFlag != 0 ) {
		return 3;
	}
	iFlag = ReverseMonInstall();
	if (iFlag != 0) {
		return 2;
	}
	return 0;
}


