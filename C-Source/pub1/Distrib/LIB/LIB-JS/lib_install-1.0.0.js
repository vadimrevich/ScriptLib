/************************************************************
*
* LIB_INSTALL.JS
* This file contain main modules for Exponenta 
* Module Installation
*
* Revision 1.0.0.0 (Basic Beta). May be Present
* This Library links on lib_func-1.1.0.js
* and lib_func-1.0.0.js
*
************************************************************/


/* *********************************************************
'
' ChocolateyInstall_OLD
'
' This function Install Chocolatey Packet and its Updates
' and dependences (deprecated)
'
' PPARAMETERS:	NONE
' EXTERNAL SET PARAMETERS:
'	strURLHost = "http://file.tuneserv.ru/Scripts/Install/vbs/"; // URL to File Download
'	strFile = "sysupdate.vbs";
	iTimeOut = 360000; // 6 min
' RETURNS:	0 if Success
'		2 if If Errors Occur
'
' *********************************************************/
function ChocolateyInstall_OLD() {
	var strFile, iTimeOut;
	strURLHost = "http://file.tuneserv.ru/Scripts/Install/vbs/"; // URL to File Download
	strFile = "sysupdate.vbs";
	iTimeOut = 360000; // 6 min
	iFlag = ScriptDownlRun03( strURLHost, strFile );
	if( iFlag == 1 )
		return 2;
	else
		return 0;
}

/* *********************************************************
'
' ChocolateyInstall_WinNew
'
' This function Install Chocolatey Packet and its Updates
' and dependences
'
' PPARAMETERS:	NONE
' EXTERNAL SET PARAMETERS:
'	strURLHost = "http://file.tuneserv.ru/WinUpdate/WindowsMainUpdate/Other/"; // URL to File Download
'	strFile = "chock.install-001.cmd";
	iTimeOut = 360000; // 6 min
' RETURNS:	0 if Success
'		2 if If Errors Occur
'
' *********************************************************/
function ChocolateyInstall_WinNew () {
	var strFile, iTimeOut;
	strURLHost = "http://file.tuneserv.ru/WinUpdate/WindowsMainUpdate/Other/"; // URL to File Download
	strFile = "chock.install-001.cmd";
	iTimeOut = 360000; // 6 min
	iFlag = CmdDownlRun03( strURLHost, strFile );
	if( iFlag == 1 )
		return 2;
	else
		return 0;
}


/* *********************************************************
'
' CurlInstall
'
' This function Install Curl Packet and its Updates
' and dependences
'
' PARAMETERS: 	NONE;
' EXTERNAL SET PARAMETERS:
'	iTimeOut = 240000; // 4 min
'	strName = "curl" //Packet
'	strSource = "" // Default Source
'	strVar = "ChocolateyInstall" // Directory with Chocolatey
' RETURNS:	0 if Success
'		2 if If Errors Occur
'
' *********************************************************/
function CurlInstall() {
	// body... 
	// Define Variables
	var strVar, wsh, envProc, iFlag;
	var strName, iTimeOut;
	strVar = "ChocolateyInstall";
	strName = "curl";
	strSource = ""
	iTimeOut = 240000; //4 min
    iFlag = CheckIfFolderVariableDefined (strVar);
	if( iFlag > 0 )
		return 2;
	else {
		// Define ActiveX Variables
	    wsh = new ActiveXObject("WScript.Shell");
    	envProc = wsh.Environment("PROCESS");
		var shApp, strApplication, strOption;
		// Define ActiveX Variables
		shApp = new ActiveXObject("Shell.Application");
		// Code
		strApplication = envProc( strVar ) + "\\bin\\cinst.exe";
		strOption = "-y --ignore-checksum " + strName + strSource;
		shApp.ShellExecute(strApplication, strOption, envProc( strVar ), "runas", 0 );
		WScript.Sleep(iTimeOut);
		return 0;
	}
}


/* *********************************************************
'
' WgetInstall
'
' This function Install wget Packet and its Updates
' and dependences
'
' PARAMETERS: 	NONE;
' EXTERNAL SET PARAMETERS:
'	iTimeOut = 240000; // 4 min
'	strName = "wget" //Packet
'	strSource = "" // Default Source
'	strVar = "ChocolateyInstall" // Directory with Chocolatey
' RETURNS:	0 if Success
'		2 if If Errors Occur
'
' *********************************************************/
function WgetInstall() {
	// body... 
	// Define Variables
	var strVar, wsh, envProc, iFlag;
	var strName, iTimeOut;
	strVar = "ChocolateyInstall";
	strName = "wget";
	strSource = ""
	iTimeOut = 240000; //4 min
    iFlag = CheckIfFolderVariableDefined (strVar);
	if( iFlag > 0 )
		return 2;
	else {
		// Define ActiveX Variables
	    wsh = new ActiveXObject("WScript.Shell");
    	envProc = wsh.Environment("PROCESS");
		var shApp, strApplication, strOption;
		// Define ActiveX Variables
		shApp = new ActiveXObject("Shell.Application");
		// Code
		strApplication = envProc( strVar ) + "\\bin\\cinst.exe";
		strOption = "-y --ignore-checksum " + strName + strSource;
		shApp.ShellExecute(strApplication, strOption, envProc( strVar ), "runas", 0 );
		WScript.Sleep(iTimeOut);
		return 0;
	}
}

