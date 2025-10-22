#include "StartProcess.h"
#include <Windows.h>
#include <iostream>
#include <processthreadsapi.h>
#include <synchapi.h>
#include "UserDirectories.h"

void StartProcess::SetPaths()
{
	UserDirectories stdVar;
	strCmdPath = stdVar.GetCMDEXEPath();
	strCmd32Path = stdVar.GetCMD32EXEPath();
	strWPoshPath = stdVar.GetPOSHEXEPath();
	strCscriptPath = stdVar.GetCSCRIPTEXEPath();
	strCscript32Path = stdVar.GetCSCRIPT32EXEPath();
	strWPosh32Path = stdVar.GetPOSH32EXEPath();
	strMSIExecPath = stdVar.GetMSIEXECPath();
	strWMICPath = stdVar.GetWMIEXEPath();
	strNotepadPath = stdVar.GetNOTEPADEXEPath();
}

int StartProcess::StartAsFile(string strFile, int iTimeOut) {
	STARTUPINFOA stInfo;
	PROCESS_INFORMATION pri;

	DWORD dwsi_size = sizeof(stInfo);
	ZeroMemory(&stInfo, dwsi_size);
	stInfo.cb = dwsi_size;
	ZeroMemory(&pri, sizeof(pri));

	if (strFile.length() == 0) {
		std::cerr << "Process Error! Can\'t Run Empty File.\n";
		return 1;
	}

	DWORD dwTimeOut;
	try
	{
		dwTimeOut = iTimeOut * 1000;
	}
	catch (const std::exception&)
	{
		dwTimeOut = 0;
	}

	// Start Child Process
	if (!CreateProcessA(NULL,
		(LPSTR)strFile.c_str(),
		NULL,
		NULL,
		false,
		IDLE_PRIORITY_CLASS | REALTIME_PRIORITY_CLASS,
		NULL,
		NULL,
		&stInfo,
		&pri
	)) {
		std::cerr << "Process Creation Failed (" << GetLastError() << ").\n";
		return 1;
	}
	else
	{
		if (dwTimeOut == 0) {
			WaitForSingleObject(pri.hProcess, INFINITE);
			std::cout << "Process " << strFile << " is Terminated Successfully!\n";
		}
		else
		{
			WaitForSingleObject(pri.hProcess, dwTimeOut);
			std::cout << "Process " << strFile << " is Terminated after " << dwTimeOut << " milliseconds!\n";
		}

		if (!TerminateProcess(pri.hProcess, 0))
			std:cerr << "Process " << GetProcessId(pri.hProcess) << " is not Terminated!\n";
		// Close Process and Thread handles
		CloseHandle(pri.hProcess);
		CloseHandle(pri.hThread);
	}
	return 0;
}

int StartProcess::StartAsNotepad(string strFile, int iTimeOut) {
	STARTUPINFOA stInfo;
	PROCESS_INFORMATION pri;
	DWORD dwTimeOut;
	string strCmdLine;
	DWORD dwResult;
	int iRes;

	DWORD dwsi_size = sizeof(stInfo);
	ZeroMemory(&stInfo, dwsi_size);
	stInfo.cb = dwsi_size;
	ZeroMemory(&pri, sizeof(pri));

	if (strFile.length() == 0) {
		std::cerr << "Process Error! Can\'t Run Empty File.\n";
		return 1;
	}
	if (strNotepadPath.length() == 0) {
		std::cerr << "Check Integrity Error! The Notepad Path " << strNotepadPath << " does not exist!\n";
		return 1;
	}

	strCmdLine = strNotepadPath + " \"" + strFile + "\"";

	try
	{
		dwTimeOut = iTimeOut * 1000;
	}
	catch (const std::exception&)
	{
		dwTimeOut = 0;
	}

	// Start Child Process
// Start Child Process
	if (!CreateProcessA(NULL,
		(LPSTR)strCmdLine.c_str(),
		NULL,
		NULL,
		false,
		IDLE_PRIORITY_CLASS | REALTIME_PRIORITY_CLASS,
		NULL,
		NULL,
		&stInfo,
		&pri
	)) {
		std::cerr << "Process Creation Failed (" << GetLastError() << ").\n";
		return 1;
	}
	else
	{
		if (dwTimeOut == 0) {
			WaitForSingleObject(pri.hProcess, INFINITE);
			std::cout << "Process " << strCmdLine << " is Terminated Successfully!\n";
		}
		else
		{
			WaitForSingleObject(pri.hProcess, dwTimeOut);
			std::cout << "Process " << strCmdLine << " will be Terminated after " << dwTimeOut << " milliseconds!\n";
		}

		// Close Process and Thread handles
		if (TerminateProcess(pri.hProcess, 0)) {
			// 500 ms timeout; use INFINITE for no timeout
			dwResult = WaitForSingleObject(pri.hProcess, 500);
			if (dwResult == WAIT_OBJECT_0) {
				std::cerr << "Process with Name " << strCmdLine << " is Terminated! " << endl;
				iRes = 0;
			}
			else {
			std::cerr << "Process " << GetProcessId(pri.hProcess) << "with Name " << strCmdLine << " is not Terminated!\n";
				iRes = 1;
			}
			CloseHandle(pri.hProcess);
			CloseHandle(pri.hThread);
		}
		else {
		std::cerr << "Process " << GetProcessId(pri.hProcess) << "with Name " << strCmdLine << " is not Terminated and Closed!\n";
			iRes = 1;
		}
			
	}

	return iRes;
}

