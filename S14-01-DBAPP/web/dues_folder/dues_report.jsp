<%-- 
    Document   : dues_report
    Created on : 11 16, 23, 3:23:31 PM
    Author     : ccslearner
--%>

<%-- Report on Amount of Paid and Unpaid Monthly Dues of Houses per Street
                (filter by Year, Month, Street) 
                Shows the Year, Month, Street, Number of Paid Monthly Dues, and 
                Number of Unpaid Monthly Dues
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*, java.time.Month"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Generate Report</title>
    </head>
    <body>
        <style>
            input[type=number]{
                -moz-appearance: textfield;
            }
        </style>
        <form action="duesreport_processing.jsp">
            
            <label for="year">Filter by Year: </label>
            <input type="number" id="year" name="year" value="year" max="9999">
            <br><br>
            <label for="month">Filter by Month: </label>
            <select name="month">
                <option value="" selected></option>
                    <% for(int i=1; i<13; i++){
                %> <option value="<%=Month.of(i)%>"><%=Month.of(i)%></option>
                    <%}%>
            </select>
            <br><br>
            Filter by Street: <select name="street">
                <option value="" selected></option>
                <%
                    house h = new house();
                    street s = new street();
                    s.getStreetList();
                    
                    for(int i=0; i<s.street_list.size(); i++){
                        if(s.street_list.get(i).equals(h.street)){
                            System.out.println(s.street_list.get(i));
                            %> <option value="<%=s.street_list.get(i)%>" selected><%=s.street_list.get(i)%></option>
                        <%}else{
                            %> <option value="<%=s.street_list.get(i)%>"><%=s.street_list.get(i)%></option>
                          <%}
                    }%>
            </select>
            <br><br>
           
            <button onclick="location.href='../index.html'" type="button">Cancel</button>
            <input type="submit" id="filter" name="filter" value="Filter">
        </form>
    </body>
</html>
