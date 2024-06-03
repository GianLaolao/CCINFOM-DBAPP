<%-- 
    Document   : filter_house
    Created on : 11 13, 23, 8:51:17 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            input[type=number] {
                 -moz-appearance: textfield;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Filter House Record</title>
    </head>
    <body>
        <form action="filterhouse_processing.jsp">
            <label for="houseno">Filter by House Number: </label>
            <input type="number" id="houseno" name="houseno" maxlength="3">
            <br><br>
            
            <label for="homeownerid">Filter by Homeowner ID: </label>
            <input type="number" id="homeownerid" name="homeownerid" maxlength="4">
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
            
            <br><br>
            <button onclick="location.href='h_index.html'" type="button">Cancel</button>
            <input type="submit" id="filter" name="filter" value="Filter">
        </form>
    </body>
</html>
