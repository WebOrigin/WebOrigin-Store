<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/cms_conn_a.asp" -->
<%
Dim Recordset_PDT
Dim Recordset_PDT_cmd
Dim Recordset_PDT_numRows

Set Recordset_PDT_cmd = Server.CreateObject ("ADODB.Command")
Recordset_PDT_cmd.ActiveConnection = MM_cms_conn_a_STRING
Recordset_PDT_cmd.CommandText = "SELECT * FROM Product_Table ORDER BY ID DESC" 
Recordset_PDT_cmd.Prepared = true

Set Recordset_PDT = Recordset_PDT_cmd.Execute
Recordset_PDT_numRows = 0
%>
<%
Dim Recordset_PDT_CTG
Dim Recordset_PDT_CTG_cmd
Dim Recordset_PDT_CTG_numRows

Set Recordset_PDT_CTG_cmd = Server.CreateObject ("ADODB.Command")
Recordset_PDT_CTG_cmd.ActiveConnection = MM_cms_conn_a_STRING
Recordset_PDT_CTG_cmd.CommandText = "SELECT * FROM Category_Table" 
Recordset_PDT_CTG_cmd.Prepared = true

Set Recordset_PDT_CTG = Recordset_PDT_CTG_cmd.Execute
Recordset_PDT_CTG_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
Recordset_PDT_numRows = Recordset_PDT_numRows + Repeat1__numRows
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>

<body>
<table align="center" width="900" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="right"><form target="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="business" value="ben@weborigin.co.nz">
<input type="hidden" name="display" value="1">
<input type="image" src="https://www.paypal.com/en_GB/i/btn/btn_viewcart_LG.gif" border="0" name="submit" alt="">
<img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form></td>
  </tr>
  <tr>
    <td height="1" bgcolor="#333333"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  
<% 
While ((Repeat1__numRows <> 0) AND (NOT Recordset_PDT.EOF)) 
%>  
  <tr>
    
<td><table width="100%%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="50%"><form target="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post">  <table width="100%%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="50%" rowspan="2"><img src="<%=(Recordset_PDT.Fields.Item("Picture_URL").Value)%>" /></td>
            <td width="50%" height="250" valign="top">
              <p>Product Name:<%=(Recordset_PDT.Fields.Item("Product_Name").Value)%></p>
              <p>Price:USD <%=(Recordset_PDT.Fields.Item("Price").Value)%></p>
              <p>Description:<br />
                <%=(Recordset_PDT.Fields.Item("Description").Value)%></p>
              <p>Category:<%
While (NOT Recordset_PDT_CTG.EOF)
%><%If (CStr(Recordset_PDT_CTG.Fields.Item("ID").Value) = CStr((Recordset_PDT.Fields.Item("Category").Value))) Then Response.Write(Recordset_PDT_CTG.Fields.Item("Category_Name").Value)%>
<%
  Recordset_PDT_CTG.MoveNext()
Wend
If (Recordset_PDT_CTG.CursorType > 0) Then
  Recordset_PDT_CTG.MoveFirst
Else
  Recordset_PDT_CTG.Requery
End If
%></p>

<p>
<% 
dim li
dim lum
dim OR_Str
dim SP_Str
OR_Str=Recordset_PDT.Fields.Item("Model_A").Value
if len(OR_Str)>0 then
	SP_Str=split(OR_Str,"|") 
	lum=ubound(SP_Str)
	response.Write(SP_Str(0) & ":")
	response.Write("<select name=""Model_A"" id=""Model_A"">")
	for li= 1 to lum
		response.Write("<option value=""" & SP_Str(li) & """>" & SP_Str(li) & "</option>")
	next
	response.Write("</select>")
end if
%>
</p>

<p>
<% 
OR_Str=Recordset_PDT.Fields.Item("Model_B").Value
if len(OR_Str)>0 then
	SP_Str=split(OR_Str,"|") 
	lum=ubound(SP_Str)
	response.Write(SP_Str(0) & ":")
	response.Write("<select name=""Model_B"" id=""Model_B"">")
	for li= 1 to lum
		response.Write("<option value=""" & SP_Str(li) & """>" & SP_Str(li) & "</option>")
	next
	response.Write("</select>")
end if
%>
</p>

<p>
<% 
OR_Str=Recordset_PDT.Fields.Item("Model_C").Value
if len(OR_Str)>0 then
	SP_Str=split(OR_Str,"|") 
	lum=ubound(SP_Str)
	response.Write(SP_Str(0) & ":")
	response.Write("<select name=""Model_C"" id=""Model_C"">")
	for li= 1 to lum
		response.Write("<option value=""" & SP_Str(li) & """>" & SP_Str(li) & "</option>")
	next
	response.Write("</select>")
end if
%>
</p>



            </td>
          </tr>
          <tr>
            <td valign="top">
              <input type="image" src="https://www.paypal.com/en_US/i/btn/btn_cart_LG.gif" border="0" name="submit2" alt="PayPal - The safer, easier way to pay online!" />
              <img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
<input type="hidden" name="add" value="1">
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="business" value="ben@weborigin.co.nz">
<input type="hidden" name="item_name" value="<%=(Recordset_PDT.Fields.Item("Product_Name").Value)%>">
<input type="hidden" name="item_number" value="1">
<input type="hidden" name="quantity" value="1">
<input type="hidden" name="item_number" value="1">
<input type="hidden" name="amount" value="<%=(Recordset_PDT.Fields.Item("Price").Value)%>">
<input type="hidden" name="no_note" value="1">
<input type="hidden" name="currency_code" value="NZD">
<input type="hidden" name="weight" value="1">
<input type="hidden" name="weight_unit" value="kgs">
<input type="hidden" name="lc" value="NZ">
<input type="hidden" name="bn" value="PP-ShopCartBF">
</td>
          </tr>
        </table>    </form></td>
        </tr>
    </table></td>
  </tr>
  
  <tr>
    <td>&nbsp;</td>
  </tr> 

    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  Recordset_PDT.MoveNext()
Wend
%>

  
  
  
  <tr>
    <td>&nbsp;</td>
  </tr>
  
  <tr>
    <td align="right"><form target="paypal" action="https://www.paypal.com/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_cart">
<input type="hidden" name="business" value="ben@weborigin.co.nz">
<input type="hidden" name="display" value="1">
<input type="image" src="https://www.paypal.com/en_GB/i/btn/btn_viewcart_LG.gif" border="0" name="submit" alt="">
<img alt="" border="0" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form></td>
  </tr>
  <tr>
  <td align="center">
  <br />
  <br />
  <a href="http://www.weborigin.co.nz/" target="_blank">Design by WebOrigin</a>  </td>
  </tr>
</table>
</body>
</html>
<%
Recordset_PDT.Close()
Set Recordset_PDT = Nothing
%>
<%
Recordset_PDT_CTG.Close()
Set Recordset_PDT_CTG = Nothing
%>
