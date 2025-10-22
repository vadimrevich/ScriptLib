﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace NIT.Test.Download._45._000
{
    public static class cGetEnvVarsWinExp
    {

        [DllImport("Shell32.dll")] private static extern int SHGetKnownFolderPath(
        [MarshalAs(UnmanagedType.LPStruct)]Guid rfid, uint dwFlags, IntPtr hToken,
        out IntPtr ppszPath);

        [Flags]
        public enum KnownFolderFlags : uint
        {
            SimpleIDList = 0x00000100
            , NotParentRelative = 0x00000200, DefaultPath = 0x00000400, Init = 0x00000800
            , NoAlias = 0x00001000, DontUnexpand = 0x00002000, DontVerify = 0x00004000
            , Create = 0x00008000, NoAppcontainerRedirection = 0x00010000, AliasOnly = 0x80000000
        }
        public static String GetPath(String RegStrName, KnownFolderFlags flags, bool defaultUser)
        {
            IntPtr outPath;
            int result =
                SHGetKnownFolderPath(
                    new Guid(RegStrName), (uint)flags, new IntPtr(defaultUser ? -1 : 0), out outPath
                );
            if (result >= 0)
            {
                return Marshal.PtrToStringUni(outPath);
            }
            else
            {
                throw new ExternalException("Unable to retrieve the known folder path. It may not "
                    + "be available on this system.", result);
            }
        }
        public static String GetDownloadPath()
        {
            String res = "";
            if (Environment.OSVersion.Version.Major < 6) return res;
            res = GetPath("{374DE290-123F-4565-9164-39C4925E467B}", cGetEnvVarsWinExp.KnownFolderFlags.DontVerify, false);
            if(Directory.Exists(res))
            {
                return res;
            }
            else
            {
                return (String)"";
            }
        }
    }
}
