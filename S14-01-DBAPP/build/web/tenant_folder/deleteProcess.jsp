<%-- 
    Document   : deleteProcess
    Created on : 11 14, 23, 12:12:46 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Deleting a Tenant's Record</title>
    </head>
    <body>
        <jsp:useBean id="T"  class="tables_package.tenants" scope="session" />
        <%
            String tid = request.getParameter("tenantInput");
            T.getTenantInfo();
            try {    
                int status = T.deleteTenant(Integer.parseInt(tid));
                int status2 = 0;
                for (int i=0; i < T.tenantidList.size(); i++){
                    if (Integer.parseInt(tid)== T.tenantidList.get(i)){
                        status2 = 1;
                    }
                }
                if (status==1 && status2==1){
                    %>
                    <h1>Deleting a Tenant Record, Successful!</h1>
                    <% 
                } else{
                    %>
                    <h1>Deleting a Tenant Record, Failed!</h1>
                    <%
                }

                %>
                <button onclick="location.href='tenantindex.html'" type="button">
                Home </button> 
                <button onclick="location.href='deleteTenant.jsp'" type="button">
                Delete a Tenant's Record</button>
                <%
            } catch (Exception e){
                %>
                Invalid Input!
                <button onclick="location.href='tenantindex.html'" type="button">
                Home </button>
                <%
            }
            %>
            
    </body>
</html>
