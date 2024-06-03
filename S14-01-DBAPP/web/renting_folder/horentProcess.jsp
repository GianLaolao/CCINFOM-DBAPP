<%-- 
    Document   : horentProcess
    Created on : 11 13, 23, 11:46:27 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Homeowner Rent Process</title>
    </head>
    <body>
        <jsp:useBean id="P"  class="tables_package.rent_pspace" scope="session" />
        <%
            String hoID = request.getParameter("hoInput");
            int slot = Integer.parseInt(request.getParameter("parking_No"));
            String street = request.getParameter("street");
            P.ho_id = Integer.parseInt(hoID);
            P.parkingspaceno = slot;
            P.spaceSt = street;
            P.price = P.getRent();
            int status1 = P.checkSpace(slot, street);
            if (status1 == 1){
                int status = P.rentho_space();
                if (status == 1){
            %>      
                <h1>Renting Process Successful!</h1>
                Your Renting Information: <br>
                Rent ID:<%=P.rentid %> <br>
                Tenant ID: <%=P.tenantid %> <br>
                Parking Space Number: <%=P.parkingspaceno %> <br>
                Parking Space Street: <%=P.spaceSt%> <br>            
                Rent Price: <%=P.price%> <br>
                <%    
                } else {
            %>
                <h1>Renting Process Failed!</h1>
            <%
                }
            } else {
        %>
                <h1>Wrong Input!</h1>
        <%
            }
        %>
         <button onclick="location.href='rentIndex.html'" type="button">
                Home </button>
    </body>
</html>
