/***
 *
 * shell_env.txt
 * A Header File with Shell Environment Constants to
 * Manipulate in Scripts
 *
 **/

// Admin-Pack Variables
var SHF_AdminT = "Admin_T";
var SHF_CHOCINST = "ChocolateyInstall";
var SHE_CCHOCLPUpdate = "ChocolateyLastPathUpdate";
var SHF_CHOCPATH = "ChocolateyPath";
var SHF_CHOCTOOL = "ChocolateyToolsLocation";
var SHF_Elevation = "ELEVATION";
var SHF_PUB1 = "PUB1";
var SHF_Util = "Util";
var SHF_Scripts = "Scripts";
var SHF_UPERL = "USERPERLMODULE";

//Package Variadle
var SHF_ANDNDK= "ANDROID_NDK_ROOT";
var SHF_ANDHOME = "ANDROID_HOME";
var SHE_asl = "asl.log";
var SHF_CLINK = "CLINK_DIR";
var SHF_TCMDPATH = "COMMANDER_PATH";
var SHF_JavaHome = "JAVA_HOME";
var SHF_M2HOME = "M2_HOME";
var SHF_MAKEMSI_DIR = "MAKEMSI_DIR";
var SHF_MSIVAL2_DIR = "MAKEMSI_MSIVAL2_DIR";
var SHF_MEPATH = "MEPATH";
var SHF_PSModPath = "PSModulePath";

// System Variable
var SHF_AllUser ="ALLUSERSPROFILE";
var SHF_APPDATA = "APPDATA";
var SHF_ComProgF = "CommonProgramFiles";
var SHF_ComProgFx86 = "CommonProgramFiles(x86)";
var SHF_ComProgFW6432 = "CommonProgramW6432"; //Same as "CommonProgramFiles"; in 64-bit
var SHE_CompName = "COMPUTERNAME";
var SHE_ComSpec = "ComSpec";
var SHF_DriverD ="DriverData";
var SHE_HomeDrive = "HOMEDRIVE";
var SHE_HomePath = "HOMEPATH";
var SHF_LOCAPPDATA = "LOCALAPPDATA";
var SHE_LogonServ = "LOGONSERVER";
var SHE_PROCNUM = "NUMBER_OF_PROCESSORS";
var SHF_OneDriveC = "OneDriveConsumer";
var SHE_OS = "Windows_NT";
var SHE_PATH = "Path";
var SHE_PathExy = "PATHEXT";
var SHE_PROCARCH = "PROCESSOR_ARCHITECTURE";
var SHE_PROCIND = "PROCESSOR_IDENTIFIER";
var SHE_PROCLEVEL = "PROCESSOR_LEVEL";
var SHE_PROCREV = "PROCESSOR_REVISION";
var SHF_ProgData = "ProgramData";
var SHF_ProgFiles = "ProgramFiles";
var SHF_ProrFx86 = "ProgramFiles(x86)";
var SHF_ProgFW6432 = "ProgramW6432";
var SHE_PROMPT = "PROMPT";
var SHF_PUBLIC = "PUBLIC";
var SHE_SysDrive = "SystemDrive";
var SHF_SysRoot = "SystemRoot";
var SHF_TEMP = "TEMP";
var SHF_TMP = "TMP";
var SHE_UDOMAIN = "USERDOMAIN";
var SHE_UDOMAIN_ROAM = "USERDOMAIN_ROAMINGPROFILE";
var SHE_UNAME = "USERNAME";
var SHF_UPROFILE = "USERPROFILE";
var SHF_WINDIR = "windir";

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

testEnvProcExists( "TMMP" );
testEnvProcExists( SHF_TEMP );
testEnvProcExists( SHF_SysRoot );
testEnvProcExists( SHE_ComSpec );
