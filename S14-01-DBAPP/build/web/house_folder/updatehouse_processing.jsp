<%-- 
    Document   : updatehouse_processing
    Created on : 11 12, 23, 10:58:31 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update House Record</title>
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
            
            input[type=number]{
                -moz-appearance: textfield;
            }
            
        </style>
        
        <%
            house h = new house();
            int houseid = Integer.valueOf(request.getParameter("houseid"));
            
            if(h.getHouseRecord(houseid) == 0){%>
                <h1>No Record Found</h1>
                <br><br>
                <button onclick="location.href='update_house.jsp'" type="button">Back</button>
                <button onclick="location.href='h_index.html'" type="button">Return to Menu</button>
            <%}else{
                h.getHouseRecord(houseid);
                %>
                <br>
                <label>Viewing Record...</label><br><br>
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
                <form action="publish_updatedrecord.jsp">
                    <label for="houseid">Changing Record of House <%=houseid%>... </label><br><br>
                    
                    <input type="hidden" name="houseid" value="<%=h.houseid%>">
                    <input type="hidden" name="old_houseno" value="<%=h.houseno%>">
                    <input type="hidden" name="old_homeownerid" value="<%=h.homeownerid%>">
                    <input type="hidden" name="old_street" value="<%=h.street%>">
                    
                    Street: <select name="street">
                        <%
                            street s = new street();
                            s.getStreetList();

                            for(int i=0; i<s.street_list.size(); i++){
                                if(s.street_list.get(i).equals(h.street)){
                                    System.out.println(s.street_list.get(i));
                                    %> <option value="<%=s.street_list.get(i)%>" selected><%=s.street_list.get(i)%></option>
                                <%}else{
                                    %> <option value="<%=s.street_list.get(i)%>"><%=s.street_list.get(i)%></option>
                                  <%}
                            }%>
                    </select>
                    <br><br>
                    
                    <label for="houseno">Input House Number: </label>
                    <input type="number" id="houseno" name="houseno" max="999" required>
                    <br><br>

                    <label for="homeownerid">Input Homeowner ID: </label>
                    <input type="number" id="homeownerid" name="homeownerid" max="9999" required>

                    <br><br>
                    <button onclick="location.href='update_house.jsp'" type="button">Back</button>
                    <button onclick="location.href='h_index.html'" type="button">Cancel</button>
                    <input type="submit" id="submit" name="submit" value="Submit">
                </form>
            <%}%>
    </body>
</html>
