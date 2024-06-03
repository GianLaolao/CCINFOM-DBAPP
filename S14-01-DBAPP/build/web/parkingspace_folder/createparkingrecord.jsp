<%-- 
    Document   : createparkingrecord
    Created on : 11 12, 23, 9:46:24 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            input[type=number] {
                -moz-appearance: textfield;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Parking Record</title>
    </head>
    <body>
        <h1>Create Parking Record</h1>
        <form action="createparking_processing.jsp">
            <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            Street:<select id="street" name="street">
                <%
                    A.get_refstreetList();
                    for(int i=0; i<A.refstreetList.size(); i++) {
                %>
                        <option value="<%=A.refstreetList.get(i)%>"><%=A.refstreetList.get(i)%></option>
                <% }
                %>
            </select><br>
            Rent Price:<input type="number" id="rent_price" name="rent_price" min="0.00" max="9999.99" required><br>
            <input type="submit" value="Create"><br>
        </form>
        <form action="ps_index.html"><input type="submit" value="Back to Main Menu"><br></form>
    </body>
</html>
