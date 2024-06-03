<%-- 
    Document   : updateTenant
    Created on : 11 12, 23, 5:39:09 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Tenant's Information</title>
        <style>
            input[type=number]{
                -moz-appearance: textfield;
            }
        </style>
    </head>
    <body>
        <form action="updateProcess.jsp">
            <jsp:useBean id="T"  class="tables_package.tenants" scope="session" />
            Tenant ID: <input type="number" min="3000" max="9999" id="tenantInput" name="tenantInput" required>
            <br> <br>
            <button onclick="location.href='tenantindex.html'" type="button">
                Cancel </button>
            <input type="submit" id="submitTenant" name="submit" value="Submit">
        
        </form>
    </body>
</html>
