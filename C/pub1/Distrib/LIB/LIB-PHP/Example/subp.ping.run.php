#!php.exe
<?php
/* ********************************************************
 * subp.ping.run.php
 * This Script will Run a ping.exe Tool
**********************************************************/

# Setup Command Interpreter
$pathCMD = $_SERVER['SystemRoot'] . "\\System32";
$CMDEXE = $pathCMD . "\\" . "cmd.exe";
#$pingHost = "localhost";
#$aPingCmd = "ping.exe -n 4 -6 ";
$pingHost = "google.com";
$aPingCmd = "ping.exe -n 4 -4 ";
if( is_dir($pathCMD)) {
    if(is_file($CMDEXE)){
        $strValue = $aPingCmd . $pingHost;
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
    else {
        echo("\nA File " . $CMDEXE . " is not found.");
    }
}
else {
    echo("\nA Path " . $pathCMD . " is not Found.");
}
?>