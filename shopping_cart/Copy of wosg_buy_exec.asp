<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Option Explicit

dim Pd_Name
dim Price
dim Qtty_Input
dim Qtty

dim CL_Pd_Name
dim CL_Qtty
dim CL_Price
dim CL_I
dim CL_SQ

dim Si
dim Sii

private sub Get

Pd_Name=request("Product_Name")
Price=request("Price")
Qtty_Input=request("Quantity_Input")
Qtty=request("Quantity")

CL_Pd_Name=Split(request.Cookies("Cart")("List_Name"),"|")
CL_Qtty=Split(request.Cookies("Cart")("List_Qtty"),"|")
CL_Price=Split(request.Cookies("Cart")("List_Price"),"|")
CL_SQ=Split(request.Cookies("Cart")("List_SQ"),"|")

Sii=-1
CL_I=0



on error resume next

if CInt(request.Cookies("Cart")("Num"))>0 then
	for Si=0 to CInt(request.Cookies("Cart")("Num"))-1
		if Pd_Name=CL_Pd_Name(Si) then
			Sii=Si
			CL_I=CInt(CL_Qtty(Sii))
		end if
	next
end if
%>

<script language="vbscript">
if CInt(<%=Qtty_Input%>)+ CInt(<%=CL_I%>) > CInt(<%=Qtty%>) then
	Si=msgbox("We only have " & <%=Qtty%> & " stock of this item, if you like to place this order, please click OK to CONTINUE. Or you can click CANCEL to CANCEL the order.",1,"Sorry")	
	if Si=2 then
		history.back
	end if
end if
</script>

<%
if CInt(Qtty_Input)+CInt(CL_I) > CInt(Qtty) then
		Qtty_Input=CInt(Qtty)
	else
		Qtty_Input=CInt(Qtty_Input) + CInt(CL_I)
end if

if CInt(request.Cookies("Cart")("Num"))>0 and CInt(Sii)>-1 then
		CL_Qtty(Sii)=Qtty_Input
		for Si=0 to CInt(request.Cookies("Cart")("Num"))-1
			response.Cookies("Cart")("List_Qtty")=request.Cookies("Cart")("List_Qtty") & "|" & CL_Qtty(Si)
		next
	else
		response.Cookies("Cart")("Num")=CInt(request.Cookies("Cart")("Num"))+1
		response.Cookies("Cart")("List_Name")=request.Cookies("Cart")("List_Name") & "|" & Pd_Name
		response.Cookies("Cart")("List_Qtty")=request.Cookies("Cart")("List_Qtty") & "|" & CInt(Qtty_Input)
		response.Cookies("Cart")("List_Price")=request.Cookies("Cart")("List_Price") & "|" & Price
		response.Cookies("Cart")("List_SQ")=request.Cookies("Cart")("List_SQ") & "|" & CInt(Qtty)
end if


CL_Pd_Name=Split(request.Cookies("Cart")("List_Name"),"|")
CL_Qtty=Split(request.Cookies("Cart")("List_Qtty"),"|")
CL_Price=Split(request.Cookies("Cart")("List_Price"),"|")
CL_SQ=Split(request.Cookies("Cart")("List_SQ"),"|")

response.Write(request.Cookies("Cart")("Num") & "<br />")

response.Write(request.Cookies("Cart")("List_Name"))
response.Write("|")
response.Write(request.Cookies("Cart")("List_Qtty"))
response.Write("|")
response.Write(request.Cookies("Cart")("List_Price"))
response.Write("|")	
response.Write(request.Cookies("Cart")("List_SQ"))
response.Write("<br />")	

response.Write(Pd_Name)
	response.Write("*")
response.Write(Price)
	response.Write("*")
response.Write(Qtty)
	response.Write("*")
response.Write(Qtty_Input)
response.Write("===<br />")
response.Write(CL_Pd_Name)
	response.Write("*")
response.Write(CL_Price)
	response.Write("*")
response.Write(CL_Qtty)
	response.Write("*")
response.Write(CL_SQ)

%>