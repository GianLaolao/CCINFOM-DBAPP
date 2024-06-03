<%-- 
    Document   : viewparking_processing
    Created on : 11 15, 23, 12:15:50 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Parking Processing</title>
    </head>
    <body>
        <form action="viewparkingrecord.jsp">
            <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            <%
                int v_parkingspace_no = Integer.parseInt(request.getParameter("parkingspaceno"));
                String v_parkingspace_street = request.getParameter("street");

                A.parkingspace_no = v_parkingspace_no;
                A.parkingspace_street = v_parkingspace_street;
                int status = A.get_parkingrecord();
                
                if(status == 1) {
            %>
                    <h2>Record Found</h2>
                    <h3>Street:    <%= A.parkingspace_street    %></h3>
                    <h3>Slot:      <%= A.parkingspace_no        %></h3>
                    <h3>Status:    <%= A.parkingspace_status    %></h3>
                    <h3>Rent Price:<%= A.parkingspace_rentprice %></h3>
                    <input type="submit" value="Back">
            <% } else {
            %>
                    <h1>Record not found</h1><br>
                    <input type="submit" value="Back">
            <% }
            %>
        </form><br>
        <form action="ps_index.html"><input type="submit" value="Back to Main Menu"><br></form>
    </body>
</html>
