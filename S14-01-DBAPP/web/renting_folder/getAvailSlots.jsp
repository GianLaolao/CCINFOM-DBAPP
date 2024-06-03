<%-- 
    Document   : getAvailSlots
    Created on : 11 17, 23, 5:18:12 PM
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
         <%

            String street = request.getParameter("street");
            System.out.println("Selected Street: " + street);

            ArrayList<Integer> slots = new ArrayList<>();
            rent_pspace S = new rent_pspace();
            S.getSpaceInfo();
            slots = S.getSlots(street,1);

            System.out.println("Available Slots: " + slots);
        %>

            <select id="parking_No" name="parking_No">
                <option value="0" selected>Select Parking Space Number</option>
        <%      
                for (int i = 0; i < slots.size(); i++) {
                   
        %>
                <option value="<%=slots.get(i) %>"><%= slots.get(i) %></option>
        <%     
                }
        %>
            </select>
    </body>
</html>
