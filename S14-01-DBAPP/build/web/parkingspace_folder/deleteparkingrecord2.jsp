<%-- 
    Document   : deleteparkingrecord2
    Created on : 11 13, 23, 11:43:13 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, tables_package.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Deletion</title>
    </head>
    <body>
        <form action="deleteparking_processing.jsp">
            <jsp:useBean id="A" class="tables_package.parkingspace" scope="session" />
            <%
                int v_parkingspace_no = Integer.parseInt(request.getParameter("parkingspaceno"));
                String v_parkingspace_street = request.getParameter("street");

                A.parkingspace_no = v_parkingspace_no;
                A.parkingspace_street = v_parkingspace_street;
                int status = A.get_parkingrecord();
                int status2 = A.check_parkingrecord();
                
                if(status2 == 0) {
                    if(status == 1) {
            %>
                        You chose the following record:<br>
                        Street:     <%= A.parkingspace_street %>   <input type="hidden" name="street"         value="<%= A.parkingspace_street %>"   ><br>
                        Slot:       <%= A.parkingspace_no %>       <input type="hidden" name="parkingspaceno" value="<%= A.parkingspace_no %>"       ><br> 
                        Status:     <%= A.parkingspace_status %>   <input type="hidden" name="status"         value="<%= A.parkingspace_status %>"   ><br>
                        Rent Price: <%= A.parkingspace_rentprice %><input type="hidden" name="rent_price"     value="<%= A.parkingspace_rentprice %>"><br>
                        <br>
                        Are you sure you want to delete this record?<br>
                        <input type="submit" value="Delete Record"><br>
            <%      } else {
            %>
                        <h1>Record Not Found</h1><br
                        <button onclick="location.href='deleteparkingrecord.jsp'" type="button"> Delete Parking Space </button>
            <%      }
                } else {
            %>
                        <h1>Record Cannot be deleted</h1><br>
                        <button onclick="location.href='deleteparkingrecord.jsp'" type="button"> Delete Parking Space </button>
            <%  }
            %>
        </form>
        <form action="deleteparkingrecord.jsp"><input type="submit" value="Back"><br></form>
    </body>
</html>
