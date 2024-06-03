<%-- 
    Document   : create_ho_processing
    Created on : 11 7, 23, 4:01:41 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            
            .tab {
                tab-size: 20;
                font-family: "times new roman", times, serif;
                font-size: 18px;
                text-align: justify;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Homeowner Record Processing</title>
    </head>
    <body> 
        <h1>Create Homeowner Record</h1><br>
        <form action="ho_index.html">
            <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
            <%  String v_firstname = request.getParameter("first_name");
                String v_lastname = request.getParameter("last_name"); 
                h.lastname = v_lastname;
                h.firstname = v_firstname;
                int s = h.create_homeowner();
           
                if (s==1) {
            %>
                <h1>Homeowner Record Successfully Created!</h1>
                <% h.view_homeowner(); %>
                <pre class="tab">
                <b>Homeowner ID:</b>           <%=h.homeownerid%><br>
                <b>Last Name:</b>                    <%=h.lastname%><br>
                <b>First Name:</b>                   <%=h.firstname%><br>
                </pre>
                
            <% } else {
            %>
                <h1>Homeowner Input Invalid!</h1>
            <% }
            %>
            <input type="submit" value="Homeowner Menu"><br>
        </form>   
        <a href="create_ho.html" target="_self">
            <button>Create Homeowner Record</button>
        </a>
    </body>
</html>
    