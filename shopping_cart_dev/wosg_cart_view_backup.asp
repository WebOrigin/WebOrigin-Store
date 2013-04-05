<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include FILE="wosg_func.asp"--> 
<html>
<%
'response.Cookies("Cart")("List_Name")=request.Cookies("Cart")("List_Name")

'response.Write(get_info("num",0,0))
'response.Cookies("Cart")("XXXX")=request.Cookies("Cart")("XXXX")& "Leask"
'response.Write(request.Cookies("Cart")("XXXX"))

'response.Write("Leask")
add_info "Leask_rrr",20,20,30



set_info "id",50,"Name","Baby"
'del_info "id",50
response.Write(get_info("id",50,"Name"))
response.Write(get_info("num",0,0))
'response.Write("Leask")
%>

</html>