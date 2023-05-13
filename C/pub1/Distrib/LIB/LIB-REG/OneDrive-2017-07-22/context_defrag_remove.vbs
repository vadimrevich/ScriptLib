'context_defrag_remove.vbs - Removes Defrag from the right click context menu
'© Doug Knox - 5/07/2002
'Downloaded from www.dougknox.com

Option Explicit
On Error Resume Next

'Declare variables
Dim WSHShell, p1, p2

'Set the Windows Script Host Shell and assign values to variables
Set WSHShell = WScript.CreateObject("WScript.Shell")

p1 = "HKEY_CLASSES_ROOT\Drive\Shell\Defrag\"
p2 = "HKEY_CLASSES_ROOT\Drive\Shell\Defrag\command\"

WshShell.RegDelete p2
WshShell.RegDelete p1

MsgBox "Defrag has been removed from the Context Menu.", 4096,"Done!"