<%-- 
    Document   : deleteTenant
    Created on : 11 13, 23, 6:25:32 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete a Tenant Record</title>
        <style>
            input[type=number]{
                -moz-appearance: textfield;
            }
        </style>
    </head>
    <body>
        <form action="deleteView.jsp" autocomplete="off">
            <jsp:useBean id="T"  class="tables_package.tenants" scope="session" />
            Tenant ID: <input type="number" min="3000" max="9999" id="tenantInput" name="tenantInput" required>
            <br> <br>
            <button onclick="location.href='tenantindex.html'" type="button">
                Cancel </button>
            <input type="submit" id="submitTenant" name="submit" value="Submit">
        
        </form>
    </body>
</html>
