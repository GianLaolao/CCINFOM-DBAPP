<%-- 
    Document   : viewProcess
    Created on : 11 12, 23, 11:07:45 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tenant's Information</title>
        
    </head>
    <body>
        <jsp:useBean id="T"  class="tables_package.tenants" scope="session" />
        <%
            int tid = Integer.parseInt(request.getParameter("tenantInput"));
            T.getTenantInfo();
            int flag=0;
            for (int i =0; i<T.tenantidList.size(); i++) {
                if (T.tenantidList.get(i) == tid){
                    T.fname = T.tenant_fnameList.get(i);
                    T.lname = T.tenant_lnameList.get(i);
                    T.houseid = T.tenant_houseNo.get(i);
                    T.tenantid = T.tenantidList.get(i);
                    flag=1;
                }
            }
            if (flag==1){
                %>
                <h1> Tenant Information </h1>
                Tenant ID:      <%=T.tenantid%> <br>
                First Name:     <%=T.fname%>    <br>
                Last Name:      <%=T.lname%>    <br>
                House Number:   <%=T.houseid%>  <br>
                <br>
                <%
            } else {
                %>
                <h1> No Record found with such ID</h1>
                
                <%
            }
            %>
            <button onclick="location.href='viewTenant.jsp'" type="button">
                View Tenant </button>
            <button onclick="location.href='tenantindex.html'" type="button">
                Home </button>
        
    </body>
</html>
