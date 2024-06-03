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
        <h1>Search Payment Record</h1><br>
        <form action="search_payment_processing2.jsp">
            <jsp:useBean id="p" class="tables_package.payment" scope="session"/>
            <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
            <%  String v_homeownerid = request.getParameter("homeowner"); 
                
                
                h.homeownerid = Integer.parseInt(v_homeownerid);
                int s = h.view_homeowner();
                 
                if (s == 1) {
                    p.homeownerid = Integer.parseInt(v_homeownerid);
                    s = p.getDistinct();
            %>
                <label> FILTERS: </label><br><br>
                Payment Year:&nbsp;<select id="year" name="year">
                    <option value = "0">All</option>
                 <% for (int year : p.monthlydueYear_list) { %>
                    <option value =<%=String.valueOf(year)%>><%=year%></option>
                 <% } %>
                </select><br>
                Payment Month:&nbsp;<select id="month" name="month">
                    <option value = "0">All</option>
                 <% for (int i = 1; i <= 12; i++) { %>
                    <option value =<%=i%>><%=i%></option>
                 <% } %>
                </select><br><br>
                <input type="submit" value="Submit"><br>  
                <button onclick="location.href='dues_index.html'" type="button"> Cancel </button>
          </form>
            <% } else { %>
                 <h1>Homeowner Input Invalid</h1>
                 <button onclick="location.href='search_payment.html'" type="button"> Search Payments </button>
                 <button onclick="location.href='dues_index.html'" type="button"> Dues Menu </button>
            <% } %>
    </body>
</html>
