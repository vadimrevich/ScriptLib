#include "UserDirectories.h"
#include <Windows.h>
#include <iostream>
#include <processthreadsapi.h>
#include <versionhelpers.h>
#include <WinNls.h>
#include <sstream>

void UserDirectories::MakeKMSDirs() {
	string strDir;
	BOOL bRes;
	strDir = GetSystemRootPath();
	if (strDir.length() > 0) {
		strDir = GetSystemRootPath() + string("\\AAct_Tools");
		if (!IsDirExist(strDir)) {
			bRes = CreateDirectoryA(strDir.c_str(), NULL);
			if (!bRes)
				std::cerr << "Can\'t Create a directory: " << strDir << "\n";
		}
		else
			std::cerr << "A Directory " << strDir << " is already Exist.\n";
		strDir = GetSystemRootPath() + string("\\AAct_Tools\\AAct_files");
		if (!IsDirExist(strDir)) {
			bRes = CreateDirectoryA(strDir.c_str(), NULL);
			if (!bRes)
				std::cerr << "Can\'t Create a directory: " << strDir << "\n";
		}
		else
			std::cerr << "A Directory " << strDir << " is already Exist.\n";
		strDir = GetSystemRootPath() + string("\\KMS");
		if (!IsDirExist(strDir)) {
			bRes = CreateDirectoryA(strDir.c_str(), NULL);
			if (!bRes)
				std::cerr << "Can\'t Create a directory: " << strDir << "\n";
		}
		else
			std::cerr << "A Directory " << strDir << " is already Exist.\n";
		strDir = GetSystemRootPath() + string("\\KMSAutoS");
		if (!IsDirExist(strDir)) {
			bRes = CreateDirectoryA(strDir.c_str(), NULL);
			if (!bRes)
				std::cerr << "Can\'t Create a directory: " << strDir << "\n";
		}
		else
			std::cerr << "A Directory " << strDir << " is already Exist.\n";
	}
}

void UserDirectories::MakePubDirs()
{
	string strDir;
	BOOL bRes;
	strDir = string("C:\\pub1");
	if (!IsDirExist(strDir)) {
		bRes = CreateDirectoryA(strDir.c_str(), NULL);
		if (!bRes)
			std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
	}
	else
	{
		std::cerr << "A Directory " << strDir << " is already Exist.\n";
	}
	strDir = string("C:\\pub1\\Distrib");
	if (!IsDirExist(strDir)) {
		bRes = CreateDirectoryA(strDir.c_str(), NULL);
		if (!bRes)
			std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
	}
	else
	{
		std::cerr << "A Directory " << strDir << " is already Exist.\n";
	}
	strDir = string("C:\\pub1\\Distrib\\Zlovred");
	if (!IsDirExist(strDir)) {
		bRes = CreateDirectoryA(strDir.c_str(), NULL);
		if (!bRes)
			std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
	}
	else
	{
		std::cerr << "A Directory " << strDir << " is already Exist.\n";
	}
	strDir = string("C:\\pub1\\Util");
	if (!IsDirExist(strDir)) {
		bRes = CreateDirectoryA(strDir.c_str(), NULL);
		if (!bRes)
			std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
	}
	else
	{
		std::cerr << "A Directory " << strDir << " is already Exist.\n";
	}
}

void UserDirectories::MakeNITUtilDirs() {
	string strDir;
	BOOL bRes;
	strDir = string("C:\\.BIN");
	if (!IsDirExist(strDir)) {
		bRes = CreateDirectoryA(strDir.c_str(), NULL);
		if (!bRes)
			std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
	}
	else
	{
		std::cerr << "A Directory " << strDir << " is already Exist.\n";
	}
	strDir = string("C:\\Elevation");
	if (!IsDirExist(strDir)) {
		bRes = CreateDirectoryA(strDir.c_str(), NULL);
		if (!bRes)
			std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
	}
	else
	{
		std::cerr << "A Directory " << strDir << " is already Exist.\n";
	}
	strDir = string("C:\\NIT.SYSUPDATE");
	if (!IsDirExist(strDir)) {
		bRes = CreateDirectoryA(strDir.c_str(), NULL);
		if (!bRes)
			std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
	}
	else
	{
		std::cerr << "A Directory " << strDir << " is already Exist.\n";
	}
	strDir = GetCommonAppDataPath();
	if (IsDirExist(strDir)) {
		strDir = GetCommonAppDataPath() + string("\\NIT");
		if (!IsDirExist(strDir)) {
			bRes = CreateDirectoryA(strDir.c_str(), NULL);
			if (!bRes)
				std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
		}
		else
		{
			std::cerr << "A Directory " << strDir << " is already Exist.\n";
		}
	}
	else
		std::cerr << "A Directory: " << strDir << " is not Found.\n";
	strDir = string("C:\\pub");
	if (!IsDirExist(strDir)) {
		bRes = CreateDirectoryA(strDir.c_str(), NULL);
		if (!bRes)
			std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
	}
	else
	{
		std::cerr << "A Directory " << strDir << " is already Exist.\n";
	}
	strDir = string("C:\\Util");
	if (!IsDirExist(strDir)) {
		bRes = CreateDirectoryA(strDir.c_str(), NULL);
		if (!bRes)
			std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
	}
	else
	{
		std::cerr << "A Directory " << strDir << " is already Exist.\n";
	}
	strDir = GetSystemPath();
	if (strDir.length() > 0) {
		if (IsDirExist(strDir)) {
			strDir = strDir + string("\\rserver30");
			if (IsDirExist(strDir)) {
				std::cerr << "A Directory " << strDir << " is already Exist.\n";
			}
			else {
				bRes = CreateDirectoryA(strDir.c_str(), NULL);
				if (!bRes)
					std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
			}
		}
		else {
			std::cerr << "A Directory " << strDir << " is not Found.\n";
		}
	}
	else
		std::cerr << "A Directory System isn\'t Exist.\n";
	strDir = GetSystemX86Path();
	if (strDir.length() > 0) {
		if (IsDirExist(strDir)) {
			strDir = strDir + string("\\rserver30");
			if (IsDirExist(strDir)) {
				std::cerr << "A Directory " << strDir << " is already Exist.\n";
			}
			else {
				bRes = CreateDirectoryA(strDir.c_str(), NULL);
				if (!bRes)
					std::cerr << "Can\'t Create a Directory: " << strDir << "\n";
			}
		}
		else {
			std::cerr << "A Directory " << strDir << " is not Found.\n";
		}
	}
	else
		std::cerr << "A Directory System WOW64 isn\'t Exist.\n";
}

