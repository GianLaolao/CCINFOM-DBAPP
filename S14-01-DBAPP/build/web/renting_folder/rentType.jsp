<%-- 
    Document   : rentType
    Created on : 11 13, 23, 8:31:09 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Choose a Type</title>
    </head>
    <body>
        
            <h1> Select User Type</h1> <br>
            
            <button onclick="location.href='TenantRent.jsp'" type="button">
                Tenant </button>
            <button onclick="location.href='HomeownerRent.jsp'" type="button">
                Homeowner </button>
            
            <button onclick="location.href='rentIndex.html'" type="button">
                Cancel </button>
        
    </body>
</html>
