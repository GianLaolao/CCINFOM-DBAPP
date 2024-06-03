<%-- 
    Document   : create_due_processing
    Created on : 11 12, 23, 11:48:36 PM
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
                height: 20px;
                text-align: center;
                border: 1px solid black;
                overflow-y: scroll;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Generate Monthly Due Processing</title>
    </head>
    <body>
        <jsp:useBean id="m" class="tables_package.monthly_dues" scope="session"/>
        <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
        <form action="dues_index.html">
            <%  
                int s = m.createDue();
                h.homeownerid_list = m.homeownerid_list;
                
                if (s == 1) { 
            %>
                <input type="submit" value="Dues Menu"><br><br>
                    <h1>Created Due for Homeowners:</h1>
                    <table style="width:30%">
                            <tr>
                               <th>Homeowner ID</th>
                               <th>Last Name</th>
                               <th>First Name</th>
                            </tr>
                            </tr>
                       <% for(int id : h.homeownerid_list) { 
                            h.homeownerid = id;
                            h.view_homeowner();
                       %>
                            <tr>
                                <td><%=h.homeownerid%></td>
                                <td><%=h.lastname%></td>
                                <td><%=h.firstname%></td>
                            </tr>
                       <% } %>
                    </table><br>
            
            <%   } else { %>
                <h1>All Homeowners have monthly dues for this month</h1> 
                <input type="submit" value="Dues Menu"><br>
            <% } %>
        </form>
    </body>
</html>