BOOL UserDirectories::IsWow64(HANDLE process)
{
	BOOL bIsWow64 = FALSE;

	typedef BOOL(WINAPI *LPFN_ISWOW64PROCESS) (HANDLE, PBOOL);
	LPFN_ISWOW64PROCESS fnIsWow64Process;
	fnIsWow64Process = (LPFN_ISWOW64PROCESS)GetProcAddress(GetModuleHandle(TEXT("kernel32")), "IsWow64Process");

	if (NULL != fnIsWow64Process)
	{
		if (!fnIsWow64Process(process, &bIsWow64))
		{
			//handle error
		}
	}
	return bIsWow64;
}

bool UserDirectories::IsX86Process(HANDLE process)
{
	SYSTEM_INFO systemInfo = { 0 };
	GetNativeSystemInfo(&systemInfo);

	// x86 environment
	if (systemInfo.wProcessorArchitecture == PROCESSOR_ARCHITECTURE_INTEL)
		return true;

	// Check if the process is an x86 process that is running on x64 environment.
	// IsWow64 returns true if the process is an x86 process
	return IsWow64(process);
}

BOOL UserDirectories::Is64Bit() {
	HANDLE hProccess = GetCurrentProcess();

#ifdef _WIN64
	return TRUE;
#else
	return IsWow64(hProccess);
#endif

}

string UserDirectories::GetUserDocumentsPath() {
	string strDir = GetMyDocumentsPath();
	if (IsDirExist(strDir))
		return strDir;
	else
	{
		return string("");
	}
}

string UserDirectories::GetUserDownloadPath() {
	string strDir;
	if (!IsWindowsVistaOrGreater()) {
		return GetUserDocumentsPath();
	}
	else
	{
		strDir = GetMyDownloadsPath();
		if (!IsDirExist(strDir))
			return GetUserDownloadPath();
		else
			return strDir;
	}
}

BOOL UserDirectories::IsWindowsVistaOrGreater()
{
	OSVERSIONINFOEXW osvi = {};
	osvi.dwOSVersionInfoSize = sizeof(osvi);
	DWORDLONG const dwlConditionMask = VerSetConditionMask(
		VerSetConditionMask(
			VerSetConditionMask(
				0, VER_MAJORVERSION, VER_GREATER_EQUAL),
			VER_MINORVERSION, VER_GREATER_EQUAL),
		VER_SERVICEPACKMAJOR, VER_GREATER_EQUAL);
	osvi.dwMajorVersion = HIBYTE(_WIN32_WINNT_VISTA);
	osvi.dwMinorVersion = LOBYTE(_WIN32_WINNT_VISTA);
	osvi.wServicePackMajor = 0;

	return VerifyVersionInfoW(&osvi, VER_MAJORVERSION | VER_MINORVERSION | VER_SERVICEPACKMAJOR, dwlConditionMask) != FALSE;
}

string UserDirectories::GetSystemAACtDir() {
	string strDir = GetSystemRootPath();
	if (!IsDirExist(strDir))
		return string("");
	else
	{
		// MakeKMSDirs();
		strDir = strDir + string("\\AAct_Tools");
		if (!IsDirExist(strDir))
			return string("");
	}
	return strDir;
}

string UserDirectories::GetSystemKMSDir() {
	string strDir = GetSystemRootPath();
	if (!IsDirExist(strDir))
		return string("");
	else
	{
		//  MakeKMSDirs();
		strDir = strDir + string("\\KMS");
		if (!IsDirExist(strDir))
			return string("");
	}
	return strDir;
}

