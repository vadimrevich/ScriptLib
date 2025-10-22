#pragma once
#include <string>
using namespace std;

class StartProcess
{

private:
	// Private members
	string strCmdPath;
	string strCmd32Path;
	string strCscriptPath;
	string strWPoshPath;
	string strCscript32Path;
	string strWPosh32Path;
	string strMSIExecPath;
	string strWMICPath;
	string strNotepadPath;

	// Private Method
	void SetPaths();

public:

	// Constructor and Destructor
	StartProcess() {
		SetPaths();
	}

	~StartProcess() {}

	// Public Methods

	int StartAsFile(string strFile, int iTimeOut);

	int StartAsNotepad(string strFile, int iTimeOut);

	int StartAsCmdFile(string strFile, int iTimeOut);
	int StartAsCScriptFiles(string strFile, int iTimeOut);
	int StartAsPoshFile(string strFile, int iTimeOut);
	int StartFile(string strFile, int iTimeOut);
};
