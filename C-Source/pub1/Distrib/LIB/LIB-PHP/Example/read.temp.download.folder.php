#!php.exe
<?php
/**********************************************************
 * read.temp.download.folder
**********************************************************/
function getDownloadsFolder() {
    $SHCU_NODE = "HKCU\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders\\";
    $FO_Downloads = "{374DE290-123F-4565-9164-39C4925E467B}";
    $SHCU_Downloads = $SHCU_NODE . $FO_Downloads;
    $wscript = new COM('WScript.Shell');
    $a = $wscript->RegRead($SHCU_Downloads);
    if(is_dir($a))
        return $a;
    else
        return "";
}

function getTempFolder(){
    $FO_TEMP = $_SERVER['TEMP'];
    if(is_dir($FO_TEMP))
        return $FO_TEMP;
    else
        return "";
}

echo("\nDownloads Folder = " . getDownloadsFolder());
echo("\nTemprorary Folder = " . getTempFolder());
?>