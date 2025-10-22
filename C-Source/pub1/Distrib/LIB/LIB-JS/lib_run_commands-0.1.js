/* ********************************************************
 * This Function will return a first argiment
 * of CScript
 * *******************************************************/

function GetFirstArg_0_1() {
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

function ReadAllTextFile_0_1() {
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
 * runCommnd_0_1
 * This function is Run a Windows Command and Return
 * an Error Code of command
 * ******************************************************/

function runCommand_0_1(command) {
  var fso = new ActiveXObject("Scripting.FileSystemObject");
  var wshShell = new ActiveXObject("WScript.Shell");
  var result = 0;
  var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "cmd.exe") + ' /C ' + command;
  result = wshShell.Run(cmdLine, 0, true);
  return result;
}

/* *******************************************************
 * runCommndShow_0_1
 * This function is Run a Windows Command and Return
 * an Error Code of command
 * ******************************************************/

function runCommandShow_0_1(command) {
  var fso = new ActiveXObject("Scripting.FileSystemObject");
  var wshShell = new ActiveXObject("WScript.Shell");
  var result = 0;
  var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "cmd.exe") + ' /k ' + command;
  result = wshShell.Run(cmdLine, 1, true);
  return result;
}

/* *******************************************************
 * runPoshFile_0_1
 * This function is Run a Powershell Command and Return
 * an Error Code of the Command
 * ******************************************************/

function runPoshFile_0_1(command) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wshShell = new ActiveXObject("WScript.Shell");
    var result = 0;
    var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "WindowsPowerShell\\v1.0\\powershell.exe") + ' -NoLogo -NoProfile -ExecutionPolicy Bypass -File ' + command;
    result =wshShell.Run(cmdLine, 0, true);
    return result;
  }
  
/* *******************************************************
 * runPoshFileShow_0_1
 * This function is Run a Powershell Command and Return
 * an Error Code of the Command
 * ******************************************************/

function runPoshFileShow_0_1(command) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wshShell = new ActiveXObject("WScript.Shell");
    var result = 0;
    var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "WindowsPowerShell\\v1.0\\powershell.exe") + ' -NoLogo -NoProfile -NoExit -ExecutionPolicy Bypass -File ' + command;
    result =wshShell.Run(cmdLine, 1, true);
    return result;
  }
  
/* *******************************************************
 * runPoshCmd_0_1
 * This function is Run a Powershell Command and Return
 * an Error Code of a Command
 * ******************************************************/

function runPoshCmd_0_1(command) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wshShell = new ActiveXObject("WScript.Shell");
    var result = 0;
    var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "WindowsPowerShell\\v1.0\\powershell.exe") + " -NoLogo -NoProfile -ExecutionPolicy Bypass -Command \"" + command + "\"";
    result = wshShell.Run(cmdLine, 0, true);
    return result;
  }
  
/* *******************************************************
 * runPoshCmdShow_0_1
 * This function is Run a Powershell Command and Return
 * an Error Code of a Command
 * ******************************************************/

function runPoshCmdShow_0_1(command) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wshShell = new ActiveXObject("WScript.Shell");
    var result = 0;
    var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "WindowsPowerShell\\v1.0\\powershell.exe") + " -NoLogo -NoProfile -NoExit -ExecutionPolicy Bypass -Command \"" + command + "\"";
    result = wshShell.Run(cmdLine, 1, true);
    return result;
  }
  
  
//var output = runCommand_0_1("dir");
//var output = runCommandShow_0_1("dir");
//var output = runCommand_0_1("ls.exe");
//var output = runPoshCmdShow_0_1("ls");
//WScript.Echo("errno = " + output);

