<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/cms_conn_a.asp" -->
<%
Dim Recordset_PDT__MMColParam
Recordset_PDT__MMColParam = "0"
If (Request("MM_EmptyValue") <> "") Then 
  Recordset_PDT__MMColParam = Request("MM_EmptyValue")
End If
%>
<%
Dim Recordset_PDT
Dim Recordset_PDT_cmd
Dim Recordset_PDT_numRows

Set Recordset_PDT_cmd = Server.CreateObject ("ADODB.Command")
Recordset_PDT_cmd.ActiveConnection = MM_cms_conn_a_STRING
Recordset_PDT_cmd.CommandText = "SELECT * FROM Product_Table WHERE Quantity > ? ORDER BY ID DESC" 
Recordset_PDT_cmd.Prepared = true
Recordset_PDT_cmd.Parameters.Append Recordset_PDT_cmd.CreateParameter("param1", 5, 1, -1, Recordset_PDT__MMColParam) ' adDouble

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
        <td width="50%"><form target="_self" action="wosg_buy_exec.asp" method="post">  <table width="100%%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="50%" rowspan="2"><img src="<%=(Recordset_PDT.Fields.Item("Picture_URL").Value)%>" /><input type="hidden" name="img" value="<%=(Recordset_PDT.Fields.Item("Picture_URL").Value)%>"></td>
            <td width="50%" height="250" valign="top">
              <p>Product Name:<%=(Recordset_PDT.Fields.Item("Product_Name").Value)%><input type="hidden" name="Product_Name" value="<%=(Recordset_PDT.Fields.Item("Product_Name").Value)%>"></p>
              <p>Price:NZD <%=(Recordset_PDT.Fields.Item("Price").Value)%><input type="hidden" name="Price" value="<%=(Recordset_PDT.Fields.Item("Price").Value)%>"></p>
              <p>Description:<br />
                <%=(Recordset_PDT.Fields.Item("Description").Value)%></p>
              <p>
                <label>Quantity:
                  <select name="Quantity_Input" id="Quantity_Input">
                    <option value="1" selected="selected">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option value="15">15</option>
                    <option value="16">16</option>
                    <option value="17">17</option>
                    <option value="18">18</option>
                    <option value="19">19</option>
                    <option value="20">20</option>
                  </select>
                </label>
                <input type="hidden" name="Quantity" value="<%=(Recordset_PDT.Fields.Item("Quantity").Value)%>">
              </p>
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
            </td>
          </tr>
          <tr>
            <td valign="top">
<input type="image" src="elements/btn_cart_LG.gif" border="0" name="submit2" alt="Buy Now" />
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
