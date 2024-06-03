<%-- 
    Document   : yearlyparking_processing
    Created on : 11 15, 23, 9:40:42 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>

<!DOCTYPE html>
<html>
    <head>
        <style>
            th, td {
                text-align: center;
                border: 1px solid black;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yearly Parking Report Processing</title>
    </head>
    <body>
        <form action="yearlyparkingreport.jsp">
            <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            <%
                String v_street = "0";
                int v_slot = -1, v_year = -1, v_month = -1;

                if(request.getParameter("parkingspaceno").equals("")) {
                    v_slot = -1;
                } else {
                    v_slot = Integer.parseInt(request.getParameter("parkingspaceno"));
                }
                if(request.getParameter("street").equals("")) {
                    v_street = "0";
                } else {
                    v_street = request.getParameter("street");
                }
                if(request.getParameter("year").equals("")) {
                    v_year = -1;
                } else {
                    v_year = Integer.parseInt(request.getParameter("year"));
                }
                if(request.getParameter("month").equals("")) {
                    v_month = -1;
                } else {
                    v_month = Integer.parseInt(request.getParameter("month"));
                }
                
                
                A.get_months();
                
                A.parkingspace_no = v_slot;
                A.parkingspace_street = v_street;
                A.year = v_year;
                A.month = v_month;
                
                int status = A.generate_parkingreport();
                
                if(status == 1) {
            %>
                    <h2>Parking Space Records: </h2><br> 
                            <table>
                                <tr>
                                    <th>Slot</th>
                                    <th>Street</th>
                                    <th>Rent Year</th>
                                    <th>Rent Month</th>
                                    <th>Total Rentees</th>
                                </tr>
                        <% for(int i=0; i<A.parking_noList.size(); i++) { %>
                                <tr>
                                    <th><%= A.parking_noList.get(i)           %></th>
                                    <th><%= A.parking_streetList.get(i)       %></th>
                                    <th><%= A.parking_yearList.get(i)         %></th>
                                    <th><%= A.months.get(A.parking_monthList.get(i) - 1)        %></th>
                                    <th><%= A.parking_totalrenteesList.get(i) %></th>
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
        <form action="../index.html"><input type="submit" value="Back to Main Menu"><br></form>
    </body>
</html>
