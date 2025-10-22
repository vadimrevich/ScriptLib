using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NIT.Test.Download._45._000
{
    public class StartProcess
    {
        // Set a Private Members
        private String strCmdPath;
        private String strCmd32Path;
        private String strCScriptPath;
        private String strWScriptPath;
        private String strWPoshPath;
        private String strCScript32Path;
        private String strWPosh32Path;
        private String strMSIExecPath;
        private String strWMICPath;
        private String strNotepadPath;

        // Private Methods
        private void SetPaths()
        {
            strCmdPath = UserDirectories.GetPathCmd() + "\\cmd.exe";
            if(!File.Exists(strCmdPath))
            {
                Console.Error.WriteLine("Check Integrity Error. The File {0} is not found.", strCmdPath);
                strCmdPath = String.Empty;
            }
            strCmd32Path = UserDirectories.GetPathWOWCmd() + "\\cmd.exe";
            if (!File.Exists(strCmd32Path))
            {
                if(UserDirectories.Is64Bit())
                    Console.Error.WriteLine("Check Integrity Error. The File {0} is not found.", strCmd32Path);
                strCmd32Path = String.Empty;
            }
            strCScriptPath = UserDirectories.GetPathCmd() + "\\cscript.exe";
            if (!File.Exists(strCScriptPath))
            {
                Console.Error.WriteLine("Check Integrity Error. The File {0} is not found.", strCScriptPath);
                strCScriptPath = String.Empty;
            }
            strWScriptPath = UserDirectories.GetPathCmd() + "\\wscript.exe";
            if (!File.Exists(strWScriptPath))
            {
                Console.Error.WriteLine("Check Integrity Error. The File {0} is not found.", strWScriptPath);
                strWScriptPath = String.Empty;
            }
            strWPoshPath = UserDirectories.GetPathCmd() + "\\WindowsPowerShell\\v1.0\\powershell.exe";
            if (!File.Exists(strWPoshPath))
            {
                Console.Error.WriteLine("Check Integrity Error. The File {0} is not found.", strWPoshPath);
                strWPoshPath = String.Empty;
            }
            strCScript32Path = UserDirectories.GetCScipt32Path();
            if (!File.Exists(strCScript32Path))
            {
                Console.Error.WriteLine("Check Integrity Error. The File CScript 32 {0} is not found.", strCScript32Path);
                strCScript32Path = String.Empty;
            }
            strWPosh32Path = UserDirectories.GetPoshEXE32Path();
            if (!File.Exists(strWPosh32Path))
            {
                Console.Error.WriteLine("Check Integrity Error. The File PowerSghell 32 {0} is not found.", strWPosh32Path);
                strWPosh32Path = String.Empty;
            }
            strMSIExecPath = UserDirectories.GetMSIEXECPath();
            if (!File.Exists(strMSIExecPath))
            {
                Console.Error.WriteLine("Check Integrity Error. The File MSIExec 32 {0} is not found.", strMSIExecPath);
                strMSIExecPath = String.Empty;
            }
            strWMICPath = UserDirectories.GetWMICEXEPath();
            if (!File.Exists(strWMICPath))
            {
                Console.Error.WriteLine("Check Integrity Error. The File WMIC 32 {0} is not found.", strWMICPath);
                strWMICPath = String.Empty;
            }

            strNotepadPath = UserDirectories.GetSystemRootPath() + "\\notepad.exe";
            if (!File.Exists(strNotepadPath))
            {
                Console.Error.WriteLine("Check Integrity Error. The File {0} is not found.", strNotepadPath);
                strNotepadPath = String.Empty;
            }
        }

        // Constructor

        public StartProcess()
        {
            SetPaths();
        }

        // Public Methods

        public int StartAsFile(String strFile, int iTimeOut)
        {
            if (strFile.Length == 0)
            {
                Console.Error.WriteLine("Process Error! Can\'t Run Empty File.");
                return 1;
            }
            if (!File.Exists(strFile))
            {
                Console.Error.WriteLine("Error open file: {0}.\nFile may contains a malware or does not exist.\n", strFile);
                return 1;
            }
            ProcessStartInfo pri = new ProcessStartInfo();
            Process firstProc = new Process();
            pri.FileName = strFile;
            firstProc.EnableRaisingEvents = true;
            firstProc.StartInfo = pri;

            try
            {
                firstProc.Start();
                if (iTimeOut <= 0)
                {
                    firstProc.WaitForExit();
                    Console.Out.WriteLine("Process {0} is terminated Successfully!");
                    return 0;
                }
                else
                {
                    if (!firstProc.WaitForExit(iTimeOut))
                    {
                        firstProc.Kill();
                    }
                    Console.Out.WriteLine("Process {0} is terminated after {1} milliseconds.", strFile, iTimeOut);
                    return 0;
                }
            }
            catch (Exception e)
            {
                Console.Error.WriteLine("Process Error. Can\'t Run a File {0}.\n{1}", strFile, e.Message);
                return 2;
            }
        }

        public int StartAsNotepad(String strFile, int iTimeOut)
        {
            if (strFile.Length == 0)
            {
                Console.Error.WriteLine("Process Error! Can\'t Run Empty File.");
                return 1;
            }
            if (!File.Exists(strFile))
            {
                Console.Error.WriteLine("Error open file: {0}.\nFile may contains a malware or does not exist.\n", strFile);
                return 1;
            }
            if (strNotepadPath.Length == 0)
            {
                Console.Error.WriteLine("Check Integrity Error! The Notepad Path {0} does not Exists!", strNotepadPath);
                return 1;
            }
            ProcessStartInfo pri = new ProcessStartInfo();
            Process firstProc = new Process();
            pri.FileName = strNotepadPath;
            pri.Arguments = strFile;
            pri.RedirectStandardOutput = false;
            pri.UseShellExecute = true;
            pri.CreateNoWindow = false;
            firstProc.EnableRaisingEvents = true;
            firstProc.StartInfo = pri;

            try
            {
                firstProc.Start();
                if (iTimeOut <= 0)
                {
                    firstProc.WaitForExit();
                    Console.Out.WriteLine("Process {0} is terminated Successfully!");
                    return 0;
                }
                else
                {
                    if (!firstProc.WaitForExit(iTimeOut))
                    {
                        firstProc.Kill();
                    }
                    Console.Out.WriteLine("Process {0} is terminated after {1} milliseconds.", strFile, iTimeOut);
                    return 0;
                }
            }
            catch (Exception e)
            {
                Console.Error.WriteLine("Process Error. Can\'t Run a File {0}.\n{1}", strFile, e.Message);
                return 2;
            }
        }

        public int StartAsCmdFile(String strFile, int iTimeOut)
        {
            String strArgs;
            // Console.Out.WriteLine("File {0}", strFile);
            if (strFile.Length == 0)
            {
                Console.Error.WriteLine("Process Error! Can\'t Run Empty File.");
                return 1;
            }
            if(!File.Exists(strFile))
            {
                Console.Error.WriteLine("Error open file: {0}.\nFile may contains a malware or does not exist.\n", strFile);
                return 1;
            }
            if (strCmdPath.Length == 0)
            {
                Console.Error.WriteLine("Check Integrity Error! The Cmd Path {0} does not Exists!", strCmdPath);
                return 1;
            }
            ProcessStartInfo pri = new ProcessStartInfo();
            Process firstProc = new Process();
            pri.FileName = strCmdPath;
            strArgs = " /c \"" + strFile + "\"";
            pri.Arguments = strArgs;
            pri.RedirectStandardOutput = false;
            pri.UseShellExecute = true;
            pri.CreateNoWindow = false;
            firstProc.EnableRaisingEvents = true;
            firstProc.StartInfo = pri;

            try
            {
                firstProc.Start();
                if (iTimeOut <= 0)
                {
                    firstProc.WaitForExit();
                    Console.Out.WriteLine("Process {0} is terminated Successfully!");
                    return 0;
                }
                else
                {
                    if (!firstProc.WaitForExit(iTimeOut))
                    {
                        firstProc.Kill();
                    }
                    Console.Out.WriteLine("Process {0} is terminated after {1} milliseconds.", strFile, iTimeOut);
                    return 0;
                }
            }
            catch (Exception e)
            {
                Console.Error.WriteLine("Process Error. Can\'t Run a File {0}.\n{1}", strFile, e.Message);
                return 2;
            }
        }

        public int StartAsPoshFile(String strFile, int iTimeOut)
        {
            String strArgs;
            if (strFile.Length == 0)
            {
                Console.Error.WriteLine("Process Error! Can\'t Run Empty File.");
                return 1;
            }
            if (!File.Exists(strFile))
            {
                Console.Error.WriteLine("Error open file: {0}.\nFile may contains a malware or does not exist.\n", strFile);
                return 1;
            }
            if (strWPoshPath.Length == 0)
            {
                Console.Error.WriteLine("Check Integrity Error! The Powershell Path {0} does not Exists!", strWPoshPath);
                return 1;
            }
            ProcessStartInfo pri = new ProcessStartInfo();
            Process firstProc = new Process();
            pri.FileName = strWPoshPath;
            strArgs = " -NoLogo -NoProfile -ExecutionPolicy Bypass -File \"" + strFile + "\"";
            pri.Arguments = strArgs;
            pri.RedirectStandardOutput = false;
            pri.UseShellExecute = true;
            pri.CreateNoWindow = false;
            firstProc.EnableRaisingEvents = true;
            firstProc.StartInfo = pri;

            try
            {
                firstProc.Start();
                if (iTimeOut <= 0)
                {
                    firstProc.WaitForExit();
                    Console.Out.WriteLine("Process {0} is terminated Successfully!");
                    return 0;
                }
                else
                {
                    if (!firstProc.WaitForExit(iTimeOut))
                    {
                        firstProc.Kill();
                    }
                    Console.Out.WriteLine("Process {0} is terminated after {1} milliseconds.", strFile, iTimeOut);
                    return 0;
                }
            }
            catch (Exception e)
            {
                Console.Error.WriteLine("Process Error. Can\'t Run a File {0}.\n{1}", strFile, e.Message);
                return 2;
            }
        }

        public int StartAsCScriptFile(String strFile, int iTimeOut)
        {
            String strArgs;
            if (strFile.Length == 0)
            {
                Console.Error.WriteLine("Process Error! Can\'t Run Empty File.");
                return 1;
            }
            if (!File.Exists(strFile))
            {
                Console.Error.WriteLine("Error open file: {0}.\nFile may contains a malware or does not exist.\n", strFile);
                return 1;
            }
            if (strCScriptPath.Length == 0)
            {
                Console.Error.WriteLine("Check Integrity Error! The CScript Path {0} does not Exists!", strCScriptPath);
                return 1;
            }
            ProcessStartInfo pri = new ProcessStartInfo();
            Process firstProc = new Process();
            pri.FileName = strCScriptPath;
            strArgs = " //NoLogo \"" + strFile + "\"";
            pri.Arguments = strArgs;
            pri.RedirectStandardOutput = false;
            pri.UseShellExecute = true;
            pri.CreateNoWindow = false;
            firstProc.EnableRaisingEvents = true;
            firstProc.StartInfo = pri;

            try
            {
                firstProc.Start();
                if (iTimeOut <= 0)
                {
                    firstProc.WaitForExit();
                    Console.Out.WriteLine("Process {0} is terminated Successfully!");
                    return 0;
                }
                else
                {
                    if (!firstProc.WaitForExit(iTimeOut))
                    {
                        firstProc.Kill();
                    }
                    Console.Out.WriteLine("Process {0} is terminated after {1} milliseconds.", strFile, iTimeOut);
                    return 0;
                }
            }
            catch (Exception e)
            {
                Console.Error.WriteLine("Process Error. Can\'t Run a File {0}.\n{1}", strFile, e.Message);
                return 2;
            }
        }

        public int StartFile(String strFile, int iTimeOut)
        {
            String strArgs;
            if (strFile.Length == 0)
            {
                Console.Error.WriteLine("Process Error! Can\'t Run Empty File.");
                return 1;
            }
            if (!File.Exists(strFile))
            {
                Console.Error.WriteLine("Error open file: {0}.\nFile may contains a malware or does not exist.\n", strFile);
                return 1;
            }
            if (strCmdPath.Length == 0)
            {
                Console.Error.WriteLine("Check Integrity Error! The Cmd Path {0} does not Exists!", strCmdPath);
                return 1;
            }

            ProcessStartInfo pri = new ProcessStartInfo();
            Process firstProc = new Process();
            pri.FileName = strCmdPath;
            strArgs = " /c START /WAIT /REALTIME /B " + strFile;
            pri.Arguments = strArgs;
            pri.RedirectStandardOutput = false;
            pri.UseShellExecute = true;
            pri.CreateNoWindow = false;
            firstProc.EnableRaisingEvents = true;
            firstProc.StartInfo = pri;

            try
            {
                firstProc.Start();
                if (iTimeOut <= 0)
                {
                    firstProc.WaitForExit();
                    Console.Out.WriteLine("Process {0} is terminated Successfully!");
                    return 0;
                }
                else
                {
                    if (!firstProc.WaitForExit(iTimeOut))
                    {
                        firstProc.Kill();
                    }
                    Console.Out.WriteLine("Process {0} is terminated after {1} milliseconds.", strFile, iTimeOut);
                    return 0;
                }
            }
            catch (Exception e)
            {
                Console.Error.WriteLine("Process Error. Can\'t Run a File {0}.\n{1}", strFile, e.Message);
                return 2;
            }
        }

    }

}
