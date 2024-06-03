<%-- 
    Document   : updateparkingrecord2
    Created on : 11 13, 23, 8:12:00 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*" %>
<!DOCTYPE html>
<html>
    <head>
        <style>
            input[type=number] {
                -moz-appearance: textfield;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Parking Space</title>
    </head>
    <body>
        <h1>Update Parking Record</h1>
        <form action="updateparkingrecord3.jsp">
            <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            <%
                int v_parkingspace_no = Integer.parseInt(request.getParameter("parkingspaceno"));
                String v_parkingspace_street = request.getParameter("street");

                A.parkingspace_no = v_parkingspace_no;
                A.parkingspace_street = v_parkingspace_street;
                int status = A.get_parkingrecord();
                
                if(status == 1) {
            %>
                    <h3>Street: <%= A.parkingspace_street %></h3>
                    <h3>Slot:   <%= A.parkingspace_no     %></h3>
                    Status:<select id="status" name="status">
                        <option value="Occupied"  <%= (A.parkingspace_status.equals("Occupied"))?"selected":""  %> >Occupied </option>
                        <option value="Available" <%= (A.parkingspace_status.equals("Available"))?"selected":"" %> >Available</option>
                    </select><br>
                    Rent Price:<input type="number" id="rent_price" name="rent_price" value="<%= A.parkingspace_rentprice %>" min="0.00" max="9999.99" required><br>
                    
                    <!-- Pass needed values to nest page -->
                    <input type="hidden" name="parkingspaceno" value="<%= A.parkingspace_no     %>">  
                    <input type="hidden" name="street"         value="<%= A.parkingspace_street %>"> 
                    
                    <!-- Pass old values to next page -->
                    <input type="hidden" name="o_status"    value="<%= A.parkingspace_status    %>">
                    <input type="hidden" name="o_rentprice" value="<%= A.parkingspace_rentprice %>">
                    
                    <input type="submit" value="Update"><br>
            <% } else {
            %>
            <h1>Record not found</h1><br>
            <% }
            %>
        </form>
        <form action="updateparkingrecord.jsp"><input type="submit" value="Back"><br></form>
    </body>
</html>
