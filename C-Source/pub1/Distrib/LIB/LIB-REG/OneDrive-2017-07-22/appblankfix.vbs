'-----------------------------------------------------------------------
'Copyright    : © 2006-2007 Ramesh Srinivasan
'Created on   : August 14, 2006
'Modified on  : March  14, 2007
'Description  : User Accounts applet fix (blank / showing raw HTML code)
'Homepage     : http://www.winhelponline.com & http://windowsxp.mvps.org
'Prerequisite : Windows XP / User account with administrative privileges
'-----------------------------------------------------------------------

Set WshShell = CreateObject("WScript.Shell")
Dim htacommand
htacommand = "%windir%\system32\mshta.exe " & chr(34) & "%1" & chr(34) & " %*"
On Error resume Next
WshShell.RegWrite "HKCR\.hta\", "htafile", "REG_SZ"
WshShell.RegWrite "HKCR\.hta\PerceivedType", "text", "REG_SZ"
WshShell.RegWrite "HKCR\.hta\Content Type", "application/hta", "REG_SZ"
WshShell.RegWrite "HKCR\htafile\", "HTML Application", "REG_SZ"
WshShell.RegWrite "HKCR\htafile\EditFlags", "1048576", "REG_DWORD"
WshShell.RegWrite "HKCR\htafile\DefaultIcon\", "%windir%\system32\mshta.exe,1", "REG_EXPAND_SZ"
WshShell.RegWrite "HKCR\htafile\Shell\Open\Command\", htacommand, "REG_EXPAND_SZ"
Wshshell.RUN ("regsvr32.exe mshtml.dll -i -s")
Wshshell.RUN ("regsvr32 themeui.dll -s")
Wshshell.RUN ("regsvr32 vbscript.dll -s")
'Wshshell.RUN ("regsvr32.exe shdocvw.dll -i -s")
Wshshell.RUN ("regsvr32.exe jscript.dll -s")
MsgUser = Msgbox ("Восстановлены завершено.", 4160, "Восстановление оснасток")
Set WshShell = Nothing

'-----------------------------------------------------------------------
' Copyright © 2006 by Ramesh Srinivasan. All rights reserved.

'     For more tips & help in Windows, visit my sites below:
' http://www.winhelponline.com  | http://windowsxp.mvps.org
'-----------------------------------------------------------------------