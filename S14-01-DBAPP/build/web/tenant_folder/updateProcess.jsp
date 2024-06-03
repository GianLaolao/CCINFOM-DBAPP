<%-- 
    Document   : updateProcess.jsp
    Created on : 11 12, 23, 6:09:25 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Updating Tenant Information</title>
    </head>
    <body>
        <form action="saveUpdate.jsp">
            <jsp:useBean id="T" class="tables_package.tenants" scope="session"/>
            <%
                
                try{
                    int tID = Integer.parseInt(request.getParameter("tenantInput"));
                    T.getTenantInfo();
                    int flag=0, i=0;
                    while (flag==0){
                        if (T.tenantidList.get(i)==tID){
                            T.fname = T.tenant_fnameList.get(i);
                            T.lname = T.tenant_lnameList.get(i);
                            T.tenantid = T.tenantidList.get(i);
                            T.houseid = T.tenant_houseNo.get(i);
                            flag=1;
                        }
                        i++;
                    }

                %>        
                        <label id="tid"><%=T.tenantid%></label> <br>
                        <input type="hidden" id="tenid" name="tid" value="<%=T.tenantid%>">
                        <input type="hidden" id="houseno" name="houseno" value="<%=T.houseid%>">
                        <input type="hidden" id="f_name" name="f_name" value="<%=T.fname%>">
                        <input type="hidden" id="l_name" name="l_name" value="<%=T.lname%>">
                        First Name:
                        <input type="text" id="tfname" name="tfname" value="<%=T.fname%>">  <br>
                        Last Name:
                        <input type="text" id="tlname" name="tlname" value="<%=T.lname%>"> <br>
                        House No:
                        <input type="text" id="thouse" name="thouse" value="<%=T.houseid%>"> <br>   
                        <button onclick="location.href='tenantindex.html'" type="button">
                        Home </button>
                        <input type="submit" id="submitTenant" name="submit" value="Submit">
                        
                <%        
                } catch (Exception e){
                    %>
                    <h1>Invalid Input!</h1>
                    <button onclick="location.href='updateTenant.jsp'" type="button">
                        Update Tenant </button>
                    <button onclick="location.href='tenantindex.html'" type="button">
                        Home </button>
                    <%
                }
                %>
                
        </form>
    </body>
</html>
