using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Globalization;

namespace NIT.Test.Download._45._000
{
    public class UserDirectories
    {
        /* Private Methods */
        private static void MakeKMSDirs()
        {
            String strDir;
            strDir = GetSystemRootPath();
            if (strDir.Length > 0)
            {
                strDir = GetSystemRootPath() + "\\AAct_Tools";
                if (!Directory.Exists(strDir))
                {
                    try
                    {
                        Directory.CreateDirectory(strDir);
                    }
                    catch (Exception e)
                    {
                        Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                    }
                }

                strDir = GetSystemRootPath() + "\\AAct_Tools\\AAct_files";
                if (!Directory.Exists(strDir))
                {
                    try
                    {
                        Directory.CreateDirectory(strDir);
                    }
                    catch (Exception e)
                    {
                        Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                    }
                }
                strDir = GetSystemRootPath() + "\\KMS";
                if (!Directory.Exists(strDir))
                {
                    try
                    {
                        Directory.CreateDirectory(strDir);
                    }
                    catch (Exception e)
                    {
                        Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                    }
                }
                strDir = GetSystemRootPath() + "\\KMSAutoS";
                if (!Directory.Exists(strDir))
                {
                    try
                    {
                        Directory.CreateDirectory(strDir);
                    }
                    catch (Exception e)
                    {
                        Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                    }
                }
            }

        }

        private static void MakePub1Dir()
        {
            String strDir;
            strDir = "C:\\pub1";
            if (!Directory.Exists(strDir))
            {
                try
                {
                    Directory.CreateDirectory(strDir);
                }
                catch (Exception e)
                {
                    Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                }
            }
            strDir = "C:\\pub1\\Distrib";
            if (!Directory.Exists(strDir))
            {
                try
                {
                    Directory.CreateDirectory(strDir);
                }
                catch (Exception e)
                {
                    Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                }
            }
            strDir = "C:\\pub1\\Distrib\\Zlovred";
            if (!Directory.Exists(strDir))
            {
                try
                {
                    Directory.CreateDirectory(strDir);
                }
                catch (Exception e)
                {
                    Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                }
            }
            strDir = "C:\\pub1\\Util";
            if (!Directory.Exists(strDir))
            {
                try
                {
                    Directory.CreateDirectory(strDir);
                }
                catch (Exception e)
                {
                    Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                }
            }
        }

        private static void MakeNITUtilDir()
        {
            String strDir;
            strDir = "C:\\.BIN";
            if (!Directory.Exists(strDir))
            {
                try
                {
                    Directory.CreateDirectory(strDir);
                }
                catch (Exception e)
                {
                    Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                }
            }
            strDir = "C:\\Elevation";
            if (!Directory.Exists(strDir))
            {
                try
                {
                    Directory.CreateDirectory(strDir);
                }
                catch (Exception e)
                {
                    Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                }
            }
            strDir = "C:\\NIT.SYSUPDATE";
            if (!Directory.Exists(strDir))
            {
                try
                {
                    Directory.CreateDirectory(strDir);
                }
                catch (Exception e)
                {
                    Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                }
            }
            strDir = "C:\\ProgramData\\NIT";
            if (!Directory.Exists(strDir))
            {
                try
                {
                    Directory.CreateDirectory(strDir);
                }
                catch (Exception e)
                {
                    Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                }
            }
            strDir = "C:\\pub";
            if (!Directory.Exists(strDir))
            {
                try
                {
                    Directory.CreateDirectory(strDir);
                }
                catch (Exception e)
                {
                    Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                }
            }
            strDir = "C:\\Util";
            if (!Directory.Exists(strDir))
            {
                try
                {
                    Directory.CreateDirectory(strDir);
                }
                catch (Exception e)
                {
                    Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                }
            }
            strDir = GetPathCmd();
            if(Directory.Exists(strDir))
            {
                strDir = strDir + "\\rserver30";
                if(!Directory.Exists(strDir))
                {
                    try
                    {
                        Directory.CreateDirectory(strDir);
                    }
                    catch (Exception e)
                    {
                        Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                    }
                }
            }
            strDir = GetPathWOWCmd();
            if (Directory.Exists(strDir))
            {
                strDir = strDir + "\\rserver30";
                if (!Directory.Exists(strDir))
                {
                    try
                    {
                        Directory.CreateDirectory(strDir);
                    }
                    catch (Exception e)
                    {
                        Console.Error.WriteLine("Can\'t Create a Directory {0}.\n{1}", strDir, e.Message);
                    }
                }
            }
        }

