/* *********************************************************
'
' Functions and Variables for Test lib_func Files
'
'* ********************************************************/

// Define Global Path Variables
var strPathBAT, strPathPwsh, strPathWSF, strFileBAT, strFileExe, strFilePwsh, strFileWSF, strPathExe;
var iTimeOut;

iTimeOut = 5000;

strPathPwsh = "C:\\pub1\\Distrib\\LIB\\LIB-PWSH";
strPathBAT = "C:\\pub1\\Distrib\\LIB\\BAT";
strPathWSF = "C:\\pub1\\Distrib\\LIB\\LIB-WSF";
strPathExe = "C:\\pub1\\Distrib\\Lib\\Exe";

strFilePwsh = "echo.ps1";
strFileBAT = "echo.bat"
strFileExe = "HelloWorld01.exe";
strFileWSF = "echo.wsf";


function testRunDownloadedScript( strPath, strFile )
{
	var iFlag;
	iFlag = RunDownloadedScript( strPath, strFile, iTimeOut );
	if (iFlag == 0) {
		WScript.Echo("Success Execute " + strFile );
	} 
	else{
		WScript.Echo("Execution Error!\nPath =\t" + strPath + "\nFile =\t" + strFile );
	};
}

function testRunDownloadedCmd( strPath, strFile )
{
	var iFlag;
	iFlag = RunDownloadedCmd( strPath, strFile, iTimeOut );
	if (iFlag == 0) {
		WScript.Echo("Success Execute " + strFile );
	} 
	else{
		WScript.Echo("Execution Error!\nPath =\t" + strPath + "\nFile =\t" + strFile );
	};
}

function testRunDownloadedExe( strPath, strFile )
{
	var iFlag;
	iFlag = RunDownloadedExe( strPath, strFile, iTimeOut );
	if (iFlag == 0) {
		WScript.Echo("Success Execute " + strFile );
	} 
	else{
		WScript.Echo("Execution Error!\nPath =\t" + strPath + "\nFile =\t" + strFile );
	};
}

function testRunDownloadedPwsh( strPath, strFile )
{
	var iFlag;
	iFlag = RunDownloadedPwsh( strPath, strFile, iTimeOut );
	if (iFlag == 0) {
		WScript.Echo("Success Execute " + strFile );
	} 
	else{
		WScript.Echo("Execution Error!\nPath =\t" + strPath + "\nFile =\t" + strFile );
	};
}