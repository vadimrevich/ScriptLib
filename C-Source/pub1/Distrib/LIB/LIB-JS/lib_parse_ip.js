/* ********************************************************
 * parse_ip.js
 * A JSCRIPT file with functions to parse IPv4 addresses
 * from a string
**********************************************************/

function TestIPv4( aString ) {
    var ipv4Regex = /^(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
    var bRes;
    bRes = ipv4Regex.test(aString);
    return bRes;
}

function ExtractIPv4(aString) {
    var ipv4RegexG = /(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/g;
    var strRes;
    strRes = aString.match(ipv4RegexG);
    if( strRes == null || strRes.length == 0)
    {
        return "";
    }
    else {
        return strRes;
    }
}

function TestIPv6(aString) {
    var regex = /^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/;
    var bRes;
    bRes = regex.test(aString);
    return bRes;
}

function ExtractIPv6(aString) {
    var ipv6RegexG = /(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))/g;
    var strRes;
    strRes = aString.match(ipv6RegexG);
    if( strRes == null || strRes.length == 0)
    {
        return "";
    }
    else {
        return strRes;
    }
}

function TestMACAddr( aString ) {
    var ipv4Regex = /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/;
    var bRes;
    bRes = ipv4Regex.test(aString);
    return bRes;
}

function ExtractMACAddr(aString) {
    var ipv4RegexG = /([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})/g;
    var strRes;
    strRes = aString.match(ipv4RegexG);
    if( strRes == null || strRes.length == 0)
    {
        return "";
    }
    else {
        return strRes;
    }
}


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

// ********************************************************

function parse_ip000() {
    var arg = GetFirstArg();
    var bRes;
    if( arg.length == 0 ) {
        WScript.Echo("false");
        WScript.Quit(1);
    }
    bRes = TestIPv4(arg);
    if( bRes ) {
        WScript.Echo("true");
        WScript.Quit(0);
    }
    else {
        WScript.Echo("false");
        WScript.Quit(1);
    }
}

//parse_ip000();