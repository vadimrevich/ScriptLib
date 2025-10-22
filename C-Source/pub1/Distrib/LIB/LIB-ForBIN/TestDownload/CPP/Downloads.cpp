#include "Downloads.h"
//#define _AFXDLL
#define no_init_all deprecated
#include <Windows.h>
#include <iostream>
//#include <urlmon.h>
#include <wininet.h>
// #include <afx.h>
//#include <afxinet.h>
#include "UserDirectories.h"
#pragma comment(lib,"wininet")
//#pragma comment(lib, "urlmon.lib")

#define RECVPACK_SIZE 2048
#define MAXBLOCKSIZE 1024

void Downloads::SetClassMembers()
{
	UserDirectories stdVar;
	anURL = string("");
	aLocalPath = string("");
	aFileName = string("");
}

string Downloads::GetLocalPath() {
	return aLocalPath;
}

void Downloads::SetUserDownloadPath() {
	UserDirectories stdVar;
	string strRes = stdVar.GetMyDownloadsPath();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetUserDocumentsPath() {
	UserDirectories stdVar;
	string strRes = stdVar.GetUserDocumentsPath();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetUserProfilePath() {
	UserDirectories stdVar;
	string strRes = stdVar.GetUserProfilePath();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetSystemAActDir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetSystemAACtDir();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetSystemKMSDir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetSystemKMSDir();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetSystemKMSAutoSDir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetSystemKMSAutoSDir();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetNITBinDir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetNITBinPath();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetNITElevationDir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetNITElevationPath();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetNITSysUpDir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetNITSYSUPPath();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetNITProgDataDir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetNITProgDataDir();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetNITPubDir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetPubPath();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetNITPub1Dir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetNITPub1Path();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetZlovredDir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetZlovredPath();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetNITUtilDir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetNITUtilPath();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetRServer30Dir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetRServer30Path();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::SetUserDesktopDir()
{
	UserDirectories stdVar;
	string strRes = stdVar.GetMyDesktopPath();
	if (strRes.length() > 0 && aFileName.length() > 0) {
		aLocalPath = strRes + "\\" + aFileName;
	}
	else
		aLocalPath = string("");
}

void Downloads::Download() {
	UserDirectories stdVar;
	BOOL bRes;

	if (stdVar.IsFileExist(aLocalPath)) {
		try
		{
			bRes = DeleteFileA(aLocalPath.c_str());
		}
		catch (const std::exception&)
		{
			std::cerr << "Can\'t Delete a File " << aLocalPath << "\n";
			aLocalPath = string("");
			return;
		}
	}

	try
	{
		// hResult = URLDownloadToFileA(NULL, anURL.c_str(), aLocalPath.c_str(), 0, NULL);
		Download_WinInet(anURL.c_str(), aLocalPath.c_str());
	}
	catch (const std::exception&)
	{
		std::cerr << "Can\'t to Download a File " << aLocalPath << " from an URL " << anURL << "\n";
		aLocalPath = string("");
		return;
	}
	std::cout << "Success Downloads File: " << aLocalPath << "\n";
}

void Download_WinInet(const char *Url, const char *filename){
byte Temp[MAXBLOCKSIZE];
ULONG Number = 1;

FILE *stream;
HINTERNET hSession = InternetOpenA("RookIE/1.0", INTERNET_OPEN_TYPE_PRECONFIG, NULL, NULL, 0);
if (hSession != NULL)
{
	HINTERNET handle2 = InternetOpenUrlA(hSession, Url, NULL, 0, INTERNET_FLAG_DONT_CACHE, 0);
	if (handle2 != NULL)
	{


		if ( fopen_s( &stream, filename, "wb") == 0)
		{
			while (Number > 0)
			{
				InternetReadFile(handle2, Temp, MAXBLOCKSIZE - 1, &Number);

				fwrite(Temp, sizeof(char), Number, stream);
			}
			fclose(stream);
		}

		InternetCloseHandle(handle2);
		handle2 = NULL;
	}
	InternetCloseHandle(hSession);
	hSession = NULL;
}
}

/***
bool DownloadSaveFiles(char* url, char *strSaveFile) {//Download the file and save it as a new file name
	bool ret = false;
	CInternetSession Sess("lpload");
	Sess.SetOption(INTERNET_OPTION_CONNECT_TIMEOUT, 2000); //2 seconds connection timeout
	Sess.SetOption(INTERNET_OPTION_SEND_TIMEOUT, 2000); //2 second sending timeout
	Sess.SetOption(INTERNET_OPTION_RECEIVE_TIMEOUT, 2000); //2 seconds of receiving timeout
	Sess.SetOption(INTERNET_OPTION_DATA_SEND_TIMEOUT, 2000); //2 second sending timeout
	Sess.SetOption(INTERNET_OPTION_DATA_RECEIVE_TIMEOUT, 2000); //2 seconds of receiving timeout
	DWORD dwFlag = INTERNET_FLAG_TRANSFER_BINARY | INTERNET_FLAG_DONT_CACHE | INTERNET_FLAG_RELOAD;

	CHttpFile* cFile = NULL;
	char      *pBuf = NULL;
	int        nBufLen = 0;
	do {
		try {
			cFile = (CHttpFile*)Sess.OpenURL( (LPCTSTR)url, 1, dwFlag);
			DWORD dwStatusCode;
			cFile->QueryInfoStatusCode(dwStatusCode);
			if (dwStatusCode == HTTP_STATUS_OK) {
				//Query file length
				DWORD nLen = 0;
				cFile->QueryInfo(HTTP_QUERY_CONTENT_LENGTH, nLen);
				//CString strFilename = GetFileName(url,TRUE);
				nBufLen = nLen;
				if (nLen <= 0) break;//

								 //Allocate receiving data buffer
				pBuf = (char*)malloc(nLen + 8);
				ZeroMemory(pBuf, nLen + 8);

				char *p = pBuf;
				while (nLen > 0) {
					//Each download 8K
					int n = cFile->Read(p, (nLen < RECVPACK_SIZE) ? nLen : RECVPACK_SIZE);
					//Receive completion and exit the loop
					if (n <= 0) break;//
										 //Receive buffer move backward
					p += n;
					//The remaining length decreases
					nLen -= n;
				}

				//If the interrupt is not received, exit
				if (nLen != 0) break;

				//Successfully received and saved to file

				CFile file( (LPCSTR)strSaveFile, CFile::modeCreate | CFile::modeWrite);
				file.Write(pBuf, nBufLen);
				file.Close();
				ret = true;
			}
		}
		catch (...) {
			break;//
		}
	} while (0);

	//Release the cache
	if (pBuf) {
		free(pBuf);
		pBuf = NULL;
		nBufLen = 0;
	}

	//Close the download connection
	if (cFile) {
		cFile->Close();
		Sess.Close();
		delete cFile;
	}
	return ret;
}
**/

void Downloads::CreateURL000(string prefix, string domain, string port, string path)
{
	// TODO: Добавьте сюда код реализации.
	if (aFileName.length() > 0)
		anURL = prefix + "://" + domain + ":" + port + path + aFileName;
	else
		anURL = string("");
}


void Downloads::CreateURL001(string prefix, string domain, string port, string path, string intermediate)
{
	// TODO: Добавьте сюда код реализации.
	if (aFileName.length() > 0)
		anURL = prefix + "://" + domain + ":" + port + path + intermediate + aFileName;
	else
		anURL = string("");
}

void Downloads::SetFileName000(string strFileName)
{
	// TODO: Добавьте сюда код реализации.
	aFileName = strFileName;
}
