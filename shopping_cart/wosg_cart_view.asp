<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include FILE="wosg_func.asp"-->
<%
Option Explicit
dim VSum
dim Vi

VSum=CInt(Get_Info("num",0,0))
%> 
<html><title>Shopping Cart View</title>

<form name="form1" method="post" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>Total:<%=VSum+1%></td>
    <td><a href="wosg_buy_exec.asp?action=empty">Empty</a></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td>Description</td>
        <td>Unit Price</td>
        <td>Quantity</td>
        <td>Amount</td>
      </tr>
<%
if VSum=-1 then
		response.Write("<tr><td>Empty</td></tr>")		
	else
		for Vi=0 to VSum
			response.Write("<tr>")
			response.Write("<td>" & Get_Info("id",Vi,"name") & "</td>")
			response.Write("<td>" & CStr(Get_Info("id",Vi,"price")) & "</td>")
			response.Write("<td>" & "<input type=""text"" name=""IB_" & Vi & """ id=""IB_" & CStr(Vi) & """ value=""" & Get_Info("id",Vi,"qtty") & """>" & "</td>")
			response.Write("<td>" & CStr(Get_Info("id",Vi,"amount")) & "</td>")
			response.Write("</tr>")
		next 
end if
%>
      

    </table></td>
  </tr>
    <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</form>

</html>