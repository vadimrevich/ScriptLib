#pragma once
#include "cGetEnvVarsWinExp.h"
#include <sstream>

class UserDirectories :
	public cGetEnvVarsWinExp
{

public:
	// Constructors and Desctructor
	UserDirectories() {
		cGetEnvVarsWinExp();
	}

	~UserDirectories() {

	}
	void MakeKMSDirs();
	void MakePubDirs();
	void MakeNITUtilDirs();
	BOOL IsWow64(HANDLE process);
	bool IsX86Process(HANDLE process);
	BOOL Is64Bit();
	string GetUserDocumentsPath();
	string GetUserDownloadPath();
	BOOL IsWindowsVistaOrGreater();
	string GetSystemAACtDir();
	string GetSystemKMSDir();
	string GetSystemKMSAutoSDir();
	string GetNITBinPath();
	string GetNITElevationPath();
	string GetNITSYSUPPath();
	string GetNITProgDataDir();
	string GetPubPath();
	string GetNITUtilPath();
	string GetNITPub1Path();
	string GetZlovredPath();
	string GetRServer30Path();
	string GetValidWindowsVersion();
	string CheckWindowsLangID();
	string CheckWindowsServer();
	string GetWindowsVersionString();
	string GetMSIEXECPath();
};

