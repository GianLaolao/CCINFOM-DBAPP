<%-- 
    Document   : createhouse_processing
    Created on : 11 11, 23, 10:20:25 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Processing Registration</title>
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
        
        <form>
                <%
                    house house_r = new house();
                    homeowner ho = new homeowner();
                    
                    String v_street = request.getParameter("street");
                    int v_homeownerid = Integer.valueOf(request.getParameter("homeownerid"));
                    int v_houseno = Integer.valueOf(request.getParameter("houseno"));
                    int v_houseid = Integer.valueOf(request.getParameter("houseid"));
                    
                    int valid_ho = 0;
                    int valid_houseno = 1;
                    int check = 0;
                    
                    
                    ho.getID();
                    
                    
                    for(int i=0; i<ho.homeownerid_list.size(); i++){
                        if(ho.homeownerid_list.get(i) == v_homeownerid){
                            valid_ho = 1;
                        }
                    }
                    
                    house_r.street = "";
                    house_r.homeownerid = 0;
                    house_r.houseno = 0;
                    
                    house_r.filterHouse();
                    for(int i=0; i<house_r.houseno_list.size(); i++){
                        if(house_r.houseno_list.get(i) == v_houseno){
                            valid_houseno = 0;
                        }
                    }
                    
                    
                    house_r.street = v_street;
                    house_r.homeownerid = v_homeownerid;
                    house_r.houseno = v_houseno;
                    
                    if(valid_houseno == 1 && valid_ho == 1){
                        check = house_r.register();
                    }

                    if(check == 1 && valid_ho == 1 && valid_houseno == 1){
                        %><h1>Successfully Registered House</h1>
                        <label for="details">Here are the details...</label><br><br>
                        <%
                            house_r.getHouseRecord(v_houseid);
                         %>
                         <table style="width: 70%">
                             <tr>
                                <th style="padding-bottom: 15px">House ID</th>
                                <th style="padding-bottom: 15px">House Number</th>
                                <th style="padding-bottom: 15px">Homeowner ID</th>
                                <th style="padding-bottom: 15px">Street</th>
                             </tr>
                             
                             <tr>
                                 <th><%=house_r.houseid%></th>
                                 <th><%=house_r.houseno%></th>
                                 <th><%=house_r.homeownerid%></th>
                                 <th><%=house_r.street%></th>
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
                    %> <h1>Error in Registering House</h1>
                    <h1><%=valid_ho%></h1>
                    <h1><%=valid_houseno%></h1>
                    <%}%>
                    <br><br>
                    
             <button onclick="location.href='register_house.jsp'" type="button">Register Another House</button>
             <button onclick="location.href='h_index.html'" type="button">Return to Menu</button>
        </form>
    </body>
</html>
