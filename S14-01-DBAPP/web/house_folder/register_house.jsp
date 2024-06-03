<%-- 
    Document   : register_house
    Created on : 11 11, 23, 10:51:28 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <style>
            input[type=number] {
                 -moz-appearance: textfield;
            }
    </style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create House Record</title>
</head>
    <body>
        <form action="registerhouse_processing.jsp"> 
            <label for="houseid">Current House ID: </label>
            <jsp:useBean id="house" class="tables_package.house" scope="session"/>
            <label id="houseid" name="houseid" for="houseid"> <%=house.getNewHouseNo()%> </label> <br><br>
            
            <jsp:useBean id="s" class="tables_package.street" scope="application"/>
            Select Street: <select name="street">
                <%
                    s.getStreetList();
                    for(int i=0; i<s.street_list.size(); i++){%>
                        <option value="<%=s.street_list.get(i)%>"> <%=s.street_list.get(i)%></option>
                    <%}%>
            </select>
            
            <br><br>
            
            <label for="houseno">Input House Number: </label>
            <input type="number" id="houseno" name="houseno" max="999" required>
            <br><br>
            
            <label for="homeownerid">Input Homeowner ID: </label>
            <input type="number" id="homeownerid" name="homeownerid" maxlength="4" required>
                
            <br><br>
            <input type="hidden" name="houseid" value="<%=house.getNewHouseNo()%>">
            <button onclick="location.href='h_index.html'" type="button">Cancel </button>
            <input type="submit" id="submitHouse" name="submit" value="Submit">

        </form>
    </body>
</html>
