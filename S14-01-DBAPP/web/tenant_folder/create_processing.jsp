<%-- 
    Document   : create_processing
    Created on : 11 12, 23, 3:13:12 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tenant Processing</title>
    </head>
    <body>
        <jsp:useBean id="T" class="tables_package.tenants" scope="session"/>
        
        
        <%
            String first_name   = request.getParameter("fname");
            String last_name    = request.getParameter("lname");
            int house_no        = Integer.parseInt(request.getParameter("houses"));
            
            T.fname = first_name;
            T.lname = last_name;
            T.houseid = house_no;
            int status = T.createTenant();
            if (status==1){
            %>
    <center>
            <h1>Creation of new Tenant Record, Successful!</h1> <br>
            Tenant ID: <%= T.tenantid%> <br>
            First Name: <%= T.fname%> <br>
            Last Name: <%= T.lname%> <br>
            House ID: <%= T.houseid%> <br>
    </center>
            <%  } else {
                %>
            <h1>Creation of new Tenant Record, Failure!</h1>
            <% } 
                %>
            <button onclick="location.href='createTenant.jsp'" type="button">
                Create Tenant </button>
            <button onclick="location.href='tenantindex.html'" type="button">
                Home </button>
    </body>
</html>
