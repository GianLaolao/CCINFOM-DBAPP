<%-- 
    Document   : viewhorentProcess
    Created on : 11 15, 23, 11:28:12 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Viewing Output</title>
        <style>
            th, td {
                text-align: center;
                border: 1px solid black;
            }
            .divScroll{
                display: block;
                overflow-y: scroll;
                height:100px;
                width:500px;  
            }
        </style>
    </head>
    <body>
        <jsp:useBean id="P"  class="tables_package.rent_pspace" scope="session" />
        <%
            int hoID = Integer.parseInt(request.getParameter("hoInput"));
            int slot = Integer.parseInt(request.getParameter("parking_No"));
            String street = request.getParameter("street");
            try {
                P.ho_id = hoID;
                P.parkingspaceno = slot;
                P.spaceSt = street;
                int status = P.searchhoRent();
                if (P.spaceSt.isEmpty() || P.parkingNoList.isEmpty()){
                    status = 2;
                }
                if (status == 1) {
                    %>
                    <h1> Searching Operation Successful! </h1>
                    <table class="divScroll">
                        <tr>
                            <th> Rent ID</th>
                            <th> Homeowner ID</th>
                            <th> Parking Space Number</th>
                            <th> Street</th>
                        </tr>
                    
                    <%
                        for (int i=0; i<P.rentidList.size(); i++){
                        %>
                        <tr>
                            <td> <%=P.rentidList.get(i)%> </td>
                            <td> <%=P.ho_idList.get(i)%> </td>
                            <td> <%=P.parkingNoList.get(i)%> </td>
                            <td> <%=P.spaceStList.get(i)%> </td>
                        </tr>
                        <%
                        }
                    %>
                    </table>
                    <%
                } else if (status == 2){
                    %>
                    <h1> Address Does Not Exist</h1>
               <% } else {
                    %>
                    <h1> Searching Operation Failed! </h1>
                    <%
                }
            } catch (Exception e){
                %>
                <h1> Invalid Input! </h1>
                <%
            }
            %>
            <button onclick="location.href='rentIndex.html'" type="button">
                Home </button>
    </body>
</html>
