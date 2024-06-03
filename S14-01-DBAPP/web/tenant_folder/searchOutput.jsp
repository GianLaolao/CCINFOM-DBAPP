<%-- 
    Document   : searchOutput
    Created on : 11 12, 23, 11:33:49 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search by Filter Output</title>
        <style>
            th, td {
                padding: 10px;
                text-align: center;
                border: 1px solid black;
                border-collapse: collapse;
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
        <jsp:useBean id="T"  class="tables_package.tenants" scope="session" />
        <%
            String fname = request.getParameter("firstname");
            String lname = request.getParameter("lastname");
            int houseNo = Integer.parseInt(request.getParameter("houseNo"));
            T.houseid = houseNo;
            T.fname = fname;
            T.lname = lname;
            
            int status = T.searchTenant();
            if (status == 1){
                %>
                Search Processing Successful!
                <table class="divScroll">
                    <tr>
                        <th> Tenant ID </th>
                        <th> House ID </th>
                        <th> First Name </th>
                        <th> Last Name  </th>
                    </tr>
                <%
                   
                for (int i = 0; i <T.tenantidList.size(); i++){
                %>
                    <tr>
                        <td> <%= T.tenantidList.get(i)%> </td>
                        <td> <%= T.tenant_houseNo.get(i)%> </td>
                        <td> <%= T.tenant_fnameList.get(i)%> </td>
                        <td> <%= T.tenant_lnameList.get(i)%> </td>
                    </tr>
                <%
                }     %>
            
                </table>
                <%
            
            } else {
                %>
                Search Processing Failed!
                <%
            }
            %>
        <button onclick="location.href='searchTenant.jsp'" type="button">
                Search Tenant </button>
        <button onclick="location.href='tenantindex.html'" type="button">
                Home </button>
    </body>
</html>
