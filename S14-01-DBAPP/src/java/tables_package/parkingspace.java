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
public class parkingspace {
    
    //fields of parking space
    public int    parkingspace_no;
    public String parkingspace_street;
    public String parkingspace_status;
    public double parkingspace_rentprice;

    public ArrayList<String>  refstreetList      = new ArrayList<> ();
    
    public ArrayList<Integer> parking_noList     = new ArrayList<> ();
    public ArrayList<String>  parking_streetList = new ArrayList<> ();
    public ArrayList<String>  parking_statusList = new ArrayList<> ();
    public ArrayList<Double>  parking_rentpriceList = new ArrayList<> ();
    
    //Lists for the Report
    public int year;
    public int month;
    public int totalrentees;
    public ArrayList<Integer> parking_yearList         = new ArrayList<> ();
    public ArrayList<Integer> parking_monthList        = new ArrayList<> ();
    public ArrayList<Integer> parking_totalrenteesList = new ArrayList<> ();
    public ArrayList<Integer> parking_rentyearList     = new ArrayList<> ();
    
    public ArrayList<String> months = new ArrayList<> ();

    
    public parkingspace() {}
    
    public void get_months() {
        months.clear();
        
        months.add("Jan");
        months.add("Feb");
        months.add("Mar");
        months.add("Apr");
        months.add("May");
        months.add("Jun");
        months.add("Jul");
        months.add("Aug");
        months.add("Sep");
        months.add("Oct");
        months.add("Nov");
        months.add("Dec");
    }
    
    public int get_rentyearList() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT DISTINCT YEAR(rentdate) AS rentyears FROM renting_parkingspace;");
            ResultSet rst = pstmt.executeQuery();
            
            parking_rentyearList.clear();

            while (rst.next()) {
                parking_rentyearList.add(rst.getInt("rentyears"));
            }
            
