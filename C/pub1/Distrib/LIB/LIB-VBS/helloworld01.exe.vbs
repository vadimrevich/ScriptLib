' *********************************************************
'
' helloworld01.exe.vbs
'
' Script runs helloworld01.exe file from local Download
' directory
'
' *********************************************************

Function HelloWorld01Exec()
	Dim tempPath, fso, bFlag
	' Define ActiveX Object
	Set fso = CreateObject( "Scripting.FileSystemObject" )
	bFlag =1
	tempPath = getTempEnviron()
	If tempPath <> "" Then
		bFlag = Copy_File( strFileNameHello, tempPath )
		If bFlag = 0 Then
			bFlag = Copy_File_Temp( strFileNameHello, "C:" )
			If bFlag = 0 Then
				RunDownloadedExe "C:", strFileNameHello, 90000
			End If
		End If
	End If
	HelloWorld01Exec = bFlag
End Function