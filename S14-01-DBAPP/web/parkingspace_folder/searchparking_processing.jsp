<%-- 
    Document   : searchparking_processing
    Created on : 11 15, 23, 2:17:11 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*" %>
<!DOCTYPE html>
<html>
    <head>
        <style>
            table,
            th,
            td {
              padding: 10px;
              border: 1px solid black;
              border-collapse: collapse;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Parking Processing</title>
    </head>
    <body>
        <form action="searchparkingrecord.jsp">
            <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            <%
                int v_slot = -1;
                double v_rentprice = -1;
                String v_street = "0", v_status = "0";
                if(request.getParameter("parkingspaceno").isEmpty()) {
                    v_slot = -1;
                } else {
                    v_slot = Integer.parseInt(request.getParameter("parkingspaceno"));
                }
                if(request.getParameter("rent_price").isEmpty()) {
                    v_rentprice = -1;
                } else {
                    v_rentprice = Double.parseDouble(request.getParameter("rent_price"));
                }
                
                //there is a problem here
                if(request.getParameter("street").isEmpty()) {
                    v_street = "0";
                } else {
                    v_street = request.getParameter("street");
                }
                if(request.getParameter("status").isEmpty()) {
                    v_status = "0";
                } else {
                    v_status = request.getParameter("status");
                }
                
                A.parkingspace_no = v_slot;
                A.parkingspace_rentprice = v_rentprice;
                A.parkingspace_street = v_street;
                A.parkingspace_status = v_status;
                
                int status = A.search_parkingspaces();
                
                if(status == 1) {
            %>
                    <h2>Parking Space Records: </h2><br> 
                            <table>
                                <tr>
                                    <th>Slot</th>
                                    <th>Street</th>
                                    <th>Status</th>
                                    <th>Rent Price</th>
                                </tr>
                        <% for(int i=0; i<A.parking_noList.size(); i++) { %>
                                <tr>
                                    <th><%= A.parking_noList.get(i)        %></th>
                                    <th><%= A.parking_streetList.get(i)    %></th>
                                    <th><%= A.parking_statusList.get(i)    %></th>
                                    <th><%= A.parking_rentpriceList.get(i) %></th>
                                </tr>
                                <% }
                                %>
                            </table><br>
            
            <% } else {
            %>
                    <h2>Record/s not found.</h2>
            <% }
            %>
            <input type="submit" value="Back">
        </form>
        <form action="ps_index.html"><input type="submit" value="Back to Main Menu"><br></form>
    </body>
</html>
