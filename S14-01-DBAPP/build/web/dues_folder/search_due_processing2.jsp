<%-- 
    Document   : search_due_processing
    Created on : 11 12, 23, 2:08:46 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            th, td {
                width: 130px;
                height: 25px;
                text-align: center;
                border: 1px solid black;
                overflow-y: scroll;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Monthly Due Processing</title>
    </head>
    <body>
        <form action="dues_index.html">
            <jsp:useBean id="m" class="tables_package.monthly_dues" scope="session"/>
            <%  
                String v_status = request.getParameter("status");
                m.status = v_status;
                int s = m.getDuesRecords();
                
                if (s == 1) {
            %>          
                <input type="submit" value="Dues Menu"><br>
                <button onclick="location.href='search_due.html'" type="button"> Search Monthly Due </button><br><br>
                <h1>Monthly Due Records:</h1>
                <table style="width:50%">
                        <tr>
                           <th>Year</th>
                           <th>Month</th>
                           <th>Ongoing Balance</th>
                           <th>Monthly Due</th>
                           <th>Due Date</th>
                           <th>Status</th>
                        </tr>
                   <% for(int i=0; i<m.homeownerid_list.size(); i++) { %>
                        <tr>
                            <td><%=m.year_list.get(i) %></td>
                            <td><%=m.month_list.get(i) %></td>
                            <td><%=m.ongoing_balance_list.get(i) %></td>
                            <td><%=m.monthlydue_list.get(i) %></td>
                            <td><%=m.dueDate_list.get(i) %></td>
                            <td><%=m.status_list.get(i) %></td>
                        </tr>
                   <% } %>
               </table><br>
            <% } else if (s == 2) { %>
                <h1>NO Record Available.</h1>
                <input type="submit" value="Dues Menu"><br>
                <button onclick="location.href='search_due.html'" type="button"> Search Monthly Due </button><br><br>
            <% } else {     %>
                <h1>Homeowner Input Invalid</h1>
                <input type="submit" value="Dues Menu"><br>
                <button onclick="location.href='search_due.html'" type="button"> Search Monthly Due </button><br><br>
            <% } %>
            
        </form>
            
    </body>
</html>
