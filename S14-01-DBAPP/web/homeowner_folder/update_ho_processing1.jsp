<%-- 
    Document   : update_ho_processing1
    Created on : 11 10, 23, 2:15:27 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
        .tab {
                tab-size: 20;
                font-family: "times new roman", times, serif;
                font-size: 18px;
                text-align: justify;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Homeowner Record Processing</title>
    </head>
    <body>
        <h1>Update Homeowner Record</h1><br>
        <form action="update_ho_processing2.jsp">
            <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
                <%  String v_homeownerid = request.getParameter("homeowner");
                
                int s = 0;
                
                if (!v_homeownerid.equals("")) {
                   h.homeownerid = Integer.parseInt(v_homeownerid);
                   s = h.check_homeowner();
                }
                
                if (s == 1)
                    s = h.view_homeowner(); 
                
                if (s == 1) {
                %>
                    <pre class="tab">
                     <b>Homeowner ID:</b>           <%=h.homeownerid%><br>
                     <b>Last Name:</b>       <input type="text" id="last_name" required name="last_name" value= <%=h.lastname%>><br>
                     <b>First Name:</b>      <input type="text" id="first_name" required name="first_name" value= <%=h.firstname%>><br>
                    </pre>
             <input type="submit" value="Submit"> <input type="reset" value="Reset">
        </form>
               <% } else { %> 
                    <h1>Homeowner Input Invalid</h1>
                    <button onclick="location.href='update_ho.html'" type="button"> Update Homeowner Record </button>
               <% } %>
            <button onclick="location.href='ho_index.html'" type="button"> Main Menu </button>
    </body>
</html>
