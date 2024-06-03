<%-- 
    Document   : search_due_processing1
    Created on : 11 12, 23, 2:22:50 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Monthly Due Processing</title>
    </head>
    <body>
        <h1>Search Monthly Due</h1><br>
        <form action="search_due_processing2.jsp">
            <jsp:useBean id="m" class="tables_package.monthly_dues" scope="session"/>
            <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
            <% String v_homeownerid = request.getParameter("homeowner"); 
         
                m.homeownerid = Integer.parseInt(v_homeownerid);
                h.homeownerid = Integer.parseInt(v_homeownerid);
                int s = h.view_homeowner();
                
                if (s == 1) {
            %>
                <label> FILTERS: </label><br><br>
                Status:&nbsp;<select id="status" name="status">
                    <option value = "0">All</option>
                    <option value="PAID">PAID</option>
                    <option value="UNPAID">UNPAID</option>
                </select><br><br>
                <input type="submit" value="Submit"><br>
                <button onclick="location.href='dues_index.html'" type="button"> Cancel </button>
        </form>
            <% } else { %>
                <h1>Homeowner Input Invalid</h1>
                <button onclick="location.href='search_due.html'" type="button"> Search Monthly Due </button>
                <button onclick="location.href='dues_index.html'" type="button"> Dues Menu </button>
            <% } %>        
    </body>
</html>
