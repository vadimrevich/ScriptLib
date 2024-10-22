/* ********************************************************
 * This Function will return a first argiment
 * of CScript
 * *******************************************************/

function GetFirstArg() {
    var args = WScript.Arguments;
    var argsLen = args.length;
    if( argsLen == 0 ) {
        return "";
    }
    else {
        return args.Item(0);
    }
}

/**********************************************************
 * This Script Read all Text File into variable
 *********************************************************/

function ReadAllTextFile() {
    var fso, content, file;
    var arg = GetFirstArg();
    if( arg.length == 0) {
        return "";
    }
    else {
        fso = new ActiveXObject("Scripting.FileSystemObject");
        if( ! fso.FileExists(arg)) {
            return "";
        }
        else {
            file = fso.OpenTextFile(arg, 1, true);
            content = file.ReadAll();
            return content;
        }
    }
}

/* *******************************************************
 * runCommnd
 * This function is Run a Windows Command and Return
 * a Full Output of a Command
 * ******************************************************/

function runCommand(command) {
  var fso = new ActiveXObject("Scripting.FileSystemObject");
  var wshShell = new ActiveXObject("WScript.Shell");
  do {
    var tempName = fso.BuildPath(fso.GetSpecialFolder(2), fso.GetTempName());
  } while ( fso.FileExists(tempName) );
  var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "cmd.exe") + ' /C ' + command + ' > "' + tempName + '"';
  wshShell.Run(cmdLine, 0, true);
  var result = "";
  try {
    var ts = fso.OpenTextFile(tempName, 1, false);
    result = ts.ReadAll();
    ts.Close();
  }
  catch(err) {
  }
  if ( fso.FileExists(tempName) )
    fso.DeleteFile(tempName);
  return result;
}

/* *******************************************************
 * runPoshOEM
 * This function is Run a Powershell Command and Return
 * a Full Output of a Command
 * ******************************************************/

function runPoshOEM(command) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wshShell = new ActiveXObject("WScript.Shell");
    do {
      var tempName = fso.BuildPath(fso.GetSpecialFolder(2), fso.GetTempName());
    } while ( fso.FileExists(tempName) );
    var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "WindowsPowerShell\\v1.0\\powershell.exe") + ' -NoLogo -NoProfile -ExecutionPolicy Bypass -File ' + command + ' | Out-File -Encoding OEM -FilePath "' + tempName + '"';
    wshShell.Run(cmdLine, 0, true);
    var result = "";
    try {
      var ts = fso.OpenTextFile(tempName, 1, false);
      result = ts.ReadAll();
      ts.Close();
    }
    catch(err) {
    }
    if ( fso.FileExists(tempName) )
      fso.DeleteFile(tempName);
    return result;
  }
  
/* *******************************************************
 * runPoshAnsi
 * This function is Run a Powershell Command and Return
 * a Full Output of a Command
 * ******************************************************/

function runPoshAnsi(command) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wshShell = new ActiveXObject("WScript.Shell");
    do {
      var tempName = fso.BuildPath(fso.GetSpecialFolder(2), fso.GetTempName());
    } while ( fso.FileExists(tempName) );
    var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "WindowsPowerShell\\v1.0\\powershell.exe") + ' -NoLogo -NoProfile -ExecutionPolicy Bypass -File ' + command + ' | Out-File -Encoding Default -FilePath "' + tempName + '"';
    wshShell.Run(cmdLine, 0, true);
    var result = "";
    try {
      var ts = fso.OpenTextFile(tempName, 1, false);
      result = ts.ReadAll();
      ts.Close();
    }
    catch(err) {
    }
    if ( fso.FileExists(tempName) )
      fso.DeleteFile(tempName);
    return result;
  }
  
/* *******************************************************
 * runPoshUTF8
 * This function is Run a Powershell Command and Return
 * a Full Output of a Command
 * ******************************************************/

