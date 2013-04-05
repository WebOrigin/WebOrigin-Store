<%@LANGUAGE="VBScript"%>
<!--#include FILE="Connections/db_conn.asp"-->
<%

Dim authToken, txToken
Dim query
Dim objHttp
Dim sQuerystring
Dim sParts, iParts, aParts
Dim sResults, sKey, sValue
Dim i, result
Dim firstName, lastName, itemName, mcGross, mcCurrency

'authToken = "dfYyGv1z4B2X9J5OiP4zZDmOvTm7-oYwahVru6ZkMDrmou9KuKlTuc7WI9y"

authToken = "LAl0n5OU97gzsIeCaExAZrEl1Vx_ACGISBiZdySuHCkV1JFx21C9BZVaMSe"

txToken = Request.Querystring("tx")

query = "cmd=_notify-synch&tx=" & txToken & "&at=" & authToken

set objHttp = Server.CreateObject("Microsoft.XMLHTTP")
'set objHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")

objHttp.open "POST", "http://www.paypal.com/cgi-bin/webscr", false
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
Case "mc_gross"
mcGross = sValue
Case "mc_currency"
mcCurrency = sValue
Case "address_city"
addresscity = sValue
Case "address_country"
addresscountry = sValue
Case "address_name"
addressname = sValue
Case "address_state"
addressstate = sValue
Case "address_street"
addressstreet = sValue
Case "address_zip"
addresszip = sValue
Case "payer_email"
payeremail = sValue
Case "contact_phone"
contactphone = sValue
Case "item_name"
itemname = sValue
Case "item_number"
itemnumber = sValue
Case "quantity"
quantity = sValue
Case "payment_date"
paymentdate = sValue
Case "payment_status"
paymentstatus = sValue
End Select
Next

Response.Write("<p><h3>Your order has been received.</h3></p>")
Response.Write("<b>Details</b><br>")
Response.Write("<li>Name: " & firstName & " " & lastName & "</li>")
Response.Write("<li>Amount: " & mcCurrency & " " & mcGross & "</li>")
Response.Write("<li>address_city: " & addresscity & "</li>")
Response.Write("<li>address_country: " & addresscountry & "</li>")
Response.Write("<li>address_name: " & addressname & "</li>")
Response.Write("<li>address_state: " & addressstate & "</li>")
Response.Write("<li>address_street: " & addressstreet & "</li>")
Response.Write("<li>address_zip: " & addresszip & "</li>")
Response.Write("<li>payer_email: " & payeremail & "</li>")
Response.Write("<li>contact_phone: " & contactphone & "</li>")
Response.Write("<li>item_name: " & itemname & "</li>")
Response.Write("<li>item_number: " & itemnumber & "</li>")
Response.Write("<li>quantity: " & quantity & "</li>")
Response.Write("<li>payment_date: " & paymentdate & "</li>")
Response.Write("<li>payment_status: " & paymentstatus & "</li>")
Response.Write("<hr>")
Else
'log for manual investigation
Response.Write("ERROR")
End If


Dim Update_Cn, StrSQL
Set Update_Cn = Server.CreateObject("ADODB.Connection")
Update_Cn.Open MM_db_conn_STRING
StrSQL = "INSERT INTO pm_tb(cus_Name,cus_Phone,cus_Email,cus_Address,Details,Pay_Date,Pay_Status) values ('" & firstName & " " & lastName & "','" & contactphone & "','" & payeremail & "','" & addressname & "  " & addressstreet & "  " & addresscity & "  " & addressstate & "  " & addresscountry & " " & addresszip & "','" & itemname & "  " & itemnumber & "  " & quantity & "','" & paymentdate & "','" & paymentstatus & "')"

Update_Cn.Execute StrSQL
Update_Cn.close
Set Update_Cn = Nothing


%>