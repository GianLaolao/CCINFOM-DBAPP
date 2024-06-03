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
public class monthly_dues {
    
    public int homeownerid;
    public int year;
    public int month;
    public double ongoingbalance;
    public double monthlydue;
    public String dueDate;
    public String status;
    
    public static double def_due = 1000.00;
    
    public ArrayList<Integer> homeownerid_list = new ArrayList<>();
    public ArrayList<Integer> year_list = new ArrayList<>();
    public ArrayList<Integer> month_list = new ArrayList<>();
    public ArrayList<Double> ongoing_balance_list = new ArrayList<>();
    public ArrayList<Double> monthlydue_list = new ArrayList<>();
    public ArrayList<String> dueDate_list = new ArrayList<>();
    public ArrayList<String> status_list = new ArrayList<>();
    
    public String street;
    
    public ArrayList<String> street_list = new ArrayList<>();
    public ArrayList<Double> amountUnpaid_list = new ArrayList<>();
    public ArrayList<Double> amountPaid_list = new ArrayList<>();
    public ArrayList<Integer> countPaid_list = new ArrayList<>();
    public ArrayList<Integer> countUnpaid_list = new ArrayList<>();
    
    public int getDueBalance() {
        
        try {
            
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT ongoing_balance \n" +
                                                           "FROM monthlydue\n" +
                                                           "WHERE homeownerid = ? \n" +
                                                           "AND year = ? AND month = ?;");
            stmt.setInt(1, homeownerid); 
            stmt.setInt(2, year);
            stmt.setInt(3, month);
            
            ResultSet rst = stmt.executeQuery();
            while (rst.next()) {
                ongoingbalance = rst.getDouble("ongoing_balance");
            }
        
            stmt.close();
            conn.close();
            return 1;
        } catch(Exception e) {
           System.out.println(e.getMessage());
           return 0;
        }   
    }
    
    public int getAllDues(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            PreparedStatement ps = conn.prepareStatement("SELECT monthlydue.* FROM monthlydue");
            ResultSet rs = ps.executeQuery();
            
            homeownerid_list.clear();
            year_list.clear();
            month_list.clear();
            status_list.clear();
            dueDate_list.clear();
            ongoing_balance_list.clear();
            monthlydue_list.clear();
            
            while(rs.next()){
                homeownerid_list.add(rs.getInt("homeownerid"));
                year_list.add(rs.getInt("year"));
                month_list.add(rs.getInt("month"));
                ongoing_balance_list.add(rs.getDouble("ongoing_balance"));
                monthlydue_list.add(rs.getDouble("monthly_due"));
                dueDate_list.add(rs.getString("due_date"));
                status_list.add(rs.getString("status"));
            }
            
            conn.close();
            ps.close();
            
            return 1;
            
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return 0;
    }
    
    public int getDuesRecords () {
        
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            homeownerid_list.clear();
            year_list.clear();
            month_list.clear();
            ongoing_balance_list.clear();
            monthlydue_list.clear();
            dueDate_list.clear();
            status_list.clear();
            
            String q = "SELECT  *\n" +
                       "FROM   monthlydue\n" +
                       "WHERE  homeownerid = ?\n";
            
            PreparedStatement stmt = conn.prepareStatement(q);
            
            if (status.equals("PAID")) {
                q += "AND status = ?\n" +
                      "ORDER BY year, month";
                stmt = conn.prepareStatement(q);
                stmt.setString(2, "PAID");
            }
            else if (status.equals("UNPAID")) {
                q += "AND status = ?\n"+ 
                     "ORDER BY year, month";
                stmt = conn.prepareStatement(q);
                stmt.setString(2, "UNPAID");
            }
            else {
                q += "ORDER BY year, month";
                stmt = conn.prepareStatement(q);
            }
            
            stmt.setInt(1, homeownerid);
            
            ResultSet rst = stmt.executeQuery();
            while (rst.next()) {
                homeownerid = rst.getInt("homeownerid");
                year = rst.getInt("year");
                month = rst.getInt("month");
                ongoingbalance = rst.getDouble("ongoing_balance");
                monthlydue = rst.getDouble("monthly_due");
                dueDate = rst.getString("due_date");
                status = rst.getString("status");
                
                homeownerid_list.add(homeownerid);
                year_list.add(year);
                month_list.add(month);
                ongoing_balance_list.add(ongoingbalance);
                monthlydue_list.add(monthlydue);
                dueDate_list.add(dueDate);
                status_list.add(status);
            }
            
            if (homeownerid_list.isEmpty()) {
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
    
    private double calcExtraDue(int homeownerid, int year, int month) {
        
        try {
            
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            
            double extra = 0.00;
            int prev_month;
            int v_year;
            
            if (month - 1 == 0) {
                prev_month = 12;
                v_year = year - 1;
            }
            else {
                prev_month = month - 1;
                v_year = year;
            }
            
            
            PreparedStatement stmt = conn.prepareStatement("SELECT SUM(p.rent_price) AS extraDue\n" +
                                                           "FROM ho_parkspace h JOIN renting_parkingspace r\n" +
                                                           "                    ON h.rentid = r.rentid\n" +
                                                           "                    JOIN parkingspace p\n" +
                                                           "                    ON r.parkingspaceno = p.parkingspaceno AND r.street = p.street\n" +
                                                           "WHERE h.homeownerid = ? AND YEAR(r.rentdate) = ? AND MONTH(r.rentdate) = ?;");
            stmt.setInt(1, homeownerid);
            stmt.setInt(2, v_year);
            stmt.setInt(3, prev_month);
            
            ResultSet rst = stmt.executeQuery();
            if (rst.next()) {
                extra = rst.getDouble("extraDue");
            }
            
            
            stmt = conn.prepareStatement("SELECT t.tenantid, SUM(ps.rent_price) AS T_rent\n" +
                                            "FROM tenant_parkspace tp JOIN renting_parkingspace rp\n" +
                                            "					     ON rp.rentid = tp.rentid\n" +
                                            "                         JOIN parkingspace ps\n" +
                                            "                         ON (rp.parkingspaceno = ps.parkingspaceno AND rp.street = ps.street)\n" +
                                            "                         JOIN tenant t\n" +
                                            "                         ON tp.tenantid = t.tenantid\n" +
                                            "                         JOIN house h\n" +
                                            "                         ON h.houseid = t.houseid\n" +
                                            "                         JOIN homeowner ho\n" +
                                            "                         ON ho.homeownerid = h.homeownerid\n" +
                                            "WHERE h.homeownerid = ? AND YEAR(rp.rentdate) = ? AND MONTH(rp.rentdate) = ?\n" +
                                            "GROUP BY t.tenantid\n" +
                                            "ORDER BY t.tenantid");
            stmt.setInt(1, homeownerid);
            stmt.setInt(2, v_year);
            stmt.setInt(3, prev_month);
            rst = stmt.executeQuery();
            while (rst.next()) {
                extra += rst.getDouble("T_rent");
            }
            
            
            stmt.close();
            conn.close();
            return extra;
        } catch(Exception e) {
           System.out.println(e.getMessage());
           return 0;
        }   
    }
    
    
    public int createDue() {
        
         try {
            
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement stmt = conn.prepareStatement("SELECT homeownerid\n" +
                                                            "FROM homeowner \n" +
                                                            "WHERE homeownerid NOT IN (SELECT homeownerid FROM monthlydue WHERE year = ? AND month = ?)");
            
            LocalDate cur_date = java.time.LocalDate.now();
            int cur_year = cur_date.getYear();
            int cur_month = cur_date.getMonthValue();
            
            stmt.setInt(1, cur_year);
            stmt.setInt(2, cur_month);
            
            homeownerid_list.clear();
            
            ResultSet rst = stmt.executeQuery();
            while (rst.next()) {
                homeownerid = rst.getInt("homeownerid");
                homeownerid_list.add(homeownerid);
            }
            
            if (homeownerid_list.isEmpty()) 
                return 0;
            
            stmt = conn.prepareStatement("INSERT INTO monthlydue (homeownerid, year, month, ongoing_balance, monthly_due, due_date, status) \n" +
                                            "	VALUES (?, ?, ?, ?, ?, DATE_ADD(CURDATE(), INTERVAL 30 DAY), 'UNPAID')");
            stmt.setInt(2, cur_year);
            stmt.setInt(3, cur_month);
            
            for (int homeownerid : homeownerid_list) {
                double due = def_due + calcExtraDue(homeownerid, cur_year, cur_month);
                stmt.setInt(1, homeownerid);
                stmt.setDouble(4, due);
                stmt.setDouble(5, due);
                stmt.executeUpdate();
            }
            
        
            stmt.close();
            conn.close();
            return 1;
        } catch(Exception e) {
           System.out.println(e.getMessage());
           return 0;
        }   
    }
    
    
     public int getDueReport(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            PreparedStatement ps = conn.prepareStatement("SELECT h.street, SUM(m.ongoing_balance) AS amountUnpaid, SUM(p.amountpaid - p.amount_change) AS amountPaid, " +
                                                         "COUNT(p.paymentid) AS countPaid, (COUNT(m.homeownerid)-COUNT(p.paymentid)) AS countUnpaid " +
                                                         "FROM house h LEFT JOIN homeowner ho ON ho.homeownerid = h.homeownerid LEFT JOIN " +
                                                         "monthlydue m ON m.homeownerid = ho.homeownerid LEFT JOIN " +
                                                         "paying_due p ON m.homeownerid = p.homeownerid AND " +
                                                         "p.monthlydue_year = m.year AND p.monthlydue_month = m.month " +
                                                         "GROUP BY h.street ORDER BY h.street");
            ResultSet rs = ps.executeQuery();
            
            street_list.clear();
            amountPaid_list.clear();
            amountUnpaid_list.clear();
            countPaid_list.clear();
            countUnpaid_list.clear();
            
            while(rs.next()){
                street_list.add(rs.getString("street"));
                amountUnpaid_list.add(rs.getDouble("amountUnpaid"));
                amountPaid_list.add(rs.getDouble("amountPaid"));
                countPaid_list.add(rs.getInt("countPaid"));
                countUnpaid_list.add(rs.getInt("countUnpaid"));
            }
            
            conn.close();
            ps.close();
            
            return 1;
            
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return 0;
    }
     
     
    public int filterReport(){
        try{
            StringBuilder sb = new StringBuilder();
            String stmt = "";
            String end = "LEFT JOIN paying_due p ON m.homeownerid = p.homeownerid AND " +
"                         p.monthlydue_year = m.year AND p.monthlydue_month = m.month";
            
            sb.append("SELECT h.street, SUM(m.ongoing_balance) AS amountUnpaid, SUM(p.amountpaid - p.amount_change) AS amountPaid, " +
                      "COUNT(p.paymentid) AS countPaid, (COUNT(m.homeownerid)-COUNT(p.paymentid)) AS countUnpaid " +
                      "FROM house h LEFT JOIN homeowner ho ON ho.homeownerid = h.homeownerid ");
            
            if(!street.equals("")){
                stmt = "AND h.street=" + "\""+ street + "\"" + " LEFT JOIN " +
                       "monthlydue m ON m.homeownerid = ho.homeownerid ";
                sb.append(stmt);
                if(month != 0){
                    stmt = " AND m.month=" + month;
                    sb.append(stmt);
                }
                if(year != 0){
                    stmt = " AND m.year=" + year;
                    sb.append(stmt);
                }
                
                stmt = " " + end;
                sb.append(stmt);
            }else if(month != 0){
                sb.append("LEFT JOIN monthlydue m ON m.homeownerid = ho.homeownerid AND ");
                stmt = "m.month=" + month;
                sb.append(stmt);
                
                if(year != 0){
                    stmt = " AND m.year=" + year;
                    sb.append(stmt);
                }
                
                stmt = " " + end;
                sb.append(stmt);
            }else if(year != 0){
                sb.append("LEFT JOIN monthlydue m ON m.homeownerid = ho.homeownerid AND ");
                stmt = "m.year=" + year;
                sb.append(stmt);
                
                stmt = " " + end;
                sb.append(stmt);
            }
            
            sb.append(" GROUP BY h.street ORDER BY h.street");
            System.out.println(sb.toString());
            
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            PreparedStatement ps = conn.prepareStatement(sb.toString());
            ResultSet rs = ps.executeQuery();
            
            street_list.clear();
            amountPaid_list.clear();
            amountUnpaid_list.clear();
            countPaid_list.clear();
            countUnpaid_list.clear();
            
            while(rs.next()){
                street_list.add(rs.getString("street"));
                amountUnpaid_list.add(rs.getDouble("amountUnpaid"));
                amountPaid_list.add(rs.getDouble("amountPaid"));
                countPaid_list.add(rs.getInt("countPaid"));
                countUnpaid_list.add(rs.getInt("countUnpaid"));
            }
            
            conn.close();
            ps.close();
            
            return 1;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        
        return 0;
    }
    
    public static void main (String args[]) {            
    }
}
