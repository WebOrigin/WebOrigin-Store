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
' *** Delete Record: construct a sql delete statement and execute it

If (CStr(Request("MM_delete")) = "form_del" And CStr(Request("MM_recordId")) <> "") Then

  If (Not MM_abortEdit) Then
    ' execute the delete
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cms_conn_a_STRING
    MM_editCmd.CommandText = "DELETE FROM Category_Table WHERE ID = ?"
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 5, 1, -1, Request.Form("MM_recordId")) ' adDouble
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
If (CStr(Request("MM_insert")) = "form_add") Then
  If (Not MM_abortEdit) Then
    ' execute the insert
    Dim MM_editCmd

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_cms_conn_a_STRING
    MM_editCmd.CommandText = "INSERT INTO Category_Table (Category_Name) VALUES (?)" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("Category_Name")) ' adVarWChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    'Dim MM_editRedirectUrl
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
Dim Recordset_CTG
Dim Recordset_CTG_cmd
Dim Recordset_CTG_numRows

Set Recordset_CTG_cmd = Server.CreateObject ("ADODB.Command")
Recordset_CTG_cmd.ActiveConnection = MM_cms_conn_a_STRING
Recordset_CTG_cmd.CommandText = "SELECT * FROM Category_Table ORDER BY ID ASC" 
Recordset_CTG_cmd.Prepared = true

Set Recordset_CTG = Recordset_CTG_cmd.Execute
Recordset_CTG_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
Recordset_CTG_numRows = Recordset_CTG_numRows + Repeat1__numRows
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="100%%" border="0" cellspacing="0" cellpadding="0">

        <% 
While ((Repeat1__numRows <> 0) AND (NOT Recordset_CTG.EOF)) 
%>
      <tr>
          <td width="40%"><%=(Recordset_CTG.Fields.Item("ID").Value)%></td>
          <td width="40%"><%=(Recordset_CTG.Fields.Item("Category_Name").Value)%></td>
          <td><a href="wosg_ctg_edit.asp?id=<%=(Recordset_CTG.Fields.Item("ID").Value)%>">Edit</a></td>
          <td>
          <form ACTION="<%=MM_editAction%>" name="form_del" METHOD="POST">
          <input type="hidden" name="MM_delete" value="form_del" />
          <input type="hidden" name="MM_recordId" value="<%= Recordset_CTG.Fields.Item("ID").Value %>" />
          <input type="submit" name="Del" id="Del" value="Del" />
          </form>           </td>
</tr>
          <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  Recordset_CTG.MoveNext()
Wend
%>

    </table></td>
  </tr>
  <tr>
  <td>&nbsp;</td>
  </tr>
  <tr>
    <td><form ACTION="<%=MM_editAction%>" name="form_add" METHOD="POST"><table width="100%%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      <td width="40%"></td>
        <td width="40%"><label>New Category
            <input type="text" name="Category_Name" id="Category_Name" />
        </label></td>
        <td><input name="Add" type="submit" id="Add" onclick="MM_validateForm('Category_Name','','R');return document.MM_returnValue" value="Add" /></td>
      </tr>
    </table>
        
<input type="hidden" name="MM_insert" value="form_add" />
    </form>
    </td>
  </tr>
</table>
</body>
</html>
<%
Recordset_CTG.Close()
Set Recordset_CTG = Nothing
%>
