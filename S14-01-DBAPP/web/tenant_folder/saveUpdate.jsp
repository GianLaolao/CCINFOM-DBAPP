<%-- 
    Document   : saveUpdate
    Created on : 11 12, 23, 9:56:40 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Save Updated Information</title>
    </head>
    <body>
        <jsp:useBean id="T" class="tables_package.tenants" scope="session"/>
        <jsp:useBean id="old_T" class="tables_package.tenants" scope="session"/>
        <%
            String fname = request.getParameter("tfname");
            String lname = request.getParameter("tlname");
            String house_no = request.getParameter("thouse");
            String tID = request.getParameter("tid");
            
            String old_fname = request.getParameter("f_name");
            String old_lname = request.getParameter("l_name");
            String old_hno = request.getParameter("houseno");
            old_T.fname = old_fname;
            old_T.lname = old_lname;
            old_T.houseid = Integer.parseInt(old_hno);
            
            
            T.fname = fname;
            T.lname = lname;
            T.houseid = Integer.parseInt(house_no);
            T.tenantid = Integer.parseInt(tID);
            
            int status = T.updateTenant();
            if (status==1){
            %>
                <h1> Updating of Tenant Information, Successful!</h1>
                Old Information: <br>
                <table>
                    <tr>
                        <th> First Name</th>
                        <th> Last Name</th>
                        <th> House Number</th>
                    </tr>
                    <tr>
                        <td> <%=old_T.fname%></td>
                        <td> <%=old_T.lname%></td>
                        <td> <%=old_T.houseid%></td>
                    </tr>
                </table> <br>
            
            
                New Information: <br>
                <table>
                    <tr>
                        <th> First Name</th>
                        <th> Last Name</th>
                        <th> House Number</th>
                    </tr>
                    <tr>
                        <td> <%=T.fname%></td>
                        <td> <%=T.lname%></td>
                        <td> <%=T.houseid%></td>
                    </tr>
                </table> <br>
            <% } else {
                %>
            <h1> Updating of Tenant Information, Failed!</h1> 
            <% }
                %>
        
        
        <button onclick="location.href='tenantindex.html'" type="button">
                Home </button>
    </body>
</html>
