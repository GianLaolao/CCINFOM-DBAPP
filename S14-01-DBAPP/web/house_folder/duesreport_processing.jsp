<%-- 
    Document   : duesreport_processing.jsp
    Created on : 11 16, 23, 4:01:18 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*, java.time.Month, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Generating Report</title>
    </head>
    <body>
        <style>
            table,
            th,
            td {
              padding: 10px;
              border: 1px solid black;
              border-collapse: collapse;
            }
        </style>
        
        <%
            String street = request.getParameter("street");
            String month = request.getParameter("month");
            String payStatus = request.getParameter("status");
            monthly_dues md = new monthly_dues();
            
            if(street.equals("") && month.equals("") && payStatus.equals("")){
                md.getAllDues();
                for(int i=0; i<md.monthlydue_list.size(); i++){
                    %> <table style="width:80%">
                    <tr>
                        <th style="padding-bottom: 15px">Homeowner ID</th>
                        <th style="padding-bottom: 15px">Year</th>
                        <th style="padding-bottom: 15px">Month</th>
                        <th style="padding-bottom: 15px">Street</th>
                        <th style="padding-bottom: 15px">Ongoing Balance</th>
                        <th style="padding-bottom: 15px">Monthly Due</th>
                        <th style="padding-bottom: 15px">Due Date</th>
                        <th style="padding-bottom: 15px">Status</th>
                    </tr>

                    <tr>
                        <%
                            for(int j=0; j<md.monthlydue_list.size(); j++){
                                %><th><%=md.homeownerid_list.get(j)%></th>
                                <th><%=md.year_list.get(j)%></th>
                                <th><%=md.month_list.get(j)%></th>
                                <th><%=md.street_list.get(j)%></th>
                                <th><%=md.homeownerid_list.get(j)%></th>
                                <th><%=md.homeownerid_list.get(j)%></th>
                                <th><%=md.homeownerid_list.get(j)%></th>
                         <%   } %>
                    </tr>
                </table>
            <%   }
            }
            
         %>
    </body>
</html>
