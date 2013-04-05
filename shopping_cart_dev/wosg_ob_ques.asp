<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include FILE="wosg_func.asp"--> 
<%
Option Explicit

dim si

SB_Name=request.Cookies("Trans")("SB_Name")
SB_SQ=request.Cookies("Trans")("SB_SQ")
SB_Price=request.Cookies("Trans")("SB_Price")
si=request.Cookies("Trans")("si")

select case si
	case 2
		Set_Info "name",SB_Name,"qtty",SB_SQ
	case 3
		Add_Info SB_Name,SB_SQ,SB_Price,SB_SQ
end select
response.Redirect("wosg_cart_view.asp")
%>
