<%-- 
    Document   : viewtRent
    Created on : 11 15, 23, 10:22:38 PM
    Author     : ccslearner
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Tenant Renting Transactions</title>
        <style>
            input[type=number]{
                -moz-appearance: textfield;
            }
        </style>
         <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#street").change(function(){
                    var selectedStreet = $(this).val();

                    $.ajax({
                        url: "getParkingNo.jsp",
                        method: "post",
                        data: { street: selectedStreet },
                        success: function(data){
                        $("#parking_No").html(data);
                        }
                    });
                });
            });
        </script>
    </head>
    <body>
        <jsp:useBean id="S"  class="tables_package.rent_pspace" scope="session" />
        <form action="viewtrentProcess.jsp">
            Tenant ID: <input type="number" id="tenantInput" name="tenantInput" value="0" required> <br>
            Streets: <select id="street" name="street">
                <option value="0" selected>Select Street</option>
                <%
                    ArrayList<String> distinctList = new ArrayList<> ();
                    distinctList = S.getDistinctStreet();
                    for (int i=0; i < distinctList.size(); i++){
                        %>
                        <option value="<%= distinctList.get(i)%>"> <%= distinctList.get(i)%> </option>
                        <%
                    }
                    %>
            </select > <br>
            Parking Space Number: <select id="parking_No" name="parking_No">
                <option value="0" selected> Select Parking Space Number</option>
            </select><br>
            
            
            <button onclick="location.href='viewRent.jsp'" type="button">
                Cancel </button>
            <input type="submit" id="submitTenant" name="submit" value="Submit">
        </form>
    </body>
</html>
