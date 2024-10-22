'XP_defrag.vbs - Adds Defrag to the right click context menu
'© Doug Knox - 9/23/2001

Option Explicit
On Error Resume Next

'Declare variables
Dim WSHShell, MyBox, p1, q1, t
Dim jobfunc

'Set the Windows Script Host Shell and assign values to variables
Set WSHShell = WScript.CreateObject("WScript.Shell")

p1 = "HKEY_CLASSES_ROOT\Drive\Shell\Defrag\command\"

q1="DEFRAG.EXE %1"

'Describe the funtion of the script for a dialog box

jobfunc = "Defrag has been added to the" & vbCR
jobfunc = jobfunc & "right click context menu in Explorer." & vbCR & vbCR
jobfunc = jobfunc & "This is an unconditional defragment."

'This section writes the correct values to the Registry

WSHShell.RegWrite p1, q1

t = "Confirmation"
MyBox = MsgBox (jobfunc, 4096, t)