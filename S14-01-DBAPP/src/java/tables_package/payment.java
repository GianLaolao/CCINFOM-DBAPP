/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tables_package;

/**
 *
 * @author ccslearner
 */
import java.util.*;
import java.sql.*;
import java.time.*;

public class payment {
    
    public int paymentid;
    public int homeownerid;
    public int monthlydueYear;
    public int monthlydueMonth;
    public double amountpaid;
    public double amountchange;
    public String paymentdate;
    
    public double dueamount;
    
    public ArrayList<Integer> paymentid_list = new ArrayList<>();
    public ArrayList<Integer> homeownerid_list = new ArrayList<>();
    public ArrayList<Integer> monthlydueYear_list = new ArrayList<>();
    public ArrayList<Integer> monthlydueMonth_list = new ArrayList<>();
    public ArrayList<Double> amountpaid_list = new ArrayList<>();
    public ArrayList<Double> amountchange_list = new ArrayList<>();
    public ArrayList<String> paymentdate_list = new ArrayList<>();
    
    
    public int calcPayment() {
        
        if (amountpaid <= 0) {
            return 2;
        } else if (amountpaid <= dueamount) {
            return 1;
        }
        
        amountchange = amountpaid - dueamount;
        
        return 1;
    }
    
    
    public int payDue() {
        
        try {
            
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
     
            PreparedStatement stmt = conn.prepareStatement("SELECT MAX(paymentid)+1 AS newID FROM paying_due");
            ResultSet rst = stmt.executeQuery();
            while (rst.next()) {
                paymentid = rst.getInt("newID");
            }
            
            amountchange = 0;
            
            if (calcPayment() == 2) {
                return 2;
            }
            
       
            paymentdate = String.valueOf(java.time.LocalDate.now());
            
            stmt = conn.prepareStatement("INSERT INTO paying_due(paymentid, homeownerid, monthlydue_year, monthlydue_month, amountpaid, amount_change, payment_date) "
                                            + "VALUE (?,?,?,?,?,?,?)"); 
            stmt.setInt(1, paymentid);
            stmt.setInt(2, homeownerid);
            stmt.setInt(3, monthlydueYear);
            stmt.setInt(4, monthlydueMonth);
            stmt.setDouble(5, amountpaid); 
            stmt.setDouble(6, amountchange);
            stmt.setString(7, paymentdate);
            stmt.executeUpdate();
            
            System.out.println("Reach insert");
            
            stmt = conn.prepareStatement("UPDATE monthlydue\n" +
                                         "SET ongoing_balance = ongoing_balance - ?\n" +
                                         "WHERE homeownerid = ? AND year = ? AND month =?");
            stmt.setDouble(1, amountpaid - amountchange);
            stmt.setInt(2, homeownerid);
            stmt.setInt(3, monthlydueYear);
            stmt.setInt(4, monthlydueMonth);
            stmt.executeUpdate();   
            
            if (amountpaid >= dueamount) {
                stmt = conn.prepareStatement("UPDATE monthlydue\n" +
                                             "SET status = 'PAID'\n" +
                                             "WHERE homeownerid = ? AND year = ? AND month =?");
                stmt.setInt(1, homeownerid);
                stmt.setInt(2, monthlydueYear);
                stmt.setInt(3, monthlydueMonth);
                stmt.executeUpdate();
            }
            
            stmt.close();
            conn.close();
            return 1;
           
        } catch (Exception e) {
           System.out.println(e.getMessage());
           return 0;    
        }
    }
    
    public int searchPayments(int pay_year, int pay_month) {
       
        try {
           
           Connection conn;
           conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
           System.out.println("Connection Successful");
           
           paymentid_list.clear();
           homeownerid_list.clear();
           monthlydueYear_list.clear();
           monthlydueMonth_list.clear();
           amountpaid_list.clear();
           amountchange_list.clear();
           paymentdate_list.clear();
           
           String q = "SELECT * \n" +
                      "FROM paying_due\n" +
                      "WHERE homeownerid = ?\n";
           
           if (pay_year != 0) {
               q += "AND YEAR(payment_date) = ?\n";
           }
           if (pay_month != 0) {
               q += "AND MONTH(payment_date) = ?\n";
           }
           
           PreparedStatement stmt = conn.prepareStatement(q);
           stmt.setInt(1, homeownerid);
           
           if (pay_year != 0 && pay_month != 0) {
               stmt.setInt(2, pay_year);
               stmt.setInt(3, pay_month);
           }
           else if (pay_year != 0) {
               stmt.setInt(2, pay_year);
           }
           else if (pay_month != 0) {
               stmt.setInt(2, pay_month);
           }
           
           ResultSet rst = stmt.executeQuery();
           while(rst.next()){
               paymentid = rst.getInt("paymentid");
               monthlydueYear = rst.getInt("monthlydue_year");
               monthlydueMonth = rst.getInt("monthlydue_month");
               amountpaid = rst.getDouble("amountpaid");
               amountchange = rst.getDouble("amount_change");
               paymentdate = rst.getString("payment_date");
               
               paymentid_list.add(paymentid);
               monthlydueYear_list.add(monthlydueYear);
               monthlydueMonth_list.add(monthlydueMonth);
               amountpaid_list.add(amountpaid);
               amountchange_list.add(amountchange);
               paymentdate_list.add(paymentdate);
           }
           
           if (paymentid_list.isEmpty()) {
               return 2;
           }
           
           
           stmt.close();
           conn.close();
           return 1;
        } catch (Exception e) {
           System.out.println(e.getMessage());
           return 0; 
        }
    }
    
    public int getDistinct() {
        
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement stmt;
            ResultSet rst;
            
            monthlydueYear_list.clear();
            
            stmt = conn.prepareStatement("SELECT DISTINCT(YEAR(payment_date)) AS Year\n" +
                                                 "FROM paying_due;");
            rst = stmt.executeQuery();
            while (rst.next()) {                     
                int n = rst.getInt("Year");
                        monthlydueYear_list.add(n);
            }
            
            
           return 1;
       } catch (Exception e) {
           System.out.println(e.getMessage());
           return 0;
       } 
        
        
    }
    
    
    public static void main (String args[]) {
      
    }
}
