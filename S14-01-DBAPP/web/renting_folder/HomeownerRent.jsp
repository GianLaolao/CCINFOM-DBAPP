<%-- 
    Document   : HomeownerRent
    Created on : 11 13, 23, 10:48:48 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Homeowner Renting</title>
        <style>
            th, td {
                text-align: center;
                border: 1px solid black;
            }
            .divScroll{
                display: block;
                overflow-y: scroll;
                height:100px;
                width:400px;  
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#street").change(function(){
                    var selectedStreet = $(this).val();

                    $.ajax({
                        url: "getAvailSlots.jsp",
                        method: "post",
                        data: { street: selectedStreet },
                        success: function(data){
                        console.log("AJAX Response: " + data);
                        $("#parking_No").html(data);
                        }, 
                        error: function(xhr, status, error) {
                        console.error("AJAX Error:", status, error);
                    }
                    });
                    
                });
            });
        </script>
    </head>
    <body>
        <jsp:useBean id="H"  class="tables_package.homeowner"   scope="session" />
        <jsp:useBean id="S"  class="tables_package.rent_pspace" scope="session" />
        <form action="horentProcess.jsp">
            <%
                S.checkSpaces();
                H.getID();
                S.getSpaceInfo();
            %>
            Homeowners:     <input type="text" id="hoInput" name="hoInput" required>
            <br>
                <br>
                Street: <select id="street" name="street">
                <option value="0" selected>Select Street</option>
                <%
                    ArrayList<String> distinctList = new ArrayList<> ();
                    distinctList = S.getDistinctAvailable();
                    for (int i=0; i < distinctList.size(); i++){
                        %>
                        <option value="<%= distinctList.get(i)%>"> <%= distinctList.get(i)%> </option>
                        <%
                    }
                    %>
            </select > <br>
                Parking Space Number: <select id="parking_No" name="parking_No">
                <option value="0" selected> Select Parking Space Number</option>
                </select>
                <br>
                <br>
                Available Parking Spaces:
                <table class="divScroll">
                    <tr>
                        <th> Slot </th>
                        <th> Street </th>
                        <th> Rent Price </th>
                    </tr>
                    <%
                        for (int k =0; k<S.parkingNoList.size(); k++){
                            %>
                            
                            <tr>
                                <td> <%= S.parkingNoList.get(k)%>   </td>
                                <td> <%= S.spaceStList.get(k)%>     </td>
                                <td> <%= S.priceList.get(k)%>       </td>
                            </tr>
                            <%
                        }
                        
                        %>
                </table>
            <button onclick="location.href='rentIndex.html'" type="button">
                Cancel </button>
            <input type="submit" id="submitTenant" name="submit" value="Submit">
        </form>
    </body>
</html>
