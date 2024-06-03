<%-- 
    Document   : duesreport_processing.jsp
    Created on : 11 16, 23, 4:01:18 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*, java.time.Month, java.util.Locale"%>
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
            String month_s = request.getParameter("month");
            String year = request.getParameter("year");
            
            monthly_dues md = new monthly_dues();
            
            if(street.equals("") && month_s.equals("") && year.equals("")){
                md.getDueReport();
                %><h1>Generating Report...</h1><br>
                    <table style="width:80%">
                    <tr>
                        <th style="padding-bottom: 15px">Street</th>
                        <th style="padding-bottom: 15px">Total Amount Unpaid</th>
                        <th style="padding-bottom: 15px">Total Amount Paid</th>
                        <th style="padding-bottom: 15px">Number of Payments</th>
                        <th style="padding-bottom: 15px">Number of Missing Payments</th>
                    </tr>
                    
                    
                    <%
                    for(int i=0; i<md.street_list.size(); i++){
                        %><tr>
                            <th><%=md.street_list.get(i)%></th>
                            <th><%=md.amountUnpaid_list.get(i)%></th>
                            <th><%=md.amountPaid_list.get(i)%></th>
                            <th><%=md.countPaid_list.get(i)%></th>
                            <th><%=md.countUnpaid_list.get(i)%></th>
                        </tr>
                    <%}%>
                </table>
                <%}else{
                md.year = 0;
                md.street = "";
                md.month = 0;

                if(!street.equals("")){
                    md.street = street;
                }

                if(!month_s.equals("")){
                    Month month = Month.valueOf(month_s.toUpperCase(Locale.ROOT));
                    md.month = month.getValue();
                    month_s = month_s.substring(0,1) + month_s.substring(1).toLowerCase();
                }

                if(!year.equals("")){
                    md.year = Integer.valueOf(year);
                }

                int status = md.filterReport();

                if(status == 1){%>
                    <h1>Generating Report...</h1>
                    
                    <br>
                    <table style="width:80%">
                    <tr>
                        <th style="padding-bottom: 15px">Street</th>
                        <th style="padding-bottom: 15px">Total Amount Unpaid</th>
                        <th style="padding-bottom: 15px">Total Amount Paid</th>
                        <th style="padding-bottom: 15px">Number of Payments</th>
                        <th style="padding-bottom: 15px">Number of Missing Payments</th>
                    </tr>
                    
                    <% if(md.year != 0 && md.month != 0){
                    %><h2>Year: <%=md.year%>&emsp;&emsp;Month: <%=month_s%></h2>
                    <%}else if(md.year != 0 && md.month == 0){
                            %><h2>Year: <%=md.year%></h2>
                      <%}else if(md.year == 0 && md.month != 0){
                            %><h2>Month: <%=month_s%></h2>
                        <%}

                    if(!md.street.equals("")){
                        for(int i=0; i<md.street_list.size(); i++){
                        if(md.street_list.get(i).equals(md.street)){
                            %><tr>
                            <th><%=md.street_list.get(i)%></th>
                            <th><%=md.amountUnpaid_list.get(i)%></th>
                            <th><%=md.amountPaid_list.get(i)%></th>
                            <th><%=md.countPaid_list.get(i)%></th>
                            <th><%=md.countUnpaid_list.get(i)%></th>
                        </tr>
                        <%}
                        }
                    }else{
                        for(int i=0; i<md.street_list.size(); i++){
                            %><tr>
                                <th><%=md.street_list.get(i)%></th>
                                <th><%=md.amountUnpaid_list.get(i)%></th>
                                <th><%=md.amountPaid_list.get(i)%></th>
                                <th><%=md.countPaid_list.get(i)%></th>
                                <th><%=md.countUnpaid_list.get(i)%></th>
                            </tr>
                            <%}
                        }%>
                    </table>
                <%}else{
                %> <h1>No records found</h1>
                <%}
            }%>
            
            <br><br>
            <button onclick="location.href='dues_report.jsp'" type="button">Filter Again</button>
            <button onclick="location.href='../index.html'" type="button">Return to Menu</button>
    </body>
</html>
