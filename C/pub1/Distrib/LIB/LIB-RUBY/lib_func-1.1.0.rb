#!ruby.exe
###
# LIB_FUNC.RB
# This file contain main modules for Payloads Delivery
#
# Revision 1.1.0.0 (Extended Beta) May be Present
# The Library Links at lib_func-1.0.0.js
# 
# Version 1.1.1.0 (Extended Beta) Build 0001
#
###

require 'tmpdir'
require 'win32/registry'
require 'open-uri'


###
# getTempEnviron()
#
# This Function Returns the Path for ZLOVRED Directory or Path for User Variable TEMP
#
# PARAMETERS:   NONE
# RETURNS:      Path for Zlovred Directory if Exists or
#               Path for User Variable %TEMP% if Success or
#		        "" if General System Error
###

def getTempEnviron()
    path1 = "c:\\pub1\\Distrib\\Zlovred"
    path2 = Dir::tmpdir()
    if File.directory?(path1) then
        return path1
    else
        if File.directory?(path2) then
            return path2
        else
            return ""
        end
    end
end

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

def uploadFilesFromInt( strFile, strURL, strPath )
    strFileURL = strURL + strFile
    strLocal_Path = strPath + "\\" + strFile
    intUploadFilesFromInt = 0
    blnExistRemoteFile = true
    if File.directory?(strPath)
        intUploadFilesFromInt = 0
    else
        intUploadFilesFromInt = 1
        puts "\nWrong Path: " + strPath
    end
    aUserAgentHeader = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36'
    begin
        fstream = URI.open(strFileURL,"User-Agent" => aUserAgentHeader)
    rescue => error
        puts "\Error at URL: " + strFileURL + "\n#{error.message}"
        return 3
    end
    if intUploadFilesFromInt == 1 then
        blnExistRemoteFile = false
    end
    if blnExistRemoteFile then
        if !File.directory?(strPath) && !File.writable?(strPath) then
            puts "\nCan\'t write to Path: " + strPath
            return 1
        end
        begin
            IO.copy_stream(fstream, strLocal_Path)
        rescue => exception
            puts "\nCan\'t create a File: " + strLocal_Path +" in the Path: " + strPath
            puts "\n#{exception.message}"
            return 1
        end
    end
    return intUploadFilesFromInt
end

### Tests

def HackerLoad()
#    aFolder = Dir.pwd()
#    aFolder = "A:"
#    aFolder = __dir__
    aFolder = getTempEnviron()
    anURL = "http://localhost/"
    aFile = "echo.bat"
    puts "\niFlag=" + uploadFilesFromInt( aFile, anURL, aFolder).to_s
end
    
HackerLoad()

puts "Tempdir = " + getTempEnviron()
