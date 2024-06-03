<%-- 
    Document   : update_house
    Created on : 11 12, 23, 5:30:50 PM
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
        <title>View House Record</title>
    </head>
    <body>
        <form action="viewhouse_processing.jsp">
            <label for="houseno">Input House ID: </label>
            <input type="number" id="houseno" name="houseno" maxlength="4" required>
            <br><br>
            
            <button onclick="location.href='h_index.html'" type="button">Cancel </button>
            <input type="submit" id="submit" name="submit" value="Submit">
        </form>
    </body>
</html>
