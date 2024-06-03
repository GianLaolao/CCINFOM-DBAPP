<%-- 
    Document   : search_ho_processing
    Created on : 11 9, 23, 11:12:35 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            th, td {
                width: 120px;
                height: 30px;
                text-align: center;
                padding: 10px;
                border: 1px solid black;
                border-collapse: collapse;
                overflow-y: scroll;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Homeowner Record Processing</title>
    </head>
    <body>
        <form action="ho_index.html">
            <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
            <%  String v_lastname = request.getParameter("last_name");
                String v_firstname = request.getParameter("first_name");
                
                h.lastname = v_lastname;
                h.firstname = v_firstname;
                
                int s = h.search_homeowner();
                
                if (s == 1) {
            %>          
            <input type="submit" value="Homeowner Menu"><br>
            <button onclick="location.href='search_ho.jsp'" type="button"> Search Homeowner Record</button><br><br>
            <h1>Homeowner Records:</h1><br>
               <table style="width:30%">
                        <tr>
                           <th>Homeowner ID</th>
                           <th>Last Name</th>
                           <th>First Name</th>
                        </tr>
                   <% for(int i=0; i<h.homeownerid_list.size(); i++) { %>
                        <tr>
                            <td><%=h.homeownerid_list.get(i) %></td>
                            <td><%=h.lastname_list.get(i) %></td>
                            <td><%=h.firstname_list.get(i) %></td>
                        </tr>
                   <% } %>
               </table><br>
            <% } else if (s == 2) { %>
                <h1>No Record Available</h1><br>
                <input type="submit" value="Homeowner Menu"><br>
                <button onclick="location.href='search_ho.jsp'" type="button"> Search Homeowner Record</button><br><br>
            <% } else {     %>
                <h1>Homeowner Input Invalid</h1><br>
                <input type="submit" value="Homeowner Menu"><br>
                <button onclick="location.href='search_ho.jsp'" type="button"> Search Homeowner Record</button><br><br>
            <% } %>
        </form><br>
    </body>
</html>
