' ***********************************************************
' �������� �������� ��������, ��������,
' ��������� ��������� ��������� �� ��������� ������
' osnastki.vbs
' ***********************************************************
Option Explicit
    Dim f, t, mmc_box, Button_Open
    Dim WshShell, WSO
'******************************************************************
' ������� ������ �� �������
Set WshShell = WScript.CreateObject("Wscript.Shell")
Set WSO = WScript.CreateObject("Scripting.WindowSystemObject")
'*******************************************************************
' ������� �����
Set f = WSO.CreateForm(0, 0, 0, 0, WSO.Translate("WS_CONTROLBOX | WS_MINIMIZEBOX"))
    f.Text = "�������� �������� Windows"
    f.ClientWidth = 400
    f.ClientHeight = 100
    f.CenterControl()
'***********************************************************************
' �������� �����
' ��������� �����
    f.TextOut 10,10,"������ ��������:"
' ������
Set mmc_box = f.CreateComboBox(120,10,140,20,WSO.Translate("CBS_DROPDOWNLIST"))
    mmc_box.add("��������� ���������")
    mmc_box.add("���������� �����������")
    mmc_box.add("�������������� �����")
    mmc_box.add("������ �������")
    mmc_box.add("������ Windows")
    mmc_box.ItemIndex=0
'������ �������� ��������, ��������,
' ��������� ��������� �� ��������� ������
Set Button_Open = f.CreateButton(280,10,100,25,"�������")
    Button_Open.OnClick = Getref("Open_mmc")
Set t = f.CreateHyperLink(130,40,250,25,"www.scriptcoding.ru")
    f.Show()
WSO.Run()
' ������� ��� �������� ��������, ��������
' ��������� ��������� ����� ��������� ������
Function Open_mmc()
    Dim mmc
    Select case(mmc_box.ItemIndex)
        Case 0
            mmc = "devmgmt.msc"
        Case 1
            mmc = "compmgmt.msc"
        Case 2
            mmc = "dfrg.msc"
        Case 3
            mmc = "eventvwr.msc"
        Case else
            mmc = "services.msc"
    End select
    WshShell.Run "mmc " & mmc
End function
