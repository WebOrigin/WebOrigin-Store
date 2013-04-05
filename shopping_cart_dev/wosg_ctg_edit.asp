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
If (CStr(Request("MM_update")) = "form_edit") Then
  If (Not MM_abortEdit) Then
    ' execute the update
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cms_conn_a_STRING
    MM_editCmd.CommandText = "UPDATE Category_Table SET Category_Name = ? WHERE ID = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("Category")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    Dim MM_editRedirectUrl
    MM_editRedirectUrl = "wosg_ctg_list.asp"
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
Dim Recordset_CTG__MMColParam
Recordset_CTG__MMColParam = "1"
If (Request.QueryString("id") <> "") Then 
  Recordset_CTG__MMColParam = Request.QueryString("id")
End If
%>
<%
Dim Recordset_CTG
Dim Recordset_CTG_cmd
Dim Recordset_CTG_numRows

Set Recordset_CTG_cmd = Server.CreateObject ("ADODB.Command")
Recordset_CTG_cmd.ActiveConnection = MM_cms_conn_a_STRING
Recordset_CTG_cmd.CommandText = "SELECT * FROM Category_Table WHERE ID = ?" 
Recordset_CTG_cmd.Prepared = true
Recordset_CTG_cmd.Parameters.Append Recordset_CTG_cmd.CreateParameter("param1", 5, 1, -1, Recordset_CTG__MMColParam) ' adDouble

Set Recordset_CTG = Recordset_CTG_cmd.Execute
Recordset_CTG_numRows = 0
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>

<body>
<form ACTION="<%=MM_editAction%>" name="form_edit" METHOD="POST">
<table width="100%%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><label>Category
        <input name="Category" type="text" id="Category" value="<%=(Recordset_CTG.Fields.Item("Category_Name").Value)%>" />
    </label></td>
  </tr>
  <tr>
    <td><input type="hidden" name="id" value="<%=Request.QueryString("id")%>" /></td>
  </tr>
  <tr>
    <td><label>
    <input type="submit" name="Submit" id="Submit" value="Submit" />
    </label></td>
  </tr>
</table>


<input type="hidden" name="MM_update" value="form_edit" />
<input type="hidden" name="MM_recordId" value="<%= Recordset_CTG.Fields.Item("ID").Value %>" />
</form>
</body>
</html>
<%
Recordset_CTG.Close()
Set Recordset_CTG = Nothing
%>
