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
    MM_editCmd.CommandText = "DELETE FROM Product_Table WHERE ID = ?"
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 5, 1, -1, Request.Form("MM_recordId")) ' adDouble
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
Dim Recordset_PDT
Dim Recordset_PDT_cmd
Dim Recordset_PDT_numRows

Set Recordset_PDT_cmd = Server.CreateObject ("ADODB.Command")
Recordset_PDT_cmd.ActiveConnection = MM_cms_conn_a_STRING
Recordset_PDT_cmd.CommandText = "SELECT * FROM Product_Table ORDER BY ID ASC" 
Recordset_PDT_cmd.Prepared = true

Set Recordset_PDT = Recordset_PDT_cmd.Execute
Recordset_PDT_numRows = 0
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
  <table width="100%%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td><table width="100%%" border="0" cellspacing="0" cellpadding="0">
        <% 
While ((Repeat1__numRows <> 0) AND (NOT Recordset_PDT.EOF)) 
%>
          <tr>
            <td width="100"><img src="<%=(Recordset_PDT.Fields.Item("Picture_URL").Value)%>" /></td>
            <td width="100"><%=(Recordset_PDT.Fields.Item("ID").Value)%></td>
            <td width="100"><%=(Recordset_PDT.Fields.Item("Product_Name").Value)%></td>
            <td width="100"><%=(Recordset_PDT.Fields.Item("Description").Value)%></td>
            <td width="100"><%=(Recordset_PDT.Fields.Item("Price").Value)%></td>
            <td width="100"><%=(Recordset_PDT.Fields.Item("Category").Value)%></td>
            <td width="50"><a href="wosg_pdt_edit.asp?id=<%=(Recordset_PDT.Fields.Item("ID").Value)%>">Edit</a></td>
            <td width="50"><form ACTION="<%=MM_editAction%>" METHOD="POST" name="form_del">
              <input type="hidden" name="MM_delete" value="form_del" />
              <input type="hidden" name="MM_recordId" value="<%= Recordset_PDT.Fields.Item("ID").Value %>" />
              <input type="submit" name="Del" id="Del" value="Del" />
            </form></td>
          </tr>
          <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  Recordset_PDT.MoveNext()
Wend
%>

            </table></td>
    </tr>
    <tr>
    <td>&nbsp;
    
    </td>
    </tr>
<tr>
<td>
  <a href="wosg_pdt_add.asp">Add</a></td>
</tr>
  </table>

</body>
</html>
<%
Recordset_PDT.Close()
Set Recordset_PDT = Nothing
%>