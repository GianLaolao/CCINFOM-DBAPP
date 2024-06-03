<%-- 
    Document   : delete_house
    Created on : 11 13, 23, 8:23:54 PM
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
        <title>Delete House Record</title>
    </head>
    <body>
        <form action="deletehouse_processing.jsp">
            <label for="houseid"> Input House ID to Delete: </label>
            <input type="number" name="houseid" id="houseid" maxlength="4" required>
            <br><br>
            <button onclick="location.href='h_index.html'" type="button">Cancel </button>
            <input type="submit" id="delete" name="delete" value="Delete">
        </form>
    </body>
</html>