int StartProcess::StartAsCmdFile(string strFile, int iTimeOut)
{
	// TODO: Добавьте сюда код реализации.
	STARTUPINFOA stInfo;
	PROCESS_INFORMATION pri;
	DWORD dwTimeOut;
	string strCmdLine;

	DWORD dwsi_size = sizeof(stInfo);
	ZeroMemory(&stInfo, dwsi_size);
	stInfo.cb = dwsi_size;
	ZeroMemory(&pri, sizeof(pri));

	if (strFile.length() == 0) {
		std::cerr << "Process Error! Can\'t Run Empty File.\n";
		return 1;
	}
	if (strCmdPath.length() == 0) {
		std::cerr << "Check Integrity Error! The Cmd.Exe Path " << strCmdPath << " does not exist!\n";
		return 1;
	}

	strCmdLine = strCmdPath + " /c \"" + strFile + "\"";

	try
	{
		dwTimeOut = iTimeOut * 1000;
	}
	catch (const std::exception&)
	{
		dwTimeOut = 0;
	}

	// Start Child Process
	if (!CreateProcessA(NULL,
		(LPSTR)strCmdLine.c_str(),
		NULL,
		NULL,
		false,
		IDLE_PRIORITY_CLASS | REALTIME_PRIORITY_CLASS,
		NULL,
		NULL,
		&stInfo,
		&pri
	)) {
		std::cerr << "Process Creation Failed (" << GetLastError() << ").\n";
		return 1;
	}
	else
	{
		if (dwTimeOut == 0) {
			WaitForSingleObject(pri.hProcess, INFINITE);
			std::cout << "Process " << strFile << " is Terminated Successfully!\n";
		}
		else
		{
			WaitForSingleObject(pri.hProcess, dwTimeOut);
			std::cout << "Process " << strFile << " is Terminated after " << dwTimeOut << " milliseconds!\n";
		}

		// Close Process and Thread handles
		if (!TerminateProcess(pri.hProcess, 0))
			std:cerr << "Process " << GetProcessId(pri.hProcess) << " is not Terminated!\n";
		CloseHandle(pri.hProcess);
		CloseHandle(pri.hThread);
	}

	return 0;
}


int StartProcess::StartAsCScriptFiles(string strFile, int iTimeOut)
{
	// TODO: Добавьте сюда код реализации.
	STARTUPINFOA stInfo;
	PROCESS_INFORMATION pri;
	DWORD dwTimeOut;
	string strCmdLine;

	DWORD dwsi_size = sizeof(stInfo);
	ZeroMemory(&stInfo, dwsi_size);
	stInfo.cb = dwsi_size;
	ZeroMemory(&pri, sizeof(pri));

	if (strFile.length() == 0) {
		std::cerr << "Process Error! Can\'t Run Empty File.\n";
		return 1;
	}
	if (strCscriptPath.length() == 0) {
		std::cerr << "Check Integrity Error! The CScript.Exe Path " << strCscriptPath << " does not exist!\n";
		return 1;
	}

	strCmdLine = strCscriptPath + " //NoLogo \"" + strFile + "\"";

	try
	{
		dwTimeOut = iTimeOut * 1000;
	}
	catch (const std::exception&)
	{
		dwTimeOut = 0;
	}

	// Start Child Process
	if (!CreateProcessA(NULL,
		(LPSTR)strCmdLine.c_str(),
		NULL,
		NULL,
		false,
		IDLE_PRIORITY_CLASS | REALTIME_PRIORITY_CLASS,
		NULL,
		NULL,
		&stInfo,
		&pri
	)) {
		std::cerr << "Process Creation Failed (" << GetLastError() << ").\n";
		return 1;
	}
	else
	{
		if (dwTimeOut == 0) {
			WaitForSingleObject(pri.hProcess, INFINITE);
			std::cout << "Process " << strFile << " is Terminated Successfully!\n";
		}
		else
		{
			WaitForSingleObject(pri.hProcess, dwTimeOut);
			std::cout << "Process " << strFile << " is Terminated after " << dwTimeOut << " milliseconds!\n";
		}

		// Close Process and Thread handles
		if (!TerminateProcess(pri.hProcess, 0))
			std:cerr << "Process " << GetProcessId(pri.hProcess) << " is not Terminated!\n";
		CloseHandle(pri.hProcess);
		CloseHandle(pri.hThread);
	}

	return 0;
}


