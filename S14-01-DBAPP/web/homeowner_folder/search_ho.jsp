<%-- 
    Document   : search_ho
    Created on : 11 9, 23, 10:55:26 AM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Homeowner Records</title>
    </head>
    <body>
        <h1>Search Homeowner Record</h1><br>
        <form action="search_ho_processing.jsp">
            <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
            
            <label> FILTERS: </label><br><br>
            Last Name:&nbsp;<select id="last_name" name="last_name">
                <option value = "0">N/A</option>
                <%  h.getDistinct(0);
                    for (int i=0; i<h.lastname_list.size(); i++) {
                %>
                       <option value=<%=h.lastname_list.get(i)%>><%=h.lastname_list.get(i)%></option>
                <% }
                %>
            </select><br>
            First Name:&nbsp;<select id="first_name" name="first_name">
                <option value = "0">N/A</option>
                <%  h.getDistinct(1);
                    for (int i=0; i<h.firstname_list.size(); i++) {
                %>
                       <option value=<%=h.firstname_list.get(i)%>><%=h.firstname_list.get(i)%></option>
                <% }
                %>
            </select><br><br>
            <input type="submit" value="Submit"><br>
        </form>
        <button onclick="location.href='ho_index.html'" type="button"> Cancel </button>
    </body>
</html>
