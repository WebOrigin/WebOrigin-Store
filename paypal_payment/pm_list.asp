<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/db_conn.asp" -->
<%
Dim Recordset_PM
Dim Recordset_PM_cmd
Dim Recordset_PM_numRows

Set Recordset_PM_cmd = Server.CreateObject ("ADODB.Command")
Recordset_PM_cmd.ActiveConnection = MM_db_conn_STRING
Recordset_PM_cmd.CommandText = "SELECT * FROM pm_tb ORDER BY ID DESC" 
Recordset_PM_cmd.Prepared = true

Set Recordset_PM = Recordset_PM_cmd.Execute
Recordset_PM_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
Recordset_PM_numRows = Recordset_PM_numRows + Repeat1__numRows
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>

<body>
<table width="100%%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <% 
While ((Repeat1__numRows <> 0) AND (NOT Recordset_PM.EOF)) 
%>
    <tr>
      <td><%=(Recordset_PM.Fields.Item("ID").Value)%></td>
      <td><%=(Recordset_PM.Fields.Item("cus_Name").Value)%></td>
      <td><%=(Recordset_PM.Fields.Item("cus_Address").Value)%></td>
      <td><%=(Recordset_PM.Fields.Item("cus_Email").Value)%></td>
      <td><%=(Recordset_PM.Fields.Item("cus_Phone").Value)%></td>
      <td><%=(Recordset_PM.Fields.Item("Details").Value)%></td>
      <td><%=(Recordset_PM.Fields.Item("Pay_Date").Value)%></td>
      <td><%=(Recordset_PM.Fields.Item("Pay_Status").Value)%></td>
    </tr>
    <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  Recordset_PM.MoveNext()
Wend
%>
</table>
</body>
</html>
<%
Recordset_PM.Close()
Set Recordset_PM = Nothing
%>
