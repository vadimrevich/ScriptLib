#!php.exe
<?php
/* ********************************************************
 * subp.echo.bat.run.php
 * This Script will Run a echo-hello.bat Tool
**********************************************************/

# Setup Command Interpreter
$pathCMD = $_SERVER['SystemRoot'] . "\\System32";
$CMDEXE = $pathCMD . "\\" . "cmd.exe";
$batFile = "echo-hello.bat";
# $aStartCmd = "Start /b ";
$aStartCmd = $CMDEXE. " /k ";
$aStartPath = $_SERVER['USERPROFILE'];
$aBatPath = $aStartPath . "\\" . $batFile;
if( is_dir($pathCMD)) {
    if(is_file($CMDEXE)){
        $strValue = $aStartCmd . $aBatPath;
        if(is_file($aBatPath)) {
            $handle = (popen($strValue, 'r'));
            echo( "\n" . '$handle:' . gettype($handle) . "\n");
            while(!feof($handle)){
                $read = fread($handle, 4096);
                echo($read);
            }
            $r = pclose($handle);
            $rjson = json_encode(array('result'=>$r));
            print_r($rjson);
        }
    }
    else {
        echo("\nA File " . $CMDEXE . " is not found.");
    }
}
else {
    echo("\nA Path " . $pathCMD . " is not Found.");
}
?>