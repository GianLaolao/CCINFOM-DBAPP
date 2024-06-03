<%-- 
    Document   : create_due
    Created on : 11 12, 23, 11:26:59 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.time.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Generate Monthly Due</title>
    </head>
    <body>
        <h1>Generate Monthly Due</h1><br>
          <form action="create_due_processing.jsp">
            
            <% 
                LocalDate cur_date = java.time.LocalDate.now();
                int cur_year = cur_date.getYear();
                Month cur_month = cur_date.getMonth();
            %>
            
            <b>Year:</b>&nbsp;<%=cur_year%><br>
            <b>Month:</b>&nbsp;<%=cur_month%><br><br>
              
            <input type="submit" value="Generate Due"><br>
          </form>
        <button onclick="location.href='dues_index.html'" type="button"> Cancel </button>
    </body>
</html>
