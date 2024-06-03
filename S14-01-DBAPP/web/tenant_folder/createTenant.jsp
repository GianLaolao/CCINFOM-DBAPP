<%-- 
    Document   : createTenant
    Created on : 11 12, 23, 4:35:36 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Tenant</title>
    </head>
    <body>
        <form action="create_processing.jsp"> 
            <label for="fname">First name:</label><br>
            <input type="text" id="fname" name="fname" required><br>
            <label for="lname">Last name:</label><br>
            <input type="text" id="lname" name="lname" required> <br> <br>
            <jsp:useBean id="T"  class="tables_package.tenants" scope="session" />
            House ID: <select id="houses" name="houses" required>
            <%
                System.out.println("hi");
                T.availHouses();
                for (int i =0; i<T.hoa_houses.size(); i++){  
                    
            %>  
                <option value="<%=T.hoa_houses.get(i)%>"> <%=T.hoa_houses.get(i)%></option>
            <% } 
            %>
            </select> <br> <br>
            <button onclick="location.href='tenantindex.html'" type="button">
                Cancel </button>
            <input type="submit" id="submitTenant" name="submit" value="Submit">
        
        </form>
    </body>
</html>
