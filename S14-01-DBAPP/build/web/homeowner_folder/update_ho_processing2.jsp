<%-- 
    Document   : update_ho_processing2
    Created on : 11 10, 23, 2:41:22 PM
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
        <title>Update Homeowner Record Processing</title>
    </head>
    <body>
        <form action="ho_index.html">
            <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
            <%  String v_firstname = request.getParameter("first_name");
                String v_lastname = request.getParameter("last_name"); 
                
                String old_lastname = h.lastname;
                String old_firstname = h.firstname;
                
                h.lastname = v_lastname;
                h.firstname = v_firstname;
                int s = h.update_homeowner();
           
                if (s==1) {
            %>
                <h1>Homeowner Record Updated Successfully!</h1><br>
                <% h.view_homeowner(); %>
                Old Homeowner Record:
                <pre class="tab">
                <b>Homeowner ID:</b>           <%=h.homeownerid%><br>
                <b>Last Name:</b>                    <%=old_lastname%><br>
                <b>First Name:</b>                   <%=old_firstname%><br>
                </pre><br>
                Updated Homeowner Record:
                <pre class="tab">
                <b>Homeowner ID:</b>           <%=h.homeownerid%><br>
                <b>Last Name:</b>                    <%=h.lastname%><br>
                <b>First Name:</b>                   <%=h.firstname%><br>
                </pre>
                
            <% } else {
            %>
                <h1>Field Input Invalid!</h1>
            <% }
            %>
            <input type="submit" value="Homeowner Menu"><br>
        </form> 
        <a href="update_ho.html" target="_self">
            <button>Update Homeowner Record</button>
        </a>
    </body>
</html>
