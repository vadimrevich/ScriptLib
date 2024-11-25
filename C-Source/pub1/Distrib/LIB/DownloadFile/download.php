<!--Threaded Script to .lnk Downloads -->
<?php

//Define allowed HTTP methods
define('ALLOW_POST', true);
define('ALLOW_GET', true);

//Prefix to downloading file variable (file is default variable name)
define('DOWNLOAD_FIELD', 'file');

####################################################################
# Functions
####################################################################

/**
 * Read GET or POST parameter from the super globals.
 * Checks if parameter/field is set and has the option to
 * return a default value if the parameter is not set.
 * If you don't set a default value and a parameter is not set,
 * this will return the default value (null)
 *
 * @param string $field
 * @param string $default
 * @return string|null param value or default
 */
function readParam($field, $default = null) {
    //Variable auf default Wert setzen
    $var = $default;

    //Überprüfen, ob das Feld als POST oder GET Parameter existiert
    //und gesetzt ist.
    if (ALLOW_POST && isset($_POST[$field]) && $_POST[$field] != '') {
        $var = $_POST[$field];
    } else if (ALLOW_GET && isset($_GET[$field]) && $_GET[$field] != '') {
        $var = $_GET[$field];
    }
    return $var;
}


/**
 * Rewrited function
 * Validate if the file exists and if
 * there is a permission (download dir) to download this file
 *
 * You should ALWAYS call this method if you don't want
 * somebody to download files not intended to be for the public.
 *
 * @param string $file GET parameter
 * @return bool true if validation was successfull
 */
function validate($file) {

    //check if file exists
    if (!isset($file)) {
	echo "<p>Field $file not set.<p>";
	return false;
    }
    if( empty($file) ) {
	echo "<p>Field $file is empty.<p>";
	return false;
    }
    if (!file_exists($file)) {
	echo "<p>File $file does not exists.<p>";
        return false;
    }

    return true;
}

/**
 * Download function.
 * Sets the HTTP header and supplies the given file
 * as a download to the browser.
 *
 * @param string $file path to file
 */
function download($file) {

    //Parse information
    $pathinfo = pathinfo($file);
    $extension = strtolower($pathinfo['extension']);
    $mimetype = null;
    $filaname = basename($file);
    $filesize = filesize($file);

    $mimetype = "application/octet-stream";

    // Required for some browsers like Safari and IE
    if (ini_get('zlib.output_compression')) {
        ini_set('zlib.output_compression', 'Off');
    }

    //Set header
    header('Pragma: public');
    header('Expires: 0');
    header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
    header('Cache-Control: private', false); // required for some browsers
    header('Content-Type: '.$mimetype);
    header('Content-Disposition: attachment; filename="'.$filaname.'";');
    header('Content-Transfer-Encoding: binary');
    header('Content-Length: '.$filesize);

    ob_clean();
    flush();
    readfile($file);
}

####################################################################

$file = readParam(DOWNLOAD_FIELD);

if (!validate($file)) {
    die('Download failed.');
}

download($file);

?>