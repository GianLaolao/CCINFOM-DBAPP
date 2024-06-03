<%-- 
    Document   : deletehouse_processing
    Created on : 11 13, 23, 8:31:16 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete House Record</title>
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
            tenants t = new tenants();
            
            int houseid = Integer.valueOf(request.getParameter("houseid"));
            int status = h.getHouseRecord(houseid);
            
            int valid = 1;
            t.getTenantInfo();
            for(int i=0; i<t.tenant_houseNo.size(); i++){
                if(houseid == t.tenant_houseNo.get(i)){
                    valid = 0;
                }
            }
            
            
            if(valid == 0){
                %><h1>Cannot delete record</h1><br><br>
                <button onclick="location.href='h_index.html'" type="button">Return to Menu</button>
                <button onclick="location.href='delete_house.jsp'" type="button">Back</button>
            <%}else if(status == 1 && valid == 1){
            %> <h1>Viewing Old Record...</h1><br><br>
                <form action="delete_confirmation.jsp">
                    <table style="width: 70%">
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
                <br><br>
                
                <input type="hidden" name="houseid" value="<%=h.houseid%>">
                <input type="hidden" name="houseno" value="<%=h.houseno%>">
                <input type="hidden" name="homeownerid" value="<%=h.homeownerid%>">
                <input type="hidden" name="street" value="<%=h.street%>">
                
                <button onclick="location.href='h_index.html'" type="button">Return to Menu</button>
                <button onclick="location.href='delete_house.jsp'" type="button">Back</button>
                <input type="submit" id="submit" name="submit" value="Delete">
                </form>
            <%}else{
            %> <h1>No record found</h1>
                <button onclick="location.href='h_index.html'" type="button">Return to Menu</button>
                <button onclick="location.href='delete_house.jsp'" type="button">Back</button>
            <%}%>
    </body>
</html>
