<%-- 
    Document   : searchTenant
    Created on : 11 12, 23, 11:30:11 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            input[type=number]{
                -moz-appearance: textfield;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search by Filters</title>
    </head>
    <body>
        <form action="searchOutput.jsp">
            <jsp:useBean id="T"  class="tables_package.tenants" scope="session" />
            House ID:   <input type="number" id="houseNo" name="houseNo" value="0"><br>
            First Name: <input type="text" id="firstname" name="firstname" value="0"><br>
            Last Name:  <input type="text" id="lastname" name="lastname" value="0"><br>
            
            <button onclick="location.href='tenantindex.html'" type="button">
                Cancel </button>
            <input type="submit" id="submitTenant" name="submit" value="Submit">
        </form>
    </body>
</html>
