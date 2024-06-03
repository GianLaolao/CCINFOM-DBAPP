<%-- 
    Document   : updateparking_processing
    Created on : 11 13, 23, 9:56:22 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Parking Processing</title>
    </head>
    <body>
        <form action="ps_index.html">
            <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            <%
                
                //old values
                double o_rent_price = Double.parseDouble(request.getParameter("o_rentprice"));
                String o_status = request.getParameter("o_status");
                    
                int v_parkingspace_no    = Integer.parseInt(request.getParameter("parkingspaceno"));
                String v_street          = request.getParameter("street");
                double v_rent_price      = Double.parseDouble(request.getParameter("rent_price"));
                String v_status          = request.getParameter("status");

                A.parkingspace_no        = v_parkingspace_no;
                A.parkingspace_street    = v_street;
                A.parkingspace_rentprice = v_rent_price;
                A.parkingspace_status    = v_status;

                int status = A.update_parkingspace();
                if(status == 1) {
            %>
                    <h1>Update Parking Space Successful</h1>
                    <h3>Street:      <%= A.parkingspace_street    %></h3>
                    <h3>Slot:        <%= A.parkingspace_no        %></h3>
                    <br>
                    <h2>Old Values:</h2>
                    <h3>Status:     <%= o_status     %></h3>
                    <h3>Rent Price: <%= o_rent_price %></h3>
                    <br>
                    <h2>New Values:</h2>
                    <h3>Status:     <%= A.parkingspace_status    %></h3>
                    <h3>Rent Price: <%= A.parkingspace_rentprice %></h3>
            <% } else { 
            %>
                    <h1>Update Parking Space Failed</h1>
            <% }
            %>
            <input type="submit" value="Back to Main Menu">
        </form>
            <button onclick="location.href='updateparkingrecord.jsp'" type="button"> Update Parking Space </button>
    </body>
</html>
