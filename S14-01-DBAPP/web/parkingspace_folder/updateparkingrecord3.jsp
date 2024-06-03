<%-- 
    Document   : updateparkingrecord3
    Created on : 11 15, 23, 11:10:34 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Updates</title>
    </head>
    <body>
         <form action="updateparking_processing.jsp">
         <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            <%
                int status = 0; // status is false by default
                
                //old values
                double o_rent_price = Double.parseDouble(request.getParameter("o_rentprice"));
                String o_status     = request.getParameter("o_status");
                
                
                if(!request.getParameter("rent_price").isEmpty()) {
                    
                    int v_parkingspace_no    = Integer.parseInt(request.getParameter("parkingspaceno"));
                    String v_street          = request.getParameter("street");
                    //take the new values
                    double v_rent_price      = Double.parseDouble(request.getParameter("rent_price"));
                    String v_status          = request.getParameter("status");
                    
                    A.parkingspace_no        = v_parkingspace_no;
                    A.parkingspace_street    = v_street;
                    A.parkingspace_rentprice = v_rent_price;
                    A.parkingspace_status    = v_status;

            %>
                    <h1>Are you sure you want to update?</h1>
                    <h2>You are updating:</h2>
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
                    
                    <!-- Pass needed values to next page -->
                    <input type="hidden" name="parkingspaceno" value="<%= A.parkingspace_no        %>">  
                    <input type="hidden" name="street"         value="<%= A.parkingspace_street    %>">
                    <input type="hidden" name="rent_price"     value="<%= A.parkingspace_rentprice %>"> 
                    <input type="hidden" name="status"         value="<%= A.parkingspace_status    %>"> 
                    
                    <!-- Pass old values to next page -->
                    <input type="hidden" name="o_status"    value="<%= o_status     %>">
                    <input type="hidden" name="o_rentprice" value="<%= o_rent_price %>">
                    
                    <input type="submit" value="Update">
            <% } else { 
            %>
                    <h1>Could not verify: Rent Price is empty.</h1>
            <% }
            %>
         </form><br>
         <form action="updateparkingrecord.jsp"><input type="submit" value="Cancel"><br></form>
    </body>
</html>
