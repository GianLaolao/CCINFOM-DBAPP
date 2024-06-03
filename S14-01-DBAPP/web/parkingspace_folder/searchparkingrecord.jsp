<%-- 
    Document   : searchparkingrecord
    Created on : 11 15, 23, 12:37:56 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
            function updateSlots() {
                var selectedStreet = document.getElementById("street").value;
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function () {
                    if (this.readyState == 4 && this.status == 200) {
                        document.getElementById("parkingspaceno").innerHTML = this.responseText;
                    }
                };
                xmlhttp.open("GET", "getslots.jsp?street=" + selectedStreet, true);
                xmlhttp.send();
            }
        </script>
        <title>Search Parking Records</title>
    </head>
    <body>
        <h1>Search Parking Records</h1>
        <form action="searchparking_processing.jsp">
            <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            Street: <select id="street" name="street" onchange="updateSlots()" >
                        <option value="">Select Street</option>
                <%
                    A.get_refstreetList();
                    for(int i=0; i<A.refstreetList.size(); i++) {
                %>
                        <option value="<%=A.refstreetList.get(i)%>"><%=A.refstreetList.get(i)%></option>
                <% }
                %>
            </select><br>
            Parking Slot:<select id="parkingspaceno" name="parkingspaceno" >
                <option value="">Select Slot</option>
            </select><br>
            Status: <select id="status" name="status">
                <option value=""></option>
                <option value="Available">Available</option>
                <option value="Occupied" >Occupied </option>
            </select><br>
            Rent Price:<input type="text" id="rent_price" name="rent_price"><br>
            <input type="submit" value="Search"><br>
            <input type="reset"  value="Reset" ><br>
        </form><br>
        <form action="ps_index.html"><input type="submit" value="Back to Main Menu"><br></form>
    </body>
</html>
