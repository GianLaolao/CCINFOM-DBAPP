<%-- 
    Document   : getslots
    Created on : 11 17, 23, 10:07:08 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>

<jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
    <%
        String selectedStreet = request.getParameter("street");
        if (selectedStreet != null && !selectedStreet.isEmpty()) {
        // Retrieve the selected country parameter from the request
        
        A.parkingspace_street = selectedStreet;
        A.get_slots();


        %>
            <option value="">Select Slot</option>
        <%
        
            // Output the cities as options in the response
            for (int slot : A.parking_noList) {
        %>
                <option value="<%= slot %>"><%= slot %></option>
        <%
            }
        }
        %>
