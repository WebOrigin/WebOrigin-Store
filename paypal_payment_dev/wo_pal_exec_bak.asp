<%@LANGUAGE="VBScript"%>
<%

Dim authToken, txToken
Dim query
Dim objHttp
Dim sQuerystring
Dim sParts, iParts, aParts
Dim sResults, sKey, sValue
Dim i, result
Dim firstName, lastName, itemName, mcGross, mcCurrency

authToken = "OIxPInXv3Fo3P1dyGF3S6QCj-p56lxUkcrQzLfIePVczQH64Vn2Z4W7PdTC"

txToken = Request.Querystring("tx")

query = "cmd=_notify-synch&tx=" & txToken & "&at=" & authToken

'set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
objHttp.open "POST", "https://www.sandbox.paypal.com/cgi-bin/webscr", false
objHttp.setRequestHeader "Content-type", "application/x-www-form-urlencoded"
objHttp.Send query

sQuerystring = objHttp.responseText

If Mid(sQuerystring,1,7) = "SUCCESS" Then
sQuerystring = Mid(sQuerystring,9)
sParts = Split(sQuerystring, vbLf)
iParts = UBound(sParts) - 1
ReDim sResults(iParts, 1)
For i = 0 To iParts
aParts = Split(sParts(i), "=")
sKey = aParts(0)
sValue = aParts(1)
sResults(i, 0) = sKey
sResults(i, 1) = sValue

Select Case sKey
Case "first_name"
firstName = sValue
Case "last_name"
lastName = sValue
Case "item_name"
itemName = sValue
Case "mc_gross"
mcGross = sValue
Case "mc_currency"
mcCurrency = sValue
End Select
Next

Response.Write("<p><h3>Your order has been received.</h3></p>")
Response.Write("<b>Details</b><br>")
Response.Write("<li>Name: " & firstName & " " & lastName & "</li>")
Response.Write("<li>Description: " & itemName & "</li>")
Response.Write("<li>Amount: " & mcCurrency & " " & mcGross & "</li>")
Response.Write("<hr>")
Else
'log for manual investigation
Response.Write("ERROR")
End If

%>