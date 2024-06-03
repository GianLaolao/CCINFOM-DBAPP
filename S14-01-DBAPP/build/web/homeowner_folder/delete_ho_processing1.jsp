<%-- 
    Document   : delete_ho_processing1
    Created on : 11 11, 23, 5:38:41 PM
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
        <title>Delete Homeowner Record</title>
    </head>
    <body>
        <h1>Delete Homeowner Record</h1><br>
        <form action="delete_ho_processing2.jsp">
            <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
            <%  String v_homeownerid = request.getParameter("homeowner");
      
                h.homeownerid = Integer.parseInt(v_homeownerid);
                int s = h.check_homeowner();
                
   
                if (s == 1) {
                    h.view_homeowner();
            %>          
                <h1>Homeowner Record:</h1>
                <pre class="tab">
                <b>Homeowner ID:</b>           <%=h.homeownerid%><br>
                <b>Last Name:</b>                    <%=h.lastname%><br>
                <b>First Name:</b>                   <%=h.firstname%><br>
                </pre><br>
                
                <h2>Delete homeowner record?</h2>
                <input type="submit" value="Delete"><br>
        </form>
            <% } else {     %>
                <h1>Homeowner Input Invalid</h1>
                <button onclick="location.href='delete_ho.html'" type="button"> Delete Homeowner Record </button>
            <% } %>
        <button onclick="location.href='ho_index.html'" type="button"> Cancel </button>
    </body>
</html>
