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
            <jsp:useBean id="p" class="tables_package.payment" scope="session"/>
            <%  
                String v_year = request.getParameter("year");
                String v_month = request.getParameter("month");
                
                int year = Integer.parseInt(v_year);
                int month = Integer.parseInt(v_month);
                
                int s = p.searchPayments(year, month);
                
                if (s == 1) {
            %>          
                <br><input type="submit" value="Dues Menu"><br>
                <button onclick="location.href='search_payment.html'" type="button"> Search Payment </button><br><br>
                <h1>Payment Records:</h1>
                <table style="width:50%">
                        <tr>
                           <th>Payment ID</th>
                           <th>Monthly Due Year</th>
                           <th>Monthly Due Month</th>
                           <th>Amount Paid</th>
                           <th>Change</th>
                           <th>Payment Date</th>
                        </tr>
                   <% for(int i=0; i<p.paymentid_list.size(); i++) { %>
                        <tr>
                            <td><%=p.paymentid_list.get(i) %></td>
                            <td><%=p.monthlydueYear_list.get(i) %></td>
                            <td><%=p.monthlydueMonth_list.get(i) %></td>
                            <td><%=p.amountpaid_list.get(i) %></td>
                            <td><%=p.amountchange_list.get(i) %></td>
                            <td><%=p.paymentdate_list.get(i) %></td>
                        </tr>
                   <% } %>
               </table><br>
            <% } else if (s == 2) { %>
                <h1>NO Record Available.</h1>
                <input type="submit" value="Dues Menu"><br>
                <button onclick="location.href='search_payment.html'" type="button"> Search Payment </button><br><br>
            <% } else {     %>
                <h1>Homeowner Input Invalid</h1>
                <input type="submit" value="Dues Menu"><br>
                <button onclick="location.href='search_payment.html'" type="button"> Search Payment </button><br><br>
            <% } %>
        </form>           
    </body>
</html>