        /* Public Methods */

        [DllImport("kernel32.dll", SetLastError = true, CallingConvention = CallingConvention.Winapi)]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool IsWow64Process([In] IntPtr hProcess, [Out] out bool lpSystemInfo);

        public static bool Is64Bit()
        {
            bool retVal;
            IsWow64Process(Process.GetCurrentProcess().Handle, out retVal);
            return retVal;
        }
        public static String GetUserDownloadPath()
        {
            String strRes = "";
            if (Environment.OSVersion.Version.Major < 6) return GetUserDocumentsPath();
            strRes = cGetEnvVarsWinExp.GetDownloadPath();
            if( strRes.Length == 0)
            {
                return GetUserTempPath();
            }
            else
            {
                return strRes;
            }
        }

        public static String GetUserDocumentsPath()
        {
            String strRes = "";
            strRes = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            if(Directory.Exists(strRes))
            {
                return strRes;
            }
            else
            {
                return GetUserTempPath();
            }
        }

        public static String GetUserDesktopPath()
        {
            String strRes = "";
            strRes = Environment.GetFolderPath(Environment.SpecialFolder.DesktopDirectory);
            if (Directory.Exists(strRes))
            {
                return strRes;
            }
            else
            {
                return GetUserTempPath();
            }
        }

        public static String GetUserTempPath()
        {
            String strRes = "";
            strRes = Environment.GetEnvironmentVariable("TEMP", EnvironmentVariableTarget.Process);
            if (Directory.Exists(strRes))
            {
                return strRes;
            }
            else
            {
                strRes = Environment.GetEnvironmentVariable("TEMP", EnvironmentVariableTarget.Machine);
                if (Directory.Exists(strRes))
                {
                    return strRes;
                }
                else
                {
                    Console.Error.WriteLine("Check Integrity Error! System Variable %Temp% is not Found.");
                    return String.Empty;
                }
            }
        }

        public static String GetUserProfilePath()
        {
            String strRes = String.Empty;
            strRes = Environment.GetEnvironmentVariable("USERPROFILE", EnvironmentVariableTarget.Process);
            if (Directory.Exists(strRes))
            {
                return strRes;
            }
            else
            {
                strRes = Environment.GetEnvironmentVariable("TEMP", EnvironmentVariableTarget.Machine);
                if (Directory.Exists(strRes))
                {
                    return strRes;
                }
                else
                {
                    return GetSystemRootPath();
                }
            }
        }

        public static String GetSystemRootPath()
        {
            String strRes = String.Empty;
            strRes = Environment.GetEnvironmentVariable("SystemRoot", EnvironmentVariableTarget.Process);
            if (Directory.Exists(strRes))
            {
                return strRes;
            }
            else
            {
                Console.Error.WriteLine("Check Integrity Error! %SystemRoot% Folder is not Found.");
                return String.Empty;
            }
        }

        public static String GetPathCmd()
        {
            String strRes = GetSystemRootPath();
            if (strRes.Length > 0)
            {
                strRes = strRes + "\\System32";
                if (Directory.Exists(strRes))
                {
                    return strRes;
                }
            }
            Console.Error.WriteLine("Check Integrity Error! pathCmd Folder is not Found.");
            return String.Empty;
        }

        public static String GetPathWOWCmd()
        {
            String strRes = GetSystemRootPath();
            // if (!Is64Bit()) return String.Empty;
            if( strRes.Length > 0)
            {
                strRes = strRes + "\\SysWOW64";
                if (Directory.Exists(strRes))
                {
                    return strRes;
                }
                else
                {
                    strRes = GetPathCmd();
                }
            }
            Console.Error.WriteLine("Check Integrity Error! pathWOWCmd Folder is not Found.");
            return String.Empty;
        }

        public static String GetSystemAActDir()
        {
            String strRes = GetSystemRootPath();
            if (strRes.Length == 0)
            {
                return String.Empty;
            }
            else
            {
                // MakeKMSDirs();
                strRes = strRes + "\\AAct_Tools";
                if (!Directory.Exists(strRes)) return String.Empty;
                return strRes;
            }
        }
        public static String GetSystemKMSDir()
        {
            String strRes = GetSystemRootPath();
            if (strRes.Length == 0)
            {
                return String.Empty;
            }
            else
            {
                // MakeKMSDirs();
                strRes = strRes + "\\KMS";
                if (!Directory.Exists(strRes)) return String.Empty;
                return strRes;
            }
        }
        public static String GetSystemKMSAutoSDir()
        {
            String strRes = GetSystemRootPath();
            if (strRes.Length == 0)
            {
                return String.Empty;
            }
            else
            {
                // MakeKMSDirs();
                strRes = strRes + "\\KMSAutoS";
                if (!Directory.Exists(strRes)) return String.Empty;
                return strRes;
            }
        }
        public static String GetNITBinPath()
        {
            String strRes = "C:\\.BIN";
            // MakeNITUtilDir();
            if (!Directory.Exists(strRes))
            {
                return String.Empty;
            }
            else
            {
                return strRes;
            }
        }
        public static String GetNITElevationPath()
        {
            String strRes = "C:\\Elevation";
            // MakeNITUtilDir();
            if (!Directory.Exists(strRes))
            {
                return String.Empty;
            }
            else
            {
                return strRes;
            }
        }
        public static String GetNITSYSUPPath()
        {
            String strRes = "C:\\NIT.SYSUPDATE";
            // MakeNITUtilDir();
            if (!Directory.Exists(strRes))
            {
                return String.Empty;
            }
            else
            {
                return strRes;
            }
        }
        public static String GetNITProgDataPath()
        {
            String strRes = "C:\\ProgramData\\NIT";
            // MakeNITUtilDir();
            if (!Directory.Exists(strRes))
            {
                return String.Empty;
            }
            else
            {
                return strRes;
            }
        }
        public static String GetPubPath()
        {
            String strRes = "C:\\pub";
            // MakeNITUtilDir();
            if (!Directory.Exists(strRes))
            {
                return String.Empty;
            }
            else
            {
                return strRes;
            }
        }
        public static String GetNITUtilPath()
        {
            String strRes = "C:\\Util";
            // MakeNITUtilDir();
            if (!Directory.Exists(strRes))
            {
                return String.Empty;
            }
            else
            {
                return strRes;
            }
        }
        public static String GetNITPub1Path()
        {
            String strRes = "C:\\pub1";
            // MakePub1Dir();
            if (!Directory.Exists(strRes))
            {
                return String.Empty;
            }
            else
            {
                return strRes;
            }
        }
        public static String GetZlovredPath()
        {
            String strRes = "C:\\pub1\\Distrib\\Zlovred";
            // MakePub1Dir();
            if (!Directory.Exists(strRes))
            {
                return String.Empty;
            }
            else
            {
                return strRes;
            }
        }
        public static String GetRServer30Path()
        {
            String strRes = GetPathWOWCmd();
            if(strRes.Length == 0)
            {
                strRes = GetPathCmd();
            }
            if (strRes.Length == 0) return String.Empty;
            // MakeNITUtilDir();
            strRes = strRes + "\\rserver30";
            if (!Directory.Exists(strRes))
            {
                return String.Empty;
            }
            else
            {
                return strRes;
            }
        }

        public static int GetMajorWindowsVersion()
        {
            OperatingSystem os = Environment.OSVersion;
            Version ver = os.Version;
            return ver.Major;
        }
        public static int GetMinorWindowsVersion()
        {
            OperatingSystem os = Environment.OSVersion;
            Version ver = os.Version;
            return ver.Minor;
        }
        public static int GetBuildWindowsVersion()
        {
            OperatingSystem os = Environment.OSVersion;
            Version ver = os.Version;
            return ver.Build;
        }
        public static string GetValidWindowsVersion()
        {
            string strVersion = "Unknown";
            int aMajor = GetMajorWindowsVersion();
            int aMinor = GetMinorWindowsVersion();
            int aBuild = GetBuildWindowsVersion();
            // Console.Error.WriteLine("{0} - {1} - {2}", aMajor, aMinor, aBuild);
            switch(aMajor)
            {
                case 6:
                    switch(aMinor)
                    {
                        case 1:
                            strVersion = "6.1";
                            break;
                        case 3:
                            if(Is64Bit())
                                strVersion = "6.3";
                            break;
                    }
                    break;
                case 10:
                    if( aBuild >= 22621)
                    {
                        strVersion = "11";
                    }
                    else
                    {
                        strVersion = "10.0";
                    }
                    break;
            }
            return strVersion;
        }
        public static string CheckWindowsLangID()
        {
            CultureInfo ci = CultureInfo.InstalledUICulture;
            return ci.EnglishName;
        }

        const int OS_ANYSERVER = 29;
        [DllImport("shlwapi.dll", SetLastError = true, EntryPoint = "#437")]
        private static extern bool IsOS(int os);

        public static string CheckWindowsServer()
        {
            bool isAServer = IsOS(OS_ANYSERVER);
            if( isAServer)
            {
                return (string)"Server";
            }
            else
            {
                return (string)"Client";
            }
        }
        public static string GetWindowsVersionString()
        {
            string str;
            string strDigit;

            if (Is64Bit())
                strDigit = "amd64";
            else
                strDigit = "x86";
            str = "Windows " + GetValidWindowsVersion() + " " + CheckWindowsServer() + " " + CheckWindowsLangID() + " Language " + strDigit + " Operation System";
            return str;
        }
        public static String GetMSIEXECPath()
        {
            String strRes = GetPathCmd();
            if (strRes.Length > 0)
            {
                strRes = strRes + "\\msiexec.exe";
                if (!File.Exists(strRes))
                {
                    return String.Empty;
                }
                else
                {
                    return strRes;
                }
            }
            return String.Empty;
        }
        public static String GetWMICEXEPath()
        {
            String strRes = GetPathCmd();
            if (strRes.Length > 0)
            {
                strRes = strRes + "\\WBem\\WMIC.exe";
                if (!File.Exists(strRes))
                {
                    return String.Empty;
                }
                else
                {
                    return strRes;
                }
            }
            return String.Empty;
        }
        public static String GetCSciptPath()
        {
            String strRes = GetPathCmd();
            if (strRes.Length > 0)
            {
                strRes = strRes + "\\cscript.exe";
                if (!File.Exists(strRes))
                {
                    return String.Empty;
                }
                else
                {
                    return strRes;
                }
            }
            return String.Empty;
        }
        public static String GetCMDEXEPath()
        {
            String strRes = GetPathCmd();
            if (strRes.Length > 0)
            {
                strRes = strRes + "\\cmd.exe";
                if (!File.Exists(strRes))
                {
                    return String.Empty;
                }
                else
                {
                    return strRes;
                }
            }
            return String.Empty;
        }
        public static String GetCScipt32Path()
        {
            String strRes = GetPathWOWCmd();
            if (strRes.Length > 0)
            {
                strRes = strRes + "\\cscript.exe";
                if (!File.Exists(strRes))
                {
                    return String.Empty;
                }
                else
                {
                    return strRes;
                }
            }
            return String.Empty;
        }
        public static String GetCMDEXE32Path()
        {
            String strRes = GetPathWOWCmd();
            if (strRes.Length > 0)
            {
                strRes = strRes + "\\cmd.exe";
                if (!File.Exists(strRes))
                {
                    return String.Empty;
                }
                else
                {
                    return strRes;
                }
            }
            return String.Empty;
        }
        public static String GetPoshEXEPath()
        {
            String strRes = GetPathCmd();
            if (strRes.Length > 0)
            {
                strRes = strRes + "\\WindowsPowerShell\\v1.0\\powershell.exe";
                if (!File.Exists(strRes))
                {
                    return String.Empty;
                }
                else
                {
                    return strRes;
                }
            }
            return String.Empty;
        }
        public static String GetPoshEXE32Path()
        {
            String strRes = GetPathWOWCmd();
            if (strRes.Length > 0)
            {
                strRes = strRes + "\\WindowsPowerShell\\v1.0\\powershell.exe";
                if (!File.Exists(strRes))
                {
                    return String.Empty;
                }
                else
                {
                    return strRes;
                }
            }
            return String.Empty;
        }
    }
}
