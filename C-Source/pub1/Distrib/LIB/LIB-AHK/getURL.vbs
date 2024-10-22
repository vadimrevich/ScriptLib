url = "http://www.google.com/"
url = "https://www.autohotkey.com/download/1.1/version.txt"
WScript.Echo url
WScript.Echo urlget(url)


Function URLGet(URL)
  Set Http = CreateObject("MSXML2.ServerXMLHTTP.6.0")
  Http.Open "GET",URL,false
  Http.Send
 URLGet = Http.responseText
End Function
