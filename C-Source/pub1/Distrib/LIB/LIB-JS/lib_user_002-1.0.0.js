/******************************************************************************
' Predefined varants
******************************************************************************/
var STR_DISK = "C:";
var STR_FOLDER1 = "pub1";
var STR_FOLDER2 = "LIB-JS";
var FILE_01 = "echo.wsf";

var HTTP_PREFIX = "http://" //'Prefix of Site Downloaded From'
var HTTP_HOST = "file.tuneserv.ru" //'Host Name or IP address of the Site'
var HTTP_PORT = ":80" //'Port of the Site'
var HTTP_EXPON_PATH1 = "/Exponenta/" //'Path to Exponenta of the Site'
var HTTP_EXPON_PATH2 = HTTP_EXPON_PATH1 + "Distrib/" + STR_FOLDER2 + "/" //'Path to JScript Libraries of the Site'
/*****************************************************************************/

/******************************************************************************
'
' SUBROUTINE testDownloadedAndInstallLIB
'
' This Subroutine Downloads NIT JScript on Computer at Test Mode
' The Subroutine Uses Predefined varants
'
' PARAMETERS:   NONE
' RETURNS:      NONE
'
******************************************************************************/
function testDownloadedAndInstallLIB(){
	var Url;         //'Full URL Neme of the File in the Site
    var local_Path;  //'Local Path to Command File with Drive Letter
    local_Path = STR_DISK + "\\" + STR_FOLDER1 + "\\" + STR_FOLDER2;
    Url = HTTP_PREFIX + HTTP_HOST + HTTP_PORT + HTTP_EXPON_PATH2;

    CreatedCascade( STR_DISK, STR_FOLDER1, STR_FOLDER2 );
    UploadedFilesFromInt( FILE_01, Url, local_Path );
    testRunDownloadedScript( local_Path, FILE_01, 20000 );
}