            pstmt.close();
            conn.close();
            return 1;
        } catch(Exception e) {
            System.err.println(e.getMessage());
            return 0;
        }
    }
    
    //returns parkingspaceno based on street
    public int get_slots() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT parkingspaceno FROM parkingspace WHERE street = ?");
            pstmt.setString(1, parkingspace_street);
            ResultSet rst = pstmt.executeQuery();
            
            parking_noList.clear();

            while (rst.next()) {
                parking_noList.add(rst.getInt("parkingspaceno"));
            }
            
            pstmt.close();
            conn.close();
            return 1;
        } catch(Exception e) {
            System.err.println(e.getMessage());
            return 0;
        }
    }
    
    public int get_refstreetList() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM ref_street");
            ResultSet rst = pstmt.executeQuery();
            
            refstreetList.clear();

            while (rst.next()) {
                refstreetList.add(rst.getString("street"));
            }
            
            pstmt.close();
            conn.close();
            return 1;
        } catch(Exception e) {
            System.err.println(e.getMessage());
            return 0;
        }
    }
    
    // checks if a parking record is being used in another table
    public int check_parkingrecord() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace WHERE street = ? AND parkingspaceno = ?");
            pstmt.setString(1, parkingspace_street);
            pstmt.setInt(2, parkingspace_no);
            ResultSet rst = pstmt.executeQuery();
            if (rst.isBeforeFirst()) {
                System.out.println("Record found");
                pstmt.close();
                conn.close();
                return 1;
            } else {
                pstmt.close();
                conn.close();
                return 0;
            }
            
            
        } catch(Exception e) {
            System.err.println(e.getMessage());
            return 0;
        }
    }
    
    // gets a single parking record based on parkingspace_no and street
    public int get_parkingrecord() {
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM parkingspace WHERE street = ? AND parkingspaceno = ?");
            pstmt.setString(1, parkingspace_street);
            pstmt.setInt(2, parkingspace_no);
            ResultSet rst = pstmt.executeQuery();
            if (!rst.isBeforeFirst()) {
                System.out.println("No record found");
                return 0;
            }
            while (rst.next()) {
                parkingspace_status    = rst.getString("status");
                parkingspace_rentprice = rst.getDouble("rent_price");
            }
            
            pstmt.close();
            conn.close();
            return 1;
        } catch(Exception e) {
            System.err.println(e.getMessage());
            return 0;
        }
    }
    
    
    public int create_parkingspace() {
        try {
            //code that will interact with the DB
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(parkingspaceno) + 1 AS newSlot FROM parkingspace WHERE street = ?");
            pstmt.setString(1, parkingspace_street);
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                parkingspace_no = rst.getInt("newSlot");
            }
            
            if(parkingspace_no == 0) {
                parkingspace_no = 1;
            }   
            
            pstmt = conn.prepareStatement("INSERT INTO parkingspace (parkingspaceno, street, status, rent_price) VALUE (?, ?, ?, ?)");
            pstmt.setInt(1, parkingspace_no);
            pstmt.setString(2, parkingspace_street);
            parkingspace_status = "Available";
            pstmt.setString(3, parkingspace_status);
            pstmt.setDouble(4, parkingspace_rentprice);
            
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            return 1;
            
        } catch(Exception e) {
            System.err.println(e.getMessage());
            return 0;
        }
        
    }
    
    public int update_parkingspace() {
        try {
            //code that will interact with the DB
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            if(parkingspace_rentprice < 0) {
                return 0;
            }
            
            PreparedStatement pstmt = conn.prepareStatement("UPDATE parkingspace\n" +
                                                            "SET status = ?, rent_price = ?\n" +
                                                            "WHERE parkingspaceno = ? AND street = ?");
            pstmt.setString(1, parkingspace_status);
            pstmt.setDouble(2, parkingspace_rentprice);
            pstmt.setInt(3, parkingspace_no);
            pstmt.setString(4, parkingspace_street);

            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            return 1;
            
        } catch(Exception e) {
            System.err.println(e.getMessage());
            return 0;
        }
    }
    
    // delete a parkingspace record 
    public int delete_parkingspace() {
        try {
            //code that will interact with the DB
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM parkingspace WHERE street = ? AND parkingspaceno = ?");
            pstmt.setString(1, parkingspace_street);
            pstmt.setInt(2, parkingspace_no);
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            return 1;
            
        } catch(Exception e) {
            System.err.println(e.getMessage());
            return 0;
        }
    }
    
    public int search_parkingspaces() {
        try {
            //code that will interact with the DB
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            String q = "SELECT * FROM parkingspace\n";
            
            parking_noList.clear();
            parking_streetList.clear();
            parking_statusList.clear();
            parking_rentpriceList.clear();
            
            boolean a = false, b = false, c = false;

            PreparedStatement pstmt = conn.prepareStatement(q);
            
            if(parkingspace_no != -1) { // slot is not blank
                if(!parkingspace_street.equals("0")) { // street is not blank
                    if(!parkingspace_status.equals("0")) { // status is not blank
                        if(parkingspace_rentprice != -1)  {// rent price is not blank
                            q += "WHERE parkingspaceno = ? AND street = ? AND status = ? AND rent_price <= ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setString(2, parkingspace_street);
                            pstmt.setString(3, parkingspace_status);
                            pstmt.setDouble(4, parkingspace_rentprice);
                        } else { // rent price is blank
                            q += "WHERE parkingspaceno = ? AND street = ? AND status = ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setString(2, parkingspace_street);
                            pstmt.setString(3, parkingspace_status);
                        }
                    } else { // status is blank
                        if(parkingspace_rentprice != -1)  {// rent price is not blank
                            q += "WHERE parkingspaceno = ? AND street = ? AND rent_price <= ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setString(2, parkingspace_street);
                            pstmt.setDouble(3, parkingspace_rentprice);
                        } else { // rent price is blank
                            q += "WHERE parkingspaceno = ? AND street = ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setString(2, parkingspace_street);
                        }
                    }
                } else { // street is blank
                    if(!parkingspace_status.equals("0")) { // status is not blank
                        if(parkingspace_rentprice != -1)  {// rent price is not blank
                            q += "WHERE parkingspaceno = ? AND status = ? AND rent_price <= ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setString(2, parkingspace_status);
                            pstmt.setDouble(3, parkingspace_rentprice);
                        } else { // rent price is blank
                            q += "WHERE parkingspaceno = ? AND status = ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setString(2, parkingspace_status);
                        }
                    } else { // status is blank
                        if(parkingspace_rentprice != -1)  {// rent price is not blank
                            q += "WHERE parkingspaceno = ? AND rent_price <= ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setDouble(2, parkingspace_rentprice);
                        } else { // rent price is blank
                            q += "WHERE parkingspaceno = ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                        }
                    }
                }
            } else { // slot is blank
                if(!parkingspace_street.equals("0")) { // street is not blank
                    if(!parkingspace_status.equals("0")) { // status is not blank
                        if(parkingspace_rentprice != -1)  {// rent price is not blank
                            q += "WHERE street = ? AND status = ? AND rent_price <= ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setString(1, parkingspace_street);
                            pstmt.setString(2, parkingspace_status);
                            pstmt.setDouble(3, parkingspace_rentprice);
                        } else { // rent price is blank
                            q += "WHERE street = ? AND status = ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setString(1, parkingspace_street);
                            pstmt.setString(2, parkingspace_status);
                        }
                    } else { // status is blank
                        if(parkingspace_rentprice != -1)  {// rent price is not blank
                            q += "WHERE street = ? AND rent_price <= ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setString(1, parkingspace_street);
                            pstmt.setDouble(2, parkingspace_rentprice);
                        } else { // rent price is blank
                            q += "WHERE street = ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setString(1, parkingspace_street);
                        }
                    }
                } else { // street is blank
                    if(!parkingspace_status.equals("0")) { // status is not blank
                        if(parkingspace_rentprice != -1)  {// rent price is not blank
                            q += "WHERE status = ? AND rent_price <= ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setString(1, parkingspace_status);
                            pstmt.setDouble(2, parkingspace_rentprice);
                        } else { // rent price is blank
                            q += "WHERE status = ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setString(1, parkingspace_status);
                        }
                    } else { // status is blank
                        if(parkingspace_rentprice != -1)  {// rent price is not blank
                            q += "WHERE rent_price <= ?\n" +
                                 "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setDouble(1, parkingspace_rentprice);
                        } else { // rent price is blank
                            q += "ORDER BY street, parkingspaceno, rent_price DESC";
                            pstmt = conn.prepareStatement(q);
                        }
                    }
                }
            }
            
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                int t_parkingspaceno = rst.getInt("parkingspaceno");
                String t_street      = rst.getString("street");
                String t_status      = rst.getString("status");
                double t_rentprice   = rst.getDouble("rent_price");
                parking_noList.add(t_parkingspaceno);
                parking_streetList.add(t_street);
                parking_statusList.add(t_status);
                parking_rentpriceList.add(t_rentprice);
            }
            
            
            
            pstmt.close();
            conn.close();
            return 1;
            
        } catch(Exception e) {
            System.err.println(e.getMessage());
            return 0;
        }
    }
    
    public int generate_parkingreport() {
        try {
            //code that will interact with the DB
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            String q = "SELECT parkingspaceno, street, YEAR(rentdate) as rentyear, MONTH(rentdate) as rentmonth, COUNT(parkingspaceno) AS totalrentees\n" +
                       "FROM renting_parkingspace \n";
  
            parking_noList.clear();
            parking_streetList.clear();
            parking_yearList.clear();
            parking_monthList.clear();
            parking_totalrenteesList.clear();
            
            boolean a = false, b = false, c = false;

            PreparedStatement pstmt = conn.prepareStatement(q);
            
            // RENT PRICE >> MONTH
            // STATUS     >> YEAR
            
            if(parkingspace_no != -1) { // slot is not blank
                if(!parkingspace_street.equals("0")) { // street is not blank
                    if(year != -1)                      { // year is not blank
                        if(month != -1)                     {// month is not blank
                            q += "WHERE parkingspaceno = ? AND street = ? AND YEAR(rentdate) = ? AND MONTH(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setString(2, parkingspace_street);
                            pstmt.setInt(3, year);
                            pstmt.setDouble(4, month);
                        } else { // month is blank
                            q += "WHERE parkingspaceno = ? AND street = ? AND YEAR(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setString(2, parkingspace_street);
                            pstmt.setInt(3, year);
                        }
                    } else { // year is blank
                        if(month != -1)  {// month is not blank
                            q += "WHERE parkingspaceno = ? AND street = ? AND MONTH(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setString(2, parkingspace_street);
                            pstmt.setInt(3, month);
                        } else { // month is blank
                            q += "WHERE parkingspaceno = ? AND street = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setString(2, parkingspace_street);
                        }
                    }
                } else { // street is blank
                    if(year != -1) { // year is not blank
                        if(month != -1)  {// month is not blank
                            q += "WHERE parkingspaceno = ? AND YEAR(rentdate) = ? AND MONTH(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setInt(2, year);
                            pstmt.setInt(3, month);
                        } else { // month is blank
                            q += "WHERE parkingspaceno = ? AND YEAR(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setInt(2, year);
                        }
                    } else { // year is blank
                        if(month != -1)  {// month is not blank
                            q += "WHERE parkingspaceno = ? AND MONTH(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                            pstmt.setInt(2, month);
                        } else { // month is blank
                            q += "WHERE parkingspaceno = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, parkingspace_no);
                        }
                    }
                }
            } else { // slot is blank
                if(!parkingspace_street.equals("0")) { // street is not blank
                    if(year != -1) { // year is not blank
                        if(month != -1)  {// month is not blank
                            q += "WHERE street = ? AND YEAR(rentdate) = ? AND MONTH(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setString(1, parkingspace_street);
                            pstmt.setInt(2, year);
                            pstmt.setInt(3, month);
                        } else { // month is blank
                            q += "WHERE street = ? AND YEAR(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setString(1, parkingspace_street);
                            pstmt.setInt(2, year);
                        }
                    } else { // year is blank
                        if(month != -1)  {// month is not blank
                            q += "WHERE street = ? AND MONTH(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setString(1, parkingspace_street);
                            pstmt.setInt(2, month);
                        } else { // month is blank
                            q += "WHERE street = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setString(1, parkingspace_street);
                        }
                    }
                } else { // street is blank
                    if(year != -1) { // year is not blank
                        if(month != -1)  {// month is not blank
                            q += "WHERE YEAR(rentdate) = ? AND MONTH(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, year);
                            pstmt.setInt(2, month);
                        } else { // month is blank
                            q += "WHERE YEAR(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, year);
                        }
                    } else { // year is blank
                        if(month != -1)  {// month is not blank
                            q += "WHERE MONTH(rentdate) = ?\n" +
                                 "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" + 
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                            pstmt.setInt(1, month);
                        } else { // month is blank
                            q += "GROUP BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)\n" +
                                 "ORDER BY parkingspaceno, street, YEAR(rentdate), MONTH(rentdate)";
                            pstmt = conn.prepareStatement(q);
                        }
                    }
                }
            }
            
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                int t_parkingspaceno = rst.getInt("parkingspaceno");
                String t_street = rst.getString("street");
                int t_year = rst.getInt("rentyear");
                int t_month = rst.getInt("rentmonth");
                int t_totalrentees = rst.getInt("totalrentees");
                parking_noList.add(t_parkingspaceno);
                parking_streetList.add(t_street);
                parking_yearList.add(t_year);
                parking_monthList.add(t_month);
                parking_totalrenteesList.add(t_totalrentees);
            }
            
            pstmt.close();
            conn.close();
            return 1;
            
        } catch(Exception e) {
            System.err.println(e.getMessage());
            return 0;
        }
    }
    
    public static void main(String args[]) {
        
    }
}
