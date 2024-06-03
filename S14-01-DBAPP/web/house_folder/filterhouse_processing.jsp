<%-- 
    Document   : filterhouse_processing
    Created on : 11 13, 23, 9:17:13 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Filter House Record</title>
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
            int houseno = 0;
            int homeownerid = 0;
            String street = "";
            
            String check = request.getParameter("houseno");
            if(!check.equals("")){
                houseno = Integer.valueOf(request.getParameter("houseno"));
            }
            
            check = request.getParameter("homeownerid");
            if(!check.equals("")){
                homeownerid = Integer.valueOf(request.getParameter("homeownerid"));
            }
            
            check = request.getParameter("street");
            if(!check.equals("")){
                street = request.getParameter("street");
            }
            
            h.houseno = houseno;
            h.street = street;
            h.homeownerid = homeownerid;
            int status = h.filterHouse();
            
            if(status == 1){
            %> <h1> Filtered House Records: </h1>
            <table style="width:70%">
                <tr>
                    <th style="padding-bottom: 15px">House ID</th>
                    <th style="padding-bottom: 15px">House Number</th>
                    <th style="padding-bottom: 15px">Homeowner ID</th>
                    <th style="padding-bottom: 15px">Street</th>
                </tr>
                
               <% for(int i=0; i<h.homeownerid_list.size(); i++){
                   %> <tr>
                       <th><%=h.houseid_list.get(i)%></th>
                       <th><%=h.houseno_list.get(i)%></th>
                       <th><%=h.homeownerid_list.get(i)%></th>
                       <th><%=h.street_list.get(i)%></th>
                      </tr>
               <%}%>
            </table><br><br>
            <%}else{
                %> <h1>No records found.</h1>
            <%}%>
            <button onclick="location.href='filter_house.jsp'" type="button">Filter Again</button>
            <button onclick="location.href='h_index.html'" type="button">Return to Menu</button>
    </body>
</html>
