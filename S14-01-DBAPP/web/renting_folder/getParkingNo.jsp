<%-- 
    Document   : getParkingNo
    Created on : 11 17, 23, 3:37:38 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
         <jsp:useBean id="S"  class="tables_package.rent_pspace" scope="session" />
         <%
            String street = request.getParameter("street");
            ArrayList<Integer> slotList = new ArrayList<> ();
            S.getAllRented();
            slotList = S.getSlots(street);
        %>

            <select id="parking_No" name="parking_No">
                <option value="0" selected>Select Parking Space Number</option>
        <%      
                for (int i = 0; i < slotList.size(); i++) {
                   
        %>
        <option value="<%=slotList.get(i) %>"><%= slotList.get(i) %></option>
        <%
                    
                }
        %>
</select>

    </body>
</html>
