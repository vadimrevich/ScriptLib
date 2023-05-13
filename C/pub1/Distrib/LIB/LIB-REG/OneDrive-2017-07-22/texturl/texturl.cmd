@echo off
@echo ^<form name=a^>^<textarea^ name=a1^>^</textarea^> >%windir%\Web\texturl.htm
@echo ^<SCRIPT language=javascript defer^> >>%windir%\Web\texturl.htm
@echo //Если не хотите, чтоб показывалось уведомление об успешном копировании >>%windir%\Web\texturl.htm
@echo //установите значение параметра showConfirm равным 0 >>%windir%\Web\texturl.htm
@echo var showConfirm=^0>>%windir%\Web\texturl.htm
@echo var oExtArgs=external.menuArguments;>>%windir%\Web\texturl.htm
@echo var sLink=oExtArgs.event.srcElement;>>%windir%\Web\texturl.htm
@echo if(sLink=='')(sLink='Нет удалось получить название');>>%windir%\Web\texturl.htm
@echo var oTarget=document.a.a1;>>%windir%\Web\texturl.htm
@echo oTarget.value='[url='+sLink+']'+oExtArgs.event.srcElement.innerText+'[/url]';>>%windir%\Web\texturl.htm
@echo oTarget.select();>>%windir%\Web\texturl.htm
@echo var oTextRange=oTarget.createTextRange();>>%windir%\Web\texturl.htm
@echo oTextRange.execCommand('copy');>>%windir%\Web\texturl.htm
@echo if(showConfirm)(oExtArgs.alert(oTarget.value+'\r\n\nСсылка скопирована в буфер обмена'));>>%windir%\Web\texturl.htm
@echo ^</SCRIPT^>>>%windir%\Web\texturl.htm
@echo Windows Registry Editor Version 5.00>"%temp%\texturl.reg"
@echo [HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\MenuExt\Копировать ссылку с текстом]>>"%temp%\texturl.reg"
set foldpath=@="%windir%\web\texturl.htm"
set foldpath=%foldpath:\=\\%
@echo %foldpath%>>"%temp%\texturl.reg"
@echo "contexts"=dword:00000022>>"%temp%\texturl.reg"
regedit /s "%temp%\texturl.reg"