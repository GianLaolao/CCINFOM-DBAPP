<%-- 
    Document   : publish_updatedrecord
    Created on : 11 12, 23, 11:20:08 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Updating Record </title>
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
            homeowner ho = new homeowner();

            int old_houseno = Integer.valueOf(request.getParameter("old_houseno"));
            int old_homeownerid = Integer.valueOf(request.getParameter("old_homeownerid"));
            String old_street = request.getParameter("old_street");

            int houseid = Integer.valueOf(request.getParameter("houseid"));
            int houseno = Integer.valueOf(request.getParameter("houseno"));
            int homeownerid = Integer.valueOf(request.getParameter("homeownerid"));
            String street = request.getParameter("street");
            int valid_ho = 0;
            int valid_houseno = 1;
            int status = 0;

            ho.getID();        
            for(int i=0; i<ho.homeownerid_list.size(); i++){
                if(ho.homeownerid_list.get(i) == homeownerid){
                    valid_ho = 1;
                }
            }

            h.street = "";
            h.homeownerid = 0;
            h.houseno = 0;

            h.filterHouse();
            for(int i=0; i<h.houseno_list.size(); i++){
                if(h.houseno_list.get(i) == houseno && h.houseno_list.get(i) != old_houseno){
                    valid_houseno = 0;
                }
            }

            h.houseid = houseid;
            h.houseno = houseno;
            h.street = street;
            h.homeownerid = homeownerid;

            if(valid_ho == 1 && valid_houseno == 1){
                status = h.updateHouse();
            }

            if(status == 1){
                %> <h1>Successfully updated record</h1><br>
                    <%
                        h.getHouseRecord(houseid);
                     %>
                     <h3>Updated Record</h3>
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
                     </table><br>

                     <h3>Old Record</h3>
                     <table style="width: 70%">
                         <tr>
                            <th style="padding-bottom: 15px">House ID</th>
                            <th style="padding-bottom: 15px">House Number</th>
                            <th style="padding-bottom: 15px">Homeowner ID</th>
                            <th style="padding-bottom: 15px">Street</th>
                         </tr>

                         <tr>
                             <th><%=houseid%></th>
                             <th><%=old_houseno%></th>
                             <th><%=old_homeownerid%></th>
                             <th><%=old_street%></th>
                         </tr>
                     </table>
            <%}else if(valid_ho == 0 || valid_houseno == 0){
                if(valid_ho == 0){
                    %><h1>Invalid homeowner ID</h1><br>
                <%}
                if(valid_houseno == 0){
                    %><h1>House number already taken</h1>
                <%}
            }else{
            %> <h1>Error in updating record</h1>
            <%}%>
                
            <br><br>
            <button onclick="location.href='update_house.jsp'" type="button">Back</button>
            <button onclick="location.href='h_index.html'" type="button">Return to Menu</button>
    </body>
</html>
