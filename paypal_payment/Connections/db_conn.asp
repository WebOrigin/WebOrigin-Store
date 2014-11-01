<%
' FileName="Connection_ado_conn_string.htm"
' Type="ADO" 
' DesigntimeType="ADO"
' HTTP="true"
' Catalog=""
' Schema=""
Dim db
db="pp_pm_db.mdb"
Dim MM_db_conn_STRING
MM_db_conn_STRING = "Provider = Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(""&db&"")
%>
