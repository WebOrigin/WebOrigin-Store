<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="Connections/cms_conn_a.asp" -->
<%
Dim MM_editAction
MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
Dim MM_abortEdit
MM_abortEdit = false
%>
<%
' IIf implementation
Function MM_IIf(condition, ifTrue, ifFalse)
  If condition = "" Then
    MM_IIf = ifFalse
  Else
    MM_IIf = ifTrue
  End If
End Function
%>
<%
If (CStr(Request("MM_update")) = "form_add") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cms_conn_a_STRING
    MM_editCmd.CommandText = "UPDATE Product_Table SET Product_Name = ?, Picture_URL = ?, [Description] = ?, Price = ?, Category = ? WHERE ID = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("Product")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("Picture")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("editext")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 5, 1, -1, MM_IIF(Request.Form("Price"), Request.Form("Price"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 5, 1, -1, MM_IIF(Request.Form("Category"), Request.Form("Category"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "wosg_pdt_list.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
  End If
End If
%>
<%
Dim Recordset_PDT_CTG
Dim Recordset_PDT_CTG_cmd
Dim Recordset_PDT_CTG_numRows

Set Recordset_PDT_CTG_cmd = Server.CreateObject ("ADODB.Command")
Recordset_PDT_CTG_cmd.ActiveConnection = MM_cms_conn_a_STRING
Recordset_PDT_CTG_cmd.CommandText = "SELECT * FROM Category_Table ORDER BY ID ASC" 
Recordset_PDT_CTG_cmd.Prepared = true

Set Recordset_PDT_CTG = Recordset_PDT_CTG_cmd.Execute
Recordset_PDT_CTG_numRows = 0
%>
<%
Dim Recordset_PDT__MMColParam
Recordset_PDT__MMColParam = "1"
If (Request.QueryString("id") <> "") Then 
  Recordset_PDT__MMColParam = Request.QueryString("id")
End If
%>
<%
Dim Recordset_PDT
Dim Recordset_PDT_cmd
Dim Recordset_PDT_numRows

Set Recordset_PDT_cmd = Server.CreateObject ("ADODB.Command")
Recordset_PDT_cmd.ActiveConnection = MM_cms_conn_a_STRING
Recordset_PDT_cmd.CommandText = "SELECT * FROM Product_Table WHERE ID = ?" 
Recordset_PDT_cmd.Prepared = true
Recordset_PDT_cmd.Parameters.Append Recordset_PDT_cmd.CreateParameter("param1", 5, 1, -1, Recordset_PDT__MMColParam) ' adDouble

Set Recordset_PDT = Recordset_PDT_cmd.Execute
Recordset_PDT_numRows = 0
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- #INCLUDE file="fckeditor/fckeditor.asp" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<script type="text/javascript">
<!--
function MM_validateForm() { //v4.0
  if (document.getElementById){
    var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
    for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=document.getElementById(args[i]);
      if (val) { nm=val.name; if ((val=val.value)!="") {
        if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
          if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
        } else if (test!='R') { num = parseFloat(val);
          if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
          if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
            min=test.substring(8,p); max=test.substring(p+1);
            if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
      } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
    } if (errors) alert('The following error(s) occurred:\n'+errors);
    document.MM_returnValue = (errors == '');
} }
//-->
</script>
</head>

<body>
<table width="100%%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><form ACTION="<%=MM_editAction%>" METHOD="POST" id="form_add" name="form_add">
<table width="100%%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><label>Product
        <input name="Product" type="text" id="Product" value="<%=(Recordset_PDT.Fields.Item("Product_Name").Value)%>" />
    </label></td>
  </tr>
  <tr>
    <td><label>Picture
        <input name="Picture" type="text" id="Picture" value="<%=(Recordset_PDT.Fields.Item("Picture_URL").Value)%>" />
    </label></td>
  </tr>
  <tr>
    <td>
	<%
Dim oFCKeditor
Set oFCKeditor = New FCKeditor
oFCKeditor.BasePath = "/fckeditor/"
oFCKeditor.ToolbarSet = "Leask" 
oFCKeditor.Width = "700" 
oFCKeditor.Height = "500" 
oFCKeditor.Value =Recordset_PDT.Fields.Item("Description").Value
oFCKeditor.Create "editext" 
%>
    <!-- <input type="text" name="editext" id="editext" />-->  </td>
  </tr>
  <tr>
    <td>
        <label>Price
          <input name="Price" type="text" id="Price" value="<%=(Recordset_PDT.Fields.Item("Price").Value)%>" />
        </label>    </td>
  </tr>
  <tr>
    <td><label>Category
        <select name="Category" id="Category">
          <%
While (NOT Recordset_PDT_CTG.EOF)
%><option value="<%=(Recordset_PDT_CTG.Fields.Item("ID").Value)%>" <%If (Not isNull((Recordset_PDT.Fields.Item("Category").Value))) Then If (CStr(Recordset_PDT_CTG.Fields.Item("ID").Value) = CStr((Recordset_PDT.Fields.Item("Category").Value))) Then Response.Write("selected=""selected""") : Response.Write("")%> ><%=(Recordset_PDT_CTG.Fields.Item("Category_Name").Value)%></option>
          <%
  Recordset_PDT_CTG.MoveNext()
Wend
If (Recordset_PDT_CTG.CursorType > 0) Then
  Recordset_PDT_CTG.MoveFirst
Else
  Recordset_PDT_CTG.Requery
End If
%>
        </select>
    </label></td>
  </tr>
  <tr>
    <td><a href="wosg_ctg_list.asp" target="_blank">Category Edit</a></td>
  </tr>
  <tr>
    <td><label>
      <input name="Submit" type="submit" id="Submit" onclick="MM_validateForm('Product','','R','Price','','R');return document.MM_returnValue" value="Submit" />
    </label></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>


<input type="hidden" name="id" value="<%=Request.QueryString("id")%>" />    
<input type="hidden" name="MM_update" value="form_add" />
<input type="hidden" name="MM_recordId" value="<%= Recordset_PDT.Fields.Item("ID").Value %>" />
</form></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
<%
Recordset_PDT_CTG.Close()
Set Recordset_PDT_CTG = Nothing
%>
<%
Recordset_PDT.Close()
Set Recordset_PDT = Nothing
%>
