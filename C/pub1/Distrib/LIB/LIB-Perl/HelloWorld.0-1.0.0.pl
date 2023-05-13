#!C:\Strawberry\perl\bin\perl.exe
#
#***********************************************************
# *
# * Copyleft (L) New Internet Technologies Inc. 2021
# *
# * E-mail: vadimrevich21@gmail.com
# *
# * Perl Script Templatew for NIT Devlopers
# *
# * Locate: "C:\pub1\Distrib\LIB\LIB-Perl\wintemplate-1.0.0.pl"
# *
#************************************************************/
#

## Path to Custom Library Stores at Configuration Variable

### For Yudenisov Developers
#unshift (@INC, "C:/Perl/user/Perllib");
### For NIT Developers
unshift (@INC, "C:/pub1/Distrib/LIB/LIB-Perl");

## Store Library Files
require "winlib.func-1.0.0.pl"; # Библиотека для Загрузки и выполнения файлов
#require "htmlpr_main.pl";  # библиотека генерации HTML-файлов
# require "htmlpr_sec.pl";   # библиотека замены в HTML-файлах
#

#***********************************************************
# 
# HelloWorld-1.0.0.pl
# This Script simple Prints HelloWorld Text
#
# PARAMETERS:	NONE
#
# RETURN:	NONE
#
#***********************************************************

#### Create locale Variables
my $strPath;
my $strWSHCmd;
my $strBATCmd;

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
$strPath = "C:\\pub1\\Distrib\\LIB\\LIB-WSF";
$strWSHCmd ="echo.wsf";
print $strWSHCmd."\n\n";
&RunDownloadWSH( $strPath, $strWSHCmd );

#### RunDownloadExe Test
$strPath = "C:\\pub1\\Distrib\\LIB\\Exe";
$strWSHCmd = "HelloWorld01.exe";
print $strWSHCmd."\n\n";
&RunDownloadExe( $strPath, $strWSHCmd );

#### RunDownloadBAT Test
$strPath = "C:\\pub1\\Distrib\\LIB\\BAT";
$strWSHCmd ="echo.bat";
print $strWSHCmd."\n\n";
&RunDownloadBAT( $strPath, $strWSHCmd );

#### RunDownloPwsh Test
$strPath = "C:\\pub1\\Distrib\\LIB\\LIB-PWSH";
$strWSHCmd ="echo.ps1";
print $strWSHCmd."\n\n";
&RunDownloadedPwsh( $strPath, $strWSHCmd );

