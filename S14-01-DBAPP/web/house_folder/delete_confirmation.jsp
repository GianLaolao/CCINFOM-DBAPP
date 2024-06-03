<%-- 
    Document   : delete_confirmation
    Created on : 11 21, 23, 9:59:13 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirm Deletion</title>
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
            house h = new house();
            String street = request.getParameter("street");
            int homeownerid = Integer.valueOf(request.getParameter("homeownerid"));
            int houseno = Integer.valueOf(request.getParameter("houseno"));
            int houseid = Integer.valueOf(request.getParameter("houseid"));
            
            int status = h.deleteHouse(houseid);
            
            if(status == 1){
                %><h1>Successfully Deleted House Record</h1><br><br>
                <h2>Viewing Deleted Record...</h2><br>
                <table style="width: 70%">
                    <tr>
                        <th style="padding-bottom: 15px">House ID</th>
                        <th style="padding-bottom: 15px">House Number</th>
                        <th style="padding-bottom: 15px">Homeowner ID</th>
                        <th style="padding-bottom: 15px">Street</th>
                    </tr>
                    
                    <tr>
                        <th><%=houseid%></th>
                        <th><%=houseno%></th>
                        <th><%=homeownerid%></th>
                        <th><%=street%></th>
                    </tr>
                </table>
                
                <br><br>
                <button onclick="location.href='h_index.html'" type="button">Return to Menu</button>
                <button onclick="location.href='delete_house.jsp'" type="button">Delete Another Record</button>
            <%}else{
            %><h1>Error in deleting record</h1>
            <%}%>
    </body>
</html>