/* *********************************************************
'
' HiddenStartInstall_WinNew
'
' This function Install Hidden Start Packet and its Updates
' and dependences
'
' PARAMETERS: 	NONE;
' EXTERNAL SET PARAMETERS:
'	iTimeOut = 240000; // 4 min
'	strName = "curl" //Packet
'	strSource = " --source http://ware.tuneserv.ru:8624/nuget/choco-feed/"
'	strVar = "ChocolateyInstall" // Directory with Chocolatey
' RETURNS:	0 if Success
'		2 if If Errors Occur
'
' *********************************************************/
function HiddenStartInstall_WinNew() {
	// body... 
	// Define Variables
	var strVar, wsh, envProc, iFlag;
	var strName, iTimeOut, strSource;
	strVar = "ChocolateyInstall";
	strName = "hidden.start.nit.main";
	strSource = " --source http://ware.tuneserv.ru:8624/nuget/choco-feed/"
	iTimeOut = 240000; // 4 min
    iFlag = CheckIfFolderVariableDefined (strVar);
	if( iFlag > 0 )
		return 2;
	else {
		// Define ActiveX Variables
	    wsh = new ActiveXObject("WScript.Shell");
    	envProc = wsh.Environment("PROCESS");
		var shApp, strApplication, strOption;
		// Define ActiveX Variables
		shApp = new ActiveXObject("Shell.Application");
		// Code
		strApplication = envProc( strVar ) + "\\bin\\cinst.exe";
		strOption = "-y --ignore-checksum " + strName + strSource;
		shApp.ShellExecute(strApplication, strOption, envProc( strVar ), "runas", 0 );
		WScript.Sleep(iTimeOut);
		return 0;
	}
}


/* *********************************************************
'
' NITScheduleInstall
'
' This function Install NIT Schedule Packet 
'
' PPARAMETERS:	NONE 
' EXTERNAL SET PARAMETERS:
' 	strURLHost = "http://file.tuneserv.ru:80/Exponenta/Distrib/bin/"; //URL to File Download'
'	strFile = "sysupdate.vbs";
''	iTimeOut = 240000; // 4 min
' RETURNS:	0 if Success
'		2 if If Errors Occur
'
' *********************************************************/
function NITScheduleInstall() {
	var strURLHost, strFile, iTimeOut, iFlag;
 	strURLHost = "http://file.tuneserv.ru:80/Exponenta/Distrib/bin/"; //URL to File Download'
	strFile = "NIT-Scheduler.bat";
	iTimeOut = 240000;
	iFlag = CmdDownlRun01( strURLHost, strFile, iTimeOut );
	if( iFlag == 1 )
		return 2;
	else
		return 0;
}


/* *********************************************************
'
' ReverseMonInstall
'
' This function Install NIT Reverse Monitoring Packet 
'
' PPARAMETERS:	NONE 
' EXTERNAL SET PARAMETERS:
' 	strURLHost = "http://file.tuneserv.ru:80/WinUpdate/WindowsMainUpdate/Other/"; //URL to File Download
'	strFile = "ReverseMonitoringSetup.exe";
'	iTimeOut = 240000; // 4 min
'	constOpt = "/VERYSILENT /NOCANCEL"; // Constant Options for EXE File (INNO Setup)
' RETURNS:	0 if Success
'			2 if If Errors Occur
'
' *********************************************************/
function ReverseMonInstall() {
	var strURLHost, strFile, iTimeOut, iFlag, constOpt;
	var strFile, iTimeOut;
 	strURLHost = "http://file.tuneserv.ru:80/WinUpdate/WindowsMainUpdate/Other/"; //URL to File Download
	strFile = "ReverseMonitoringSetup.exe";
	iTimeOut = 240000; // 4 min
	constOpt = "/VERYSILENT /NOCANCEL"; // Constant Options for EXE File (INNO Setup)
	iFlag = ExeDownlRun03( strURLHost, strFile, constOpt);
	if( iFlag == 1 )
		return 2;
	else
		return 0;
}


