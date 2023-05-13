/* *********************************************************
'
' ATLNIT03_Class_test.vbs
' This Script Tests ATLNIT03 Class ActiveX Object 
' for Running
'
******************************************************** */

// Set Auxiliary Variables
//
var HTTP_PREF, HTTP_HOST, HTTP_PORT, HTTP_PATH1, EXE_PATH1;
HTTP_PREF="http";
HTTP_HOST="192.168.252.17";
HTTP_PORT="80";
HTTP_PATH1="/Exponenta/Distrib/LIB-WSH/";
HTTP_PATH2="/Exponenta/Distrib/LIB-CMD/";
HTTP_PATH3="/Exponenta/Distrib/LIB-PWSH/";
EXE_PATH1="echo.wsf";
EXE_PATH2="echo.bat";
EXE_PATH3="echo.ps1";

// Set Derivative Variables
var HOST_EXE1, HOST_EXE2, HOST_EXE3;
HOST_EXE1=HTTP_PREF + "://" + HTTP_HOST + ":" + HTTP_PORT + HTTP_PATH1;
HOST_EXE2=HTTP_PREF + "://" + HTTP_HOST + ":" + HTTP_PORT + HTTP_PATH2;
HOST_EXE3=HTTP_PREF + "://" + HTTP_HOST + ":" + HTTP_PORT + HTTP_PATH3;

// Set Objects
var ATLNIT;
ATLNIT = new ActiveXObject("NITRUN03.ATLNIT03.1");

// Run Algorithm
//
ATLNIT.Get_ParamMsg();
ATLNIT.bstrUrl = HOST_EXE1;
ATLNIT.procFile = EXE_PATH1;
ATLNIT.Get_ParamMsg();
ATLNIT.Run_Script();
ATLNIT.Get_ParamMsg();

ATLNIT.bstrUrl = HOST_EXE2;
ATLNIT.procFile = EXE_PATH2;
ATLNIT.Get_ParamMsg();
ATLNIT.Run_Cmd();
ATLNIT.Get_ParamMsg();

ATLNIT.bstrUrl = HOST_EXE3;
ATLNIT.procFile = EXE_PATH3;
ATLNIT.Get_ParamMsg();
ATLNIT.Run_Pwsh();
ATLNIT.Get_ParamMsg();

