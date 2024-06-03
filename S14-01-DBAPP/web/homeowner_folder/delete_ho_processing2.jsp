<%-- 
    Document   : delete_ho_processing2
    Created on : 11 11, 23, 10:38:00 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Homeowner Record Processing</title>
    </head>
    <body>
        <form action="ho_index.html">
            <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
            <%  
                int s = h.delete_homeowner();
                if (s==1) {
            %>
                <h1> Record has been Deleted.</h1>
            <% } else { %>
                <h1>Record cannot be Deleted. Record used in other Tables.</h1>
            <% } %>
            
            <input type="submit" value="Homeowner Menu"><br>
        </form> 
        <button onclick="location.href='delete_ho.html'" type="button"> Delete Homeowner Record </button>
    </body>
</html>
