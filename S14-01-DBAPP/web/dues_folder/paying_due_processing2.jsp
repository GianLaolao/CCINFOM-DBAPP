<%-- 
    Document   : paying_due_processing2
    Created on : 11 12, 23, 9:54:17 PM
    Author     : ccslearner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
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
        <title>Paying Monthly Due Processing</title>
    </head>
    <body>
        <jsp:useBean id="h" class="tables_package.homeowner" scope="session"/>
        <jsp:useBean id="m" class="tables_package.monthly_dues" scope="session"/>
        <jsp:useBean id="p" class="tables_package.payment" scope="session"/>
        <form action="dues_index.html">
            <%  String v_dateGenerated = request.getParameter("dateGenerated");
                String v_amountpaid = request.getParameter("amountpaid");
                
                String[] v_dates = v_dateGenerated.split("-");
                
                h.homeownerid = p.homeownerid;
                h.view_homeowner();
                
                m.year = Integer.parseInt(v_dates[0]);
                m.month = Integer.parseInt(v_dates[1]);
                m.getDueBalance();
              
                
                p.amountpaid = Double.parseDouble(v_amountpaid);
                p.monthlydueYear = Integer.parseInt(v_dates[0]);
                p.monthlydueMonth = Integer.parseInt(v_dates[1]);
                p.dueamount = m.ongoingbalance;
                
                int s = p.payDue();
                
                if (s==1) {
            %>
                <h1>Payment Receipt</h1>
                <pre class="tab">
                <b>Payment ID:</b>                              <%=p.paymentid%><br>
                <b>Name:</b>                                    <%=h.lastname + ", " + h.firstname%><br>
                <b>Monthly Due Date:</b>                     <%=p.monthlydueYear%>-<%=p.monthlydueMonth%><br>
                <b>Amount Paid:</b>                         <%=p.amountpaid%><br>
                <b>Change:</b>                                  <%=p.amountchange%><br>
                <b>Payment Date:</b>                       <%=p.paymentdate%><br><br>
                </pre>
                
            <% } else { %>
                <h1>Inputs Invalid</h1>
            <% }
            %>
            <input type="submit" value="Dues Menu"><br>
        </form>   
        <button onclick="location.href='paying_due.html'" type="button"> Pay Monthly Due </button>
    </body>
</html>
