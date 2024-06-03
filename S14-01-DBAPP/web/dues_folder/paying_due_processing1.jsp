<%-- 
    Document   : paying_due_processing1
    Created on : 11 11, 23, 2:49:55 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
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
            
        th, td {
                text-align: center;
            }    
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Paying Monthly Due Processing</title>
    </head>
    <body>
            <h1>Monthly Due Payment</h1><br>
            <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
            <jsp:useBean id="m" class="tables_package.monthly_dues" scope="session"/>
            <jsp:useBean id="p" class="tables_package.payment" scope="session"/>
                <%  String v_homeownerid = request.getParameter("homeowner");
                    
                    int s = 0;
                    
                    if (!v_homeownerid.equals("")) {
                        h.homeownerid = Integer.parseInt(v_homeownerid);
                        m.homeownerid = Integer.parseInt(v_homeownerid);
                        m.status = "UNPAID";
                        p.homeownerid = Integer.parseInt(v_homeownerid);
                        s = 1;
                        
                        if (h.check_homeowner() == 0) {
                            s = 0;
                        }
                        else { 
                            s = h.view_homeowner();
                        }
                    }
                    
                    if (s == 0) {
                %>
                     <h1>Homeowner Input Invalid</h1>
                     <button onclick="location.href='paying_due.html'" type="button"> Pay Monthly Due </button>
                     <button onclick="location.href='dues_index.html'" type="button"> Main Menu </button>
                <% } else { %>
                    <h1>Homeowner Information:</h1>
                    <pre class="tab">
                    <b>Homeowner ID:</b>           <%=h.homeownerid%><br>
                    <b>Last Name:</b>              <%=h.lastname%><br>
                    <b>First Name:</b>             <%=h.firstname%><br>
                    </pre><br><br      
                <%
                    s = m.getDuesRecords();
                        if (s == 1) {  %>      
                        <b><h1>Monthly Due Records:</h1></b><br>
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
                            </table><br><br>
                            
                           <form action="paying_due_processing2.jsp">
                            Monthly Due Year and Month:&nbsp;
                            <select id="dateGenerated" name="dateGenerated">
                                <% for (int i=0; i<m.homeownerid_list.size(); i++) {  %> 
                                    <option value=<%=String.valueOf(m.year_list.get(i))+"-"+String.valueOf(m.month_list.get(i))%>>
                                           <%=String.valueOf(m.year_list.get(i))+"-" +String.valueOf(m.month_list.get(i))%></option>
                                <% } %>
                            </select><br>
                            Amount of Payment:&nbsp;<input type="number" id="amountpaid" name="amountpaid" min="1.00" max="9999999.99" step="0.01" required><br><br>
                                 <input type="submit" value="Submit"><br>
                           </form>
                           <button onclick="location.href='dues_index.html'" type="button"> Cancel </button>
                        <% } else if (s == 2) { %>
                                <b><h1 style="text-align: center">All Monthly Dues Paid</h1></b><br>
                                <button onclick="location.href='dues_index.html'" type="button"> Main Menu </button>
                                <button onclick="location.href='paying_due.html'" type="button"> Pay Monthly Due </button>
                <%         }
                    }
                %>
               
            </select>  
    </body>
</html>
