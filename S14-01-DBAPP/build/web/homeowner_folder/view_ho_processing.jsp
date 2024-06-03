<%-- 
    Document   : view_ho_processing
    Created on : 11 8, 23, 9:10:57 PM
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
        <title>View Homeowner Record Processing</title>
    </head>
    <body>
        <form action="ho_index.html">
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
                <h1>Homeowner Record:</h1>
                <pre class="tab">
                <b>Homeowner ID:</b>           <%=h.homeownerid%><br>
                <b>Last Name:</b>                    <%=h.lastname%><br>
                <b>First Name:</b>                   <%=h.firstname%><br>
                </pre>
            <% } else {     %>
                <h1>Homeowner Input Invalid</h1>
            <% } %>
            <input type="submit" value="Homeowner Menu"><br>
        </form>
              <button onclick="location.href='view_ho.html'" type="button"> View Homeowner Record </button>
    </body>
</html>
