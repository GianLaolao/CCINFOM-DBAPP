<%-- 
    Document   : deleteparking_processing
    Created on : 11 14, 23, 12:10:12 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete Parking Processing</title>
    </head>
    <body>
        <form action="ps_index.html">
            <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            <%
                int v_parkingspace_no = Integer.parseInt(request.getParameter("parkingspaceno"));
                String v_parkingspace_street = request.getParameter("street");
                A.parkingspace_street = v_parkingspace_street;
                A.parkingspace_no = v_parkingspace_no;
                int status = A.delete_parkingspace();

                if(status == 1) {
            %>
                    <h1>Delete Parking Space Successful</h1>
            <% } else {
            %>
                    <h1>Delete Parking Space Failed</h1>
            <% }
            %>
            <input type="submit" value="Back to Main Menu">
        </form>
            <button onclick="location.href='deleteparkingrecord.jsp'" type="button"> Delete Parking Space </button>
    </body>
</html>
