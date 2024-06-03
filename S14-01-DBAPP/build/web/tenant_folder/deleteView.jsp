<%-- 
    Document   : deleteView
    Created on : 11 16, 23, 10:43:17 PM
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
        <form action="deleteProcess.jsp">
            <%
                int tID = Integer.parseInt(request.getParameter("tenantInput"));
                int status = T.getDistinctInfo(tID);
                
                if (status == 1){
                %>
                <h1> Tenant's Information</h1> <br>
                Tenant ID: <%= T.tenantid%> <br>
                First Name: <%= T.fname %> <br>
                Last Name: <%= T.lname %> <br>
                House Number: <%=T.houseid %> <br>
                <input type="hidden" id="tenantInput" name="tenantInput" value="<%=tID%>">
                <button onclick="location.href='deleteTenant.jsp'" type="button">
                Cancel </button>
                <input type="submit" id="submitTenant" name="submit" value="Delete">
                <%
                } else {
                    %>
                    <h1>No Record of Tenant with such ID</h1> <br>
                    <button onclick="location.href='deleteTenant.jsp'" type="button">
                Cancel </button>
                    <button onclick="location.href='tenantindex.html'" type="button">
                Home </button>
                    <%
                } 
                    %>
        </form>
    </body>
</html>
