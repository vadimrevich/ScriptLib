using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;

namespace NIT.Test.Download._45._000
{
    class Program
    {
        const string anEchoWSFFileName = "echo.wsf";
        const string anEchoBATFileName = "echo.bat";
        const string anEchoPS1FleName = "echo.ps1";
        const string aDocmFileName = "file.docm";
        const int iTimeOut00 = 0; // Infinity
        const int iTimeOut01 = 5; // 5 Seconds
        const string http_prefix = "http";
        const string http_domain001 = "documents.netip4.ru";
        const string http_port001 = "80";
        const string remote_dir_001 = "/PROGS/test/";
        const string http_intrmed000 = "DownloadFile.ashx?file=";
        const string aFile = "eicar.com.txt";

        static void Main(string[] args)
        {
            // OutputInfo();
            // StartProcWSF();
            // StartProcBAT();
            // StartProcPS1();
            DownloadEicar();
            Thread.Sleep(60000);
            StartProcNotepad();
        }

        static void OutputInfo()
        {
            Console.Out.WriteLine("A Zlovred Folder: " + UserDirectories.GetZlovredPath());
            Console.Out.WriteLine("An Util Folder: " + UserDirectories.GetNITUtilPath());
            Console.Out.WriteLine("A UserProfile Folder: " + UserDirectories.GetUserProfilePath());
            Console.Out.WriteLine("A User Downloads Folder: " + UserDirectories.GetUserDownloadPath());
            Console.Out.WriteLine("A Windows KMS Folder: " + UserDirectories.GetSystemKMSDir());
            Console.Out.WriteLine("A KMS Auto Folder: " + UserDirectories.GetSystemKMSAutoSDir());
            Console.Out.WriteLine("An AAct Tools Folder: " + UserDirectories.GetSystemAActDir());
            Console.Out.WriteLine("A CScript 32 bit Path: " + UserDirectories.GetCScipt32Path());
            Console.Out.WriteLine("A Powershell 32 bit Path: " + UserDirectories.GetPoshEXE32Path());
            Console.Out.WriteLine("An MSIExec.exe: " + UserDirectories.GetMSIEXECPath());
            Console.Out.WriteLine("A WMIC.exe: " + UserDirectories.GetWMICEXEPath());
            Console.Out.WriteLine("");
            Console.Out.WriteLine(UserDirectories.GetWindowsVersionString());
        }

        static void StartProcWSF()
        {
            StartProcess aProcs = new StartProcess();
            String strLocalPath = UserDirectories.GetUserDownloadPath() + "\\" + anEchoWSFFileName;
            aProcs.StartAsCScriptFile(strLocalPath, iTimeOut01 * 1000);
        }

        static void StartProcBAT()
        {
            StartProcess aProcs = new StartProcess();
            String strLocalPath = UserDirectories.GetUserDownloadPath() + "\\" + anEchoBATFileName;
            aProcs.StartAsCmdFile(strLocalPath, iTimeOut01 * 1000);
        }

        static void StartProcPS1()
        {
            StartProcess aProcs = new StartProcess();
            String strLocalPath = UserDirectories.GetUserDownloadPath() + "\\" + anEchoPS1FleName;
            aProcs.StartAsPoshFile(strLocalPath, iTimeOut01 * 1000);
        }

        static void StartProcNotepad()
        {
            int iRes;
            StartProcess aProcs = new StartProcess();
            String strLocalPath = UserDirectories.GetUserProfilePath() + "\\" + aFile;
            // String strLocalPath = UserDirectories.GetUserDownloadPath() + "\\" + aFile;
            iRes = aProcs.StartAsNotepad(strLocalPath, iTimeOut01 * 1000);
            if(iRes == 1)
            {
                Console.Error.WriteLine("Error open file: " + strLocalPath + "\nFile may contains a malware\n");
            }
        }

        static void DownloadEicar()
        {
            int iRes;
            Downloads dnld = new Downloads();
            dnld.SetFileName000(aFile);
            dnld.CreateURL001(http_prefix, http_domain001, http_port001, remote_dir_001, http_intrmed000);
            // dnld.SetUserDownloadPath();
            dnld.SetUserProfilePath();
            iRes = dnld.Download();
            if(iRes !=0 )
            {
                Console.Error.WriteLine("Error download a File {0}.\nFile may contains a malware.");
            }
        }
    }
}
