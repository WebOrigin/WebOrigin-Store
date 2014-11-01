<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include FILE="wosg_func.asp"--> 
<%
Option Explicit

dim si

SB_Name=request("Product_Name")
SB_Price=request("Price")
SB_Qtty=request("Quantity_Input")
SB_SQ=request("Quantity")
SB_Action=request("action")

select case LCase(SB_Action)
	case "empty"
		response.Cookies("Cart")("Name")=""
		response.Cookies("Cart")("Qtty")=""
		response.Cookies("Cart")("Price")=""
		response.Cookies("Cart")("SQ")=""
		response.Redirect("wosg_cart_view.asp")
		response.End()
end select

si=0

if Get_Info("name",SB_Name,"name") = "error" then
		if  CInt(SB_Qtty) > CInt(SB_SQ) then
				response.Cookies("Trans")("SB_Name")=SB_Name
				response.Cookies("Trans")("SB_SQ")=SB_SQ
				response.Cookies("Trans")("SB_Price")=SB_Price
				si=3
				response.Cookies("Trans")("si")=si				
			else
				Add_Info SB_Name,SB_Qtty,SB_Price,SB_SQ
				si=1
				response.Redirect("wosg_cart_view.asp")
		end if
	else
		Set_Info "name",SB_Name,"sq",SB_SQ
		if  CInt(Get_Info("name",SB_Name,"qtty")) + CInt(SB_Qtty) > CInt(SB_SQ) then
				response.Cookies("Trans")("SB_Name")=SB_Name
				response.Cookies("Trans")("SB_SQ")=SB_SQ
				si=2
				response.Cookies("Trans")("si")=si	
			else
				Set_Info "name",SB_Name,"qtty",CInt(Get_Info("name",SB_Name,"qtty")) + CInt(SB_Qtty)
				si=1
				response.Redirect("wosg_cart_view.asp")
		end if
end if
%>

<script language="vbscript">
	if CInt(<%=si%>)>1 then
		st=msgbox("We only have " & <%=SB_SQ%> & " stock of this item, if you like to place this order, please click OK to CONTINUE. Or you can click CANCEL to CANCEL the order.",1,"Sorry")	
		if st=1 then
				window.location="wosg_ob_ques.asp"
			else
				window.location="wosg_index.asp"
		end if
	end if
</script>