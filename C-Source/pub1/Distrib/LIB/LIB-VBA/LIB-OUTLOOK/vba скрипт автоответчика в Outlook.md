# VBA скрипт автоответчика в Outlook

**Пример VBA-скрипта для автоматического ответа на электронные письма с исходным сообщением в Outlook**:

1.  Удерживать ALT + F11, чтобы открыть окно Microsoft Visual Basic для приложений. [1](https://ru.extendoffice.com/documents/outlook/5043-outlook-auto-reply-with-original-email.html)
2.  В этом окне дважды щёлкнуть панель «This OutlookSession from Proget1 (VbaProject.OTM)», чтобы открыть режим, а затем скопировать и вставить следующий код в пустой модуль. [1](https://ru.extendoffice.com/documents/outlook/5043-outlook-auto-reply-with-original-email.html)

```
Public WithEvents xlItems As Outlook.Items

Private Sub Application_Startup()
    Set xlItems = Session.GetDefaultFolder(olFolderInbox).Items
End Sub
Private Sub xlItems_ItemAdd(ByVal objItem As Object)
    Dim xlReply As MailItem
    Dim xStr As String
    If objItem.Class <> olMail Then Exit Sub
    Set xlReply = objItem.Reply
    With xlReply
        xStr = "<p>" & "Hi, Your email has been received. Thank you!" & "</p>"
        .HTMLBody = xStr & .HTMLBody
        .Send
    End With
End Sub
```

3.  Затем сохранить и закрыть окно кода, закрыть или перезапустить Outlook, чтобы код VBA вступил в силу. [1](https://ru.extendoffice.com/documents/outlook/5043-outlook-auto-reply-with-original-email.html)

После этого при получении электронных писем Outlook будет отправлять автоматический ответ с исходным сообщением. [1](https://ru.extendoffice.com/documents/outlook/5043-outlook-auto-reply-with-original-email.html)