function runPoshUTF8(command) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wshShell = new ActiveXObject("WScript.Shell");
    do {
      var tempName = fso.BuildPath(fso.GetSpecialFolder(2), fso.GetTempName());
    } while ( fso.FileExists(tempName) );
    var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "WindowsPowerShell\\v1.0\\powershell.exe") + ' -NoLogo -NoProfile -ExecutionPolicy Bypass -File ' + command + ' | Out-File -Encoding UTF8 -FilePath "' + tempName + '"';
    wshShell.Run(cmdLine, 0, true);
    var result = "";
    try {
      var ts = fso.OpenTextFile(tempName, 1, false);
      result = ts.ReadAll();
      ts.Close();
    }
    catch(err) {
    }
    if ( fso.FileExists(tempName) )
      fso.DeleteFile(tempName);
    return result;
  }
  
/* *******************************************************
 * runPoshOEMCmd
 * This function is Run a Powershell Command and Return
 * a Full Output of a Command
 * ******************************************************/

function runPoshOEMCmd(command) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wshShell = new ActiveXObject("WScript.Shell");
    do {
      var tempName = fso.BuildPath(fso.GetSpecialFolder(2), fso.GetTempName());
    } while ( fso.FileExists(tempName) );
    var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "WindowsPowerShell\\v1.0\\powershell.exe") + " -NoLogo -NoProfile -ExecutionPolicy Bypass -Command \"" + command + ' | Out-File -Encoding OEM -FilePath ' + tempName + '"';
    wshShell.Run(cmdLine, 0, true);
    var result = "";
    try {
      var ts = fso.OpenTextFile(tempName, 1, false);
      result = ts.ReadAll();
      ts.Close();
    }
    catch(err) {
    }
    if ( fso.FileExists(tempName) )
      fso.DeleteFile(tempName);
    return result;
  }
  
/* *******************************************************
 * runPoshAnsiCmd
 * This function is Run a Powershell Command and Return
 * a Full Output of a Command
 * ******************************************************/

function runPoshAnsiCmd(command) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wshShell = new ActiveXObject("WScript.Shell");
    do {
      var tempName = fso.BuildPath(fso.GetSpecialFolder(2), fso.GetTempName());
    } while ( fso.FileExists(tempName) );
    var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "WindowsPowerShell\\v1.0\\powershell.exe") + " -NoLogo -NoProfile -ExecutionPolicy Bypass -Command \"" + command + ' | Out-File -Encoding Default -FilePath ' + tempName + '"';
    wshShell.Run(cmdLine, 0, true);
    var result = "";
    try {
      var ts = fso.OpenTextFile(tempName, 1, false);
      result = ts.ReadAll();
      ts.Close();
    }
    catch(err) {
    }
    if ( fso.FileExists(tempName) )
      fso.DeleteFile(tempName);
    return result;
  }
  
/* *******************************************************
 * runPoshUTF8Cmd
 * This function is Run a Powershell Command and Return
 * a Full Output of a Command
 * ******************************************************/

function runPoshUTF8Cmd(command) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wshShell = new ActiveXObject("WScript.Shell");
    do {
      var tempName = fso.BuildPath(fso.GetSpecialFolder(2), fso.GetTempName());
    } while ( fso.FileExists(tempName) );
    var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "WindowsPowerShell\\v1.0\\powershell.exe") + " -NoLogo -NoProfile -ExecutionPolicy Bypass -Command \"" + command + ' | Out-File -Encoding UTF8 -FilePath ' + tempName + '"';
    wshShell.Run(cmdLine, 0, true);
    var result = "";
    try {
      var ts = fso.OpenTextFile(tempName, 1, false);
      result = ts.ReadAll();
      ts.Close();
    }
    catch(err) {
    }
    if ( fso.FileExists(tempName) )
      fso.DeleteFile(tempName);
    return result;
  }
  
//  var output = runCommand("dir");
//var output = runCommand("C:\\.BIN\\smbshare\\NIT\\atHost\\Win\\nmap.bat");
//var output = runCommand("ls.exe");
//var output = runPoshAnsiCmd("ls $env:UserProfile")
//var output = runPoshUTF8Cmd("ls");
//WScript.Echo(output);

