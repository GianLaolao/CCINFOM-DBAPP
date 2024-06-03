<%-- 
    Document   : update_house
    Created on : 11 12, 23, 9:44:35 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View House Record</title>
    </head>
    <body>
        <style>
            table,
            th,
            td {
              padding: 10px;
              border: 1px solid black;
              border-collapse: collapse;
            }
        </style>
        
        <%
            int houseno = Integer.valueOf(request.getParameter("houseno"));
            house h = new house();
            h.getHouseRecord(houseno);
            
            if(h.houseno == 0){
                %> <h1>No Record Found</h1>
            <%}
            else{
                %><h1>Viewing Record...</h1>
        
                <table style="width:80%">
                    <tr>
                        <th style="padding-bottom: 15px">House ID</th>
                        <th style="padding-bottom: 15px">House Number</th>
                        <th style="padding-bottom: 15px">Homeowner ID</th>
                        <th style="padding-bottom: 15px">Street</th>
                    </tr>

                    <tr>
                        <th><%=h.houseid%></th>
                        <th><%=h.houseno%></th>
                        <th><%=h.homeownerid%></th>
                        <th><%=h.street%></th>
                    </tr>
                </table>
            <%}%>
                <br><br>
        
        <button onclick="location.href='view_house.jsp'" type="button">View Another Record</button>
        <button onclick="location.href='h_index.html'" type="button">Return to Menu</button>
    </body>
</html>