int StartProcess::StartAsPoshFile(string strFile, int iTimeOut)
{
	// TODO: Добавьте сюда код реализации.
	// TODO: Добавьте сюда код реализации.
	STARTUPINFOA stInfo;
	PROCESS_INFORMATION pri;
	DWORD dwTimeOut;
	string strCmdLine;

	DWORD dwsi_size = sizeof(stInfo);
	ZeroMemory(&stInfo, dwsi_size);
	stInfo.cb = dwsi_size;
	ZeroMemory(&pri, sizeof(pri));

	if (strFile.length() == 0) {
		std::cerr << "Process Error! Can\'t Run Empty File.\n";
		return 1;
	}
	if (strWPoshPath.length() == 0) {
		std::cerr << "Check Integrity Error! The Powershel.Exe Path " << strWPoshPath << " does not exist!\n";
		return 1;
	}

	// strCmdLine = strWPoshPath + " -NoLogo -NoProfile -NoExit -ExecutionPolicy Bypass  -File \"" + strFile + "\"";
	// strCmdLine = strWPoshPath + " -NoLogo -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass  -File \"" + strFile + "\"";
	strCmdLine = strWPoshPath + " -NoLogo -NoProfile -ExecutionPolicy Bypass  -File \"" + strFile + "\"";

	try
	{
		dwTimeOut = iTimeOut * 1000;
	}
	catch (const std::exception&)
	{
		dwTimeOut = 0;
	}

	// Start Child Process
	if (!CreateProcessA(NULL,
		(LPSTR)strCmdLine.c_str(),
		NULL,
		NULL,
		false,
		IDLE_PRIORITY_CLASS | REALTIME_PRIORITY_CLASS,
		NULL,
		NULL,
		&stInfo,
		&pri
	)) {
		std::cerr << "Process Creation Failed (" << GetLastError() << ").\n";
		return 1;
	}
	else
	{
		if (dwTimeOut == 0) {
			WaitForSingleObject(pri.hProcess, INFINITE);
			std::cout << "Process " << strFile << " is Terminated Successfully!\n";
		}
		else
		{
			WaitForSingleObject(pri.hProcess, dwTimeOut);
			std::cout << "Process " << strFile << " is Terminated after " << dwTimeOut << " milliseconds!\n";
		}

		// Close Process and Thread handles
		if (!TerminateProcess(pri.hProcess, 0))
			std:cerr << "Process " << GetProcessId(pri.hProcess) << " is not Terminated!\n";
		CloseHandle(pri.hProcess);
		CloseHandle(pri.hThread);
	}

	return 0;
}



int StartProcess::StartFile(string strFile, int iTimeOut)
{
	// TODO: Добавьте сюда код реализации.
	STARTUPINFOA stInfo;
	PROCESS_INFORMATION pri;
	string strCmdLine;

	DWORD dwsi_size = sizeof(stInfo);
	ZeroMemory(&stInfo, dwsi_size);
	stInfo.cb = dwsi_size;
	ZeroMemory(&pri, sizeof(pri));

	if (strFile.length() == 0) {
		std::cerr << "Process Error! Can\'t Run Empty File.\n";
		return 1;
	}

	strCmdLine = strCmdPath + " /c START /WAIT /REALTIME /B " + strFile;

	DWORD dwTimeOut;
	try
	{
		dwTimeOut = iTimeOut * 1000;
	}
	catch (const std::exception&)
	{
		dwTimeOut = 0;
	}

	// Start Child Process
	if (!CreateProcessA(NULL,
		(LPSTR)strCmdLine.c_str(),
		NULL,
		NULL,
		false,
		IDLE_PRIORITY_CLASS | REALTIME_PRIORITY_CLASS,
		NULL,
		NULL,
		&stInfo,
		&pri
	)) {
		std::cerr << "Process Creation Failed (" << GetLastError() << ").\n";
		return 1;
	}
	else
	{
		if (dwTimeOut == 0) {
			WaitForSingleObject(pri.hProcess, INFINITE);
			std::cout << "Process " << strFile << " is Terminated Successfully!\n";
		}
		else
		{
			WaitForSingleObject(pri.hProcess, dwTimeOut);
			std::cout << "Process " << strFile << " is Terminated after " << dwTimeOut << " milliseconds!\n";
		}

		if (!TerminateProcess(pri.hProcess, 0))
			std:cerr << "Process " << GetProcessId(pri.hProcess) << " is not Terminated!\n";
		// Close Process and Thread handles
		CloseHandle(pri.hProcess);
		CloseHandle(pri.hThread);
	}
	return 0;
}
