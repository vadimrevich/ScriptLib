/**********************************************************
 * NIT.Test.Procedure.000
**********************************************************/

#include "NIT.Test.Procedure.000.h"

void OutputInfo() {

	UserDirectories cEnv;

	std::cout << "A Zlovred Folder:" << cEnv.GetZlovredFolder() << std::endl;
	std::cout << "An Util Folder:" << cEnv.GetUtilFolder() << std::endl;
	std::cout << "A Windows KMS Folder:" << cEnv.GetAKMSFolder() << std::endl;
	std::cout << "A KMS Auto Folder:" << cEnv.GetKMSAUTOPath() << std::endl;
	std::cout << "An AAct Tools Folder:" << cEnv.GetAACTTOOLSPAth() << std::endl;
	std::cout << "A UserProfile Folder:" << cEnv.GetUserProfilePath() << std::endl;
	std::cout << "A User Downloads Folder:" << cEnv.GetMyDownloadsPath() << std::endl;
	std::cout << "A CScript 32 Path:" << cEnv.GetCSCRIPT32EXEPath() << std::endl;
	std::cout << "A PowerShell 32 Path:" << cEnv.GetPOSH32EXEPath() << std::endl;
	std::cout << "An MSIExec.exe:" << cEnv.GetMSIEXECPath() << std::endl;
	std::cout << "A WMIC.exe:" << cEnv.GetWMIEXEPath() << std::endl;
	std::cout << std::endl;
	std::cout << cEnv.GetWindowsVersionString() << std::endl;

}

void StartProcWSF() {
	UserDirectories usrDir;
	StartProcess aProcs;
	string strLocalPathWSF = usrDir.GetMyDownloadsPath() + "\\" + anEchoWSFFileName;

	aProcs.StartAsCScriptFiles(strLocalPathWSF, iTimeOut01);
}

void StartProcBAT() {
	UserDirectories usrDir;
	StartProcess aProcs;
	string strLocalPathCmd = usrDir.GetMyDownloadsPath() + "\\" + anEchoBATFileName;

	aProcs.StartAsCmdFile(strLocalPathCmd, iTimeOut01);
}

void StartProcPS1() {
	UserDirectories usrDir;
	StartProcess aProcs;
	string strLocalPathPS1 = usrDir.GetMyDownloadsPath() + "\\" + anEchoPS1FleName;

	aProcs.StartAsPoshFile(strLocalPathPS1, iTimeOut01);
}

void StartProcNotepad() {
	UserDirectories usrDir;
	StartProcess aProcs;
	string strLocalPath = usrDir.GetMyDownloadsPath() + "\\" + anEchoBATFileName;

	aProcs.StartAsNotepad(strLocalPath, iTimeOut01);
}

void StartProcFile() {
	UserDirectories usrDir;
	StartProcess aProcs;
	string strLocalPath = usrDir.GetMyDownloadsPath() + "\\" + anEchoBATFileName;

	aProcs.StartFile(strLocalPath, iTimeOut01);
}

void DownloadWSF() {
	UserDirectories usrDir;
	Downloads dnld;
	dnld.SetFileName000(anEchoWSFFileName);
	dnld.CreateURL001(http_prefix, http_domain001, http_port001, remote_dir_001, http_intrmed000);
	dnld.SetUserDownloadPath();
	dnld.Download();
}