using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.IO;

namespace NIT.Test.Download._45._000
{
    class Downloads
    {
        /// <summary>
        /// Set Constant definition
        /// </summary>

        // Set private Members
        private String anURL;
        private String aLocalPath;
        private String aFileName;

        // Private Folders
        //
        // May be Protected Folder
        //

        // May Be public Folder
        //
        // private String aUserProfilePath;

        // Set Private Methods

        private void SetClassMembers()
        {
            anURL = String.Empty;
            aLocalPath = String.Empty;
            aFileName = String.Empty;
        }

        // Constructor
        public Downloads()
        {
            SetClassMembers();
        }

        // Modificators
        public String GetLocalPath()
        {
            return aLocalPath;
        }

        public void SetUserDownloadPath()
        {
            String strRes = UserDirectories.GetUserDownloadPath();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetUserProfilePath()
        {
            String strRes = UserDirectories.GetUserProfilePath();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetSystemAActDir()
        {
            String strRes = UserDirectories.GetSystemAActDir();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetSystemKMSDir()
        {
            String strRes = UserDirectories.GetSystemKMSDir();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetSystemKMSAutoSDir()
        {
            String strRes = UserDirectories.GetSystemKMSAutoSDir();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetNITBINDir()
        {
            String strRes = UserDirectories.GetNITBinPath();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetNITEleveationDir()
        {
            String strRes = UserDirectories.GetNITElevationPath();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetNITSysUpDir()
        {
            String strRes = UserDirectories.GetNITSYSUPPath();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetNITProgDataDir()
        {
            String strRes = UserDirectories.GetNITProgDataPath();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetNITPub1Dir()
        {
            String strRes = UserDirectories.GetNITPub1Path();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetZlovredDir()
        {
            String strRes = UserDirectories.GetZlovredPath();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetPubDir()
        {
            String strRes = UserDirectories.GetPubPath();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetNITUtilDir()
        {
            String strRes = UserDirectories.GetNITUtilPath();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetRServer30Path()
        {
            String strRes = UserDirectories.GetRServer30Path();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetUserDocumentsPath()
        {
            String strRes = UserDirectories.GetUserDocumentsPath();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        public void SetUserDesktopPath()
        {
            String strRes = UserDirectories.GetUserDesktopPath();
            if (strRes.Length > 0)
            {
                // Set a Full Local File Path with Rename
                if (aFileName.Length > 0)
                    aLocalPath = strRes + "\\" + aFileName;
                else
                    aLocalPath = String.Empty;
            }
            else
            {
                aLocalPath = String.Empty;
            }
        }

        // Public Methods
        public int Download()
        {
            if (File.Exists(aLocalPath))
            {
                try
                {
                    File.Delete(aLocalPath);
                }
                catch
                {
                    Console.Error.WriteLine("Can\'t Delete File {aLocalPath}.\nDownloads Aborting.");
                    aLocalPath = String.Empty;
                    return 2;
                }
            }

            // Set the callback to always return true, ignoring certificate validation
            ServicePointManager.ServerCertificateValidationCallback += (sender, certificate, chain, sslPolicyErrors) => true;

            using (WebClient Client = new WebClient())
            {
                try
                {
                    // Set TLS Protocols with Versions 1.0, 1.1 and 1.2 (insecure, for old sites)
                    System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls | System.Net.SecurityProtocolType.Tls11 | System.Net.SecurityProtocolType.Tls12;
                    // Download a File
                    Client.DownloadFile(anURL, aLocalPath);
                }
                catch (ArgumentNullException err1)
                {
                    Console.Error.WriteLine("Download Exeption: " + err1.Message + ".\nCan\'t Load URL");
                    aLocalPath = String.Empty;
                    return 2;
                }
                catch (WebException err2)
                {
                    Console.Error.WriteLine("Download Web Exeption: " + err2.Message + ".\nCan\'t Download File " + aLocalPath + " with ErrorCode " + err2.Status);
                    aLocalPath = String.Empty;
                    return 2;
                }

            }

            Console.Out.WriteLine("Succes Download File: {0}!", aLocalPath);
            if(File.Exists(aLocalPath))
                return 0;
            else
            {
                Console.Error.WriteLine("Download File Exeption. Can\'t Find a File {0} to be Downloaded.\nIt may contents a malware.", aLocalPath);
                aLocalPath = String.Empty;
                return 1;
            }
        }

        public void SetFileName000( String theFileName)
        {
            aFileName = theFileName;
        }

        public void CreateURL000(String prefix, String domain, String port, String path)
        {
            if (aFileName.Length > 0)
            {
                anURL = prefix + "://" + domain + ":" + port + path + aFileName;
            }
            else
                anURL = String.Empty;
        }

        public void CreateURL001(String prefix, String domain, String port, String path, String intermediate)
        {
            if (aFileName.Length > 0)
            {
                anURL = prefix + "://" + domain + ":" + port + path + intermediate + aFileName;
            }
            else
                anURL = String.Empty;
        }
    }
}
