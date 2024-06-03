<%-- 
    Document   : createparking_processing
    Created on : 11 12, 23, 11:35:48 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Parking Processing</title>
    </head>
    <body>
        <form action="ps_index.html">
            <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            <%
                int status = 0; // status is false by default
                if(!request.getParameter("rent_price").isEmpty()) {
                    double v_rent_price = Double.parseDouble(request.getParameter("rent_price"));
                    String v_street = request.getParameter("street");

                    A.parkingspace_street    = v_street;
                    A.parkingspace_rentprice = v_rent_price;

                    status = A.create_parkingspace();
                }
                

                if(status == 1) {
            %>
                    <h1>Create Parking Space Successful</h1><br>
                    <h2>Slot:       <%= A.parkingspace_no %></h2><br>
                    <h2>Street:     <%= A.parkingspace_street %></h2><br>
                    <h2>Status:     <%= A.parkingspace_status %></h2><br>
                    <h2>Rent Price: <%= A.parkingspace_rentprice %></h2><br>
            <% } else { 
            %>
                    <h1>Create Parking Space Failed</h1>
            <% }
            %>
            <input type="submit" value="Back to Main Menu">
        </form>
            <button onclick="location.href='createparkingrecord.jsp'" type="button"> Create Parking Space </button>
    </body>
</html>
