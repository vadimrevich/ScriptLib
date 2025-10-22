#pragma once
#include "UserDirectories.h"
#include"StartProcess.h"
#include "Downloads.h"
#include <iostream>
#include <string>

using namespace std;

/**********************************************************
 * NIT.Test.Procedure.000.h
 * AHeder File for Auxiliaty Test Constants, Functions
 * and Procedures.
**********************************************************/

// Global Constants

const string anEchoWSFFileName = "echo.wsf";
const string anEchoBATFileName = "echo.bat";
const string anEchoPS1FleName = "echo.ps1";
const string aDocmFileName = "file.docm";
const int iTimeOut00 = 0; // Infinity
const int iTimeOut01 = 5; // 5 Seconds
const string http_prefix = string("http");
const string http_domain001 = string("localhost");
const string http_port001 = string("80");
const string remote_dir_001 = string("/echos/");
const string http_intrmed000 = string("DownloadFile.ashx?file=");
const string aFile = string("eicar.com");


// Functions

void OutputInfo();
void StartProcWSF();
void StartProcBAT();
void StartProcPS1();
void StartProcNotepad();
void StartProcFile();
void DownloadWSF();