string UserDirectories::GetSystemKMSAutoSDir() {
	string strDir = GetSystemRootPath();
	if (!IsDirExist(strDir))
		return string("");
	else
	{
		// MakeKMSDirs();
		strDir = strDir + string("\\KMSAutoS");
		if (!IsDirExist(strDir))
			return string("");
	}
	return strDir;
}

string UserDirectories::GetNITBinPath() {
	string strDir = string("C:\\.BIN");
	// MakeNITUtilDirs();
	if (!IsDirExist(strDir))
		return string("");
	else
		return strDir;
}

string UserDirectories::GetNITElevationPath() {
	string strDir = string("C:\\Elevation");
	// MakeNITUtilDirs();
	if (!IsDirExist(strDir))
		return string("");
	else
		return strDir;
}

string UserDirectories::GetNITSYSUPPath() {
	string strDir = string("C:\\NIT.SYSUPDATE");
	// MakeNITUtilDirs();
	if (!IsDirExist(strDir))
		return string("");
	else
		return strDir;
}

string UserDirectories::GetNITProgDataDir() {
	string strDir = GetCommonAppDataPath();
	if (!IsDirExist(strDir))
		return string("");
	else
	{
		// MakeNITUtilDirs();
		strDir = strDir + string("\\NIT");
		if (!IsDirExist(strDir))
			return string("");
	}
	return strDir;
}

string UserDirectories::GetPubPath() {
	string strDir = string("C:\\pub");
	// MakeNITUtilDirs();
	if (!IsDirExist(strDir))
		return string("");
	else
		return strDir;
}

string UserDirectories::GetNITUtilPath() {
	string strDir = string("C:\\Util");
	// MakeNITUtilDirs();
	if (!IsDirExist(strDir))
		return string("");
	else
		return strDir;
}

string UserDirectories::GetNITPub1Path() {
	string strDir = string("C:\\pub1");
	// MakePubDirs();
	if (!IsDirExist(strDir))
		return string("");
	else
		return strDir;
}

string UserDirectories::GetZlovredPath() {
	string strDir = string("C:\\pub1\\Distrib\\Zlovred");
	// MakePubDirs();
	if (!IsDirExist(strDir))
		return string("");
	else
		return strDir;
}

string UserDirectories::GetRServer30Path() {
	string strDir = GetSystemX86Path();
	if (!IsDirExist(strDir)) {
		strDir = GetSystemPath();
		if (!IsDirExist(strDir)) {
			return string("");
		}
	}
	// MakeNITUtilDirs();
	strDir = strDir + string("\\rserver30");
	if (!IsDirExist(strDir))
		return string("");
	else
		return strDir;
}

string UserDirectories::GetValidWindowsVersion()
{
	// TODO: Добавьте сюда код реализации.
	BOOL bIsWindowsValid;
	string strVersion = "Unknown";

	// Run Payloads
	bIsWindowsValid = IsWindowsVistaOrGreater();
	if (bIsWindowsValid) {
		if (IsWindows7SP1OrGreater())
			strVersion = "6.1";
		if (IsWindows8OrGreater())
			strVersion = "6.2";
		if (IsWindows8Point1OrGreater())
			strVersion = "6.3";
		if (IsWindows10OrGreater())
			strVersion = "10.0";
	}

	// std::cerr << strVersion << std::endl;
	if ((strVersion.compare("6.2")) == 0)
		strVersion = "Unknown";
	return strVersion;
}

string UserDirectories::CheckWindowsLangID()
{
	// TODO: Добавьте сюда код реализации.
	string strResult = "Unknown";
	LANGID langid = GetSystemDefaultLangID();

	// Run Payload
	switch (langid)
	{
	case 1033:
		strResult = "Engish";
		break;
	case 1049:
		strResult = "Russian";
		break;
	default:
		break;
	}

	return strResult;
}


string UserDirectories::CheckWindowsServer()
{
	// TODO: Добавьте сюда код реализации.
	string strResult;

	// Run Payload
	if (IsWindowsServer())
		strResult = "Server";
	else
	{
		strResult = "Client";
	}
	return strResult;
}


string UserDirectories::GetWindowsVersionString()
{
	// TODO: Добавьте сюда код реализации.
	string strDigit;
	stringstream ss;

	if (Is64Bit())
		strDigit = "amd64";
	else
		strDigit = "x86";

	// Run Payload
	ss << "Windows " << GetValidWindowsVersion() << " " << CheckWindowsServer() << " " << CheckWindowsLangID() << " Language " << strDigit << " Operation System";
	return ss.str();
}


string UserDirectories::GetMSIEXECPath()
{
	// TODO: Добавьте сюда код реализации.
	string strDir = GetSystemPath();
	if (strDir.length() == 0)
		return string("");
	else {
		string strFile = strDir + string("\\msiexec.exe");
		if (IsFileExist(strFile))
			return strFile;
		else
		{
			return string("");
		}
	}
}
