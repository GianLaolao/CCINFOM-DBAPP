<%-- 
    Document   : yearlyparkingreport
    Created on : 11 15, 23, 9:36:02 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>

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
        <title>Yearly Parking Space Report</title>
    </head>
    <body>
        <h1>Yearly Parking Space Report</h1>
        <form action="yearlyparking_processing.jsp">
            <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            Street: <select id="street" name="street" onchange="updateSlots()">
                        <option value="">Select Street</option>
                <%
                    A.get_refstreetList();
                    for(int i=0; i<A.refstreetList.size(); i++) {
                %>
                        <option value="<%=A.refstreetList.get(i)%>"><%=A.refstreetList.get(i)%></option>
                <% }
                %>
            </select><br>
            Parking Slot:<select id="parkingspaceno" name="parkingspaceno">
                <option value="">Select Slot</option>
            </select><br>
            Year: <select id="year" name="year">
                        <option value="">Select Year</option>
                <%
                    A.get_rentyearList();
                    for(int year : A.parking_rentyearList) {
                %>
                        <option value="<%= year %>"><%=year%></option>
                <% }
                %>
            </select><br>
            Month: <select id="month" name="month">
                <option value="">Select Month</option>
                <option value="1" >Jan </option>
                <option value="2" >Feb </option>
                <option value="3" >Mar </option>
                <option value="4" >Apr </option>
                <option value="5" >May </option>
                <option value="6" >Jun </option>
                <option value="7" >Jul </option>
                <option value="8" >Aug </option>
                <option value="9" >Sept</option>
                <option value="10">Oct </option>
                <option value="11">Nov </option>
                <option value="12">Dec </option>
            </select><br>
            <input type="submit" value="Generate Report"><br>
            <input type="reset"  value="Reset" ><br>
        </form><br>
        <form action="../index.html"><input type="submit" value="Back to Main Menu"><br></form>
    </body>
</html>
