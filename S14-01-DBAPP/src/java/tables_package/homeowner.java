package tables_package;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ccslearner
 */
import java.util.*;
import java.sql.*;

public class homeowner {
    
    public int homeownerid;
    public String lastname;
    public String firstname;
    
    public ArrayList<Integer> homeownerid_list = new ArrayList<>();
    public ArrayList<String> lastname_list = new ArrayList<>();
    public ArrayList<String> firstname_list = new ArrayList<>();
    
    
    public int check_homeowner() {
        
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement stmt = conn.prepareStatement( "SELECT homeownerid FROM homeowner\n" +
                                                            "WHERE  homeownerid = ?;");
            stmt.setInt(1,homeownerid);
            ResultSet rst = stmt.executeQuery();
            
            if (!rst.next()) {
                stmt.close();
                conn.close();
                return 0;
            }
            
            stmt.close();
            conn.close();
            return 1;
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    
    public int create_homeowner() {
        
        try {

            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");

            PreparedStatement stmt = conn.prepareStatement("SELECT MAX(homeownerid)+1 AS newID FROM homeowner");
            ResultSet rst = stmt.executeQuery();
            if (rst.next()) {
                homeownerid = rst.getInt("newID");
            } else {
                return 1001;
            }
            

            stmt = conn.prepareStatement("INSERT INTO homeowner(homeownerid, lastname, firstname) VALUE (?,?,?)"); 
            stmt.setInt(1, homeownerid);
            stmt.setString(2, lastname);
            stmt.setString(3, firstname);  
            stmt.executeUpdate();

            stmt.close();
            conn.close();
            return 1;

        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
        
       
    }
    
    public int getID() {
        
       try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            homeownerid_list.clear();
            lastname_list.clear();
            firstname_list.clear();
            
            PreparedStatement stmt = conn.prepareStatement("SELECT  homeownerid, lastname, firstname\n" +
                                                            "FROM   homeowner\n" +
                                                            "ORDER BY lastname, firstname");
            ResultSet rst = stmt.executeQuery();
            while (rst.next()) {
                homeownerid = rst.getInt("homeownerid");
                lastname = rst.getString("lastname");
                firstname = rst.getString("firstname");
                homeownerid_list.add(homeownerid);
                lastname_list.add(lastname);
                firstname_list.add(firstname);
            }
            
           return 1;
       } catch (Exception e) {
           System.out.println(e.getMessage());
           return 0;
       }
    }
       
    public int getDistinct(int c) {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            lastname_list.clear();
            firstname_list.clear();
            
            PreparedStatement stmt;
            ResultSet rst;
            
            switch(c) {
                case 0:
                    stmt = conn.prepareStatement("SELECT DISTINCT(lastname) FROM homeowner\n"+
                                                 "ORDER BY lastname");
                    rst = stmt.executeQuery();
                    while (rst.next()) {                     
                        lastname = rst.getString("lastname");
                        lastname_list.add(lastname);
                    }
                    break;
                case 1:
                    stmt = conn.prepareStatement("SELECT DISTINCT(firstname) FROM homeowner\n" +
                                                 "ORDER BY firstname");
                    rst = stmt.executeQuery();
                    while (rst.next()) {                     
                        firstname = rst.getString("firstname");
                        firstname_list.add(firstname);
                    }
                    break;
            }
                                    
           return 1;
       } catch (Exception e) {
           System.out.println(e.getMessage());
           return 0;
       }    
    }
        
    public int update_homeowner() {
        
        if (!lastname.equals("") && !firstname.equals("")) { 
            try {

                Connection conn;
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
                System.out.println("Connection Successful");

                PreparedStatement stmt = conn.prepareStatement("UPDATE  homeowner\n" +
                                                               "SET     lastname = ?, firstname = ?\n" +
                                                               "WHERE   homeownerid = ?;");
                stmt.setString(1,lastname);
                stmt.setString(2, firstname);
                stmt.setInt(3, homeownerid);
                
                
                stmt.executeUpdate();
                
                stmt.close();
                conn.close();
                return 1;

            } catch (Exception e) {
                System.out.println(e.getMessage());
                return 0;
            }
        }
        return 0;
    }
    
    public int delete_homeowner() {
        
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT homeownerid\n" +
                                                           "FROM homeowner\n" +
                                                           "WHERE homeownerid = ? AND (homeownerid IN (SELECT homeownerid FROM monthlydue)\n" +
                                                           "OR homeownerid IN (SELECT homeownerid FROM house)\n" +
                                                           "OR homeownerid IN (SELECT homeownerid FROM ho_parkspace)\n" +
                                                           "OR homeownerid IN (SELECT homeownerid FROM paying_due))");
            stmt.setInt(1,homeownerid);
            ResultSet rst = stmt.executeQuery();
            if (rst.next()) {
                stmt.close();
                conn.close();        
                return 0;
            }    
            
            stmt = conn.prepareStatement("DELETE FROM homeowner\n" +
                                         "WHERE homeownerid = ?; ");
            stmt.setInt(1, homeownerid);
            stmt.executeUpdate();
            
            stmt.close();
            conn.close();    
           return 1;
       } catch (Exception e) {
           System.out.println(e.getMessage());
           return 0;
       }            
    }
    
    
    public int search_homeowner() {
        
         try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            String q =  "SELECT * FROM 	homeowner\n";
            PreparedStatement stmt = conn.prepareStatement(q);
            
            homeownerid_list.clear();
            lastname_list.clear();
            firstname_list.clear();
             
            if (!lastname.equals("0") && !firstname.equals("0")) {
               q += "WHERE lastname = ? AND firstname = ?\n"
                     + "ORDER BY lastname, firstname";
               stmt = conn.prepareStatement(q);
               stmt.setString(1,lastname);
               stmt.setString(2, firstname);
            }
            else if (!lastname.equals("0")) {
               q += "WHERE lastname =?\n"
                     + "ORDER BY lastname, firstname";
               stmt = conn.prepareStatement(q);
               stmt.setString(1,lastname);
            }
            else if (!firstname.equals("0")){
               q += "WHERE firstname =?\n"
                    + "ORDER BY lastname, firstname";
               stmt = conn.prepareStatement(q);
               stmt.setString(1,firstname);
            }
            else {
                q += "ORDER BY lastname, firstname";
                stmt = conn.prepareStatement(q);
            }
              
            ResultSet rst = stmt.executeQuery();
            while (rst.next()) {
                homeownerid = rst.getInt("homeownerid");
                lastname = rst.getString("lastname");
                firstname = rst.getString("firstname");
                homeownerid_list.add(homeownerid);
                lastname_list.add(lastname);
                firstname_list.add(firstname);
            }
            
            if(homeownerid_list.isEmpty()) {
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
    
    
    public int view_homeowner() {
          
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement stmt = conn.prepareStatement( "SELECT  * FROM homeowner\n" +
                                                            "WHERE  homeownerid = ?;");
            stmt.setInt(1,homeownerid);
            ResultSet rst = stmt.executeQuery();
            while (rst.next()) {
                homeownerid = rst.getInt("homeownerid");
                lastname = rst.getString("lastname");
                firstname = rst.getString("firstname");
            }
            
            
            stmt.close();
            conn.close();
            return 1;
            
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    
    public static void main (String args[]) {
     
    }
}
