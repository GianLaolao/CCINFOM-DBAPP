<%-- 
    Document   : update_house
    Created on : 11 12, 23, 10:44:50 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update House Record</title>
    </head>
    <body>
        <style>
            input[type=number]{
                -moz-appearance: textfield;
            }
        </style>
        
        <form action="updatehouse_processing.jsp">
            <label for="houseid">Input House ID: </label>
            <input type="number" id="houseid" name="houseid" maxlength="4">
            
            <br><br>
            <button onclick="location.href='h_index.html'" type="button">Cancel </button>
            <input type="submit" id="next" name="next" value="Next">
        </form>
    </body>
</html>
