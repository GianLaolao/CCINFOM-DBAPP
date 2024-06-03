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
public class tenants {
    
    public int      tenantid;
    public String   fname;
    public String   lname;
    public int      houseid;
    
    public ArrayList<Integer>   tenantidList        = new ArrayList<> ();
    public ArrayList<String>    tenant_fnameList    = new ArrayList<> ();
    public ArrayList<String>    tenant_lnameList    = new ArrayList<> ();
    public ArrayList<Integer>   tenant_houseNo      = new ArrayList<> ();
    public ArrayList<Integer>   hoa_houses          = new ArrayList<> ();
    
    public tenants(){}
    
    public int getTenants(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt = conn.prepareStatement("SELECT DISTINCT tenantid AS tenants FROM tenant");
            ResultSet rset = pstmt.executeQuery();
            
            tenantidList.clear();
            
            while (rset.next()){
                int hn = rset.getInt("tenants");
                tenantidList.add(hn);
            }
            pstmt.close();
            conn.close();
            System.out.println("Successful");
            return 1;
            
        } catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
    }
    public int getTenantInfo(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt = conn.prepareStatement("SELECT tenantid AS tenantID, houseid AS houseID, lastname AS lastName, firstname AS firstName FROM tenant ORDER BY tenantid ASC");
            ResultSet rset = pstmt.executeQuery();
            tenantidList.clear();
            tenant_fnameList.clear();
            tenant_lnameList.clear();
            tenant_houseNo.clear();
            
            while (rset.next()){
                int tID = rset.getInt("tenantID");
                String ln = rset.getString("lastName");
                String fn = rset.getString("firstName");
                int hNo = rset.getInt("houseID");
                tenantidList.add(tID);
                tenant_fnameList.add(fn);
                tenant_lnameList.add(ln);
                tenant_houseNo.add(hNo);
               
            }
            pstmt.close();
            conn.close();
            System.out.println("Successful");
            return 1;
        } catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int searchTenant(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt;
            
            if (houseid!=0){
                if (!lname.equals("0")){
                    if (!fname.equals("0")){
                            pstmt = conn.prepareStatement("SELECT * FROM tenant WHERE houseid = ? AND lastname = ? AND firstname = ?\n"
                                    + "ORDER BY houseid, lastname, firstname");
                            pstmt.setInt(1, houseid);
                            pstmt.setString(2, lname);
                            pstmt.setString(3, fname);
                        } else{
                            pstmt = conn.prepareStatement("SELECT * FROM tenant WHERE houseid = ? AND lastname =?\n"
                                    + "ORDER BY houseid, lastname");
                            pstmt.setInt(1, houseid);
                            pstmt.setString(2, lname);
                        }
                    } else {
                        if (!fname.equals("0")){
                            pstmt = conn.prepareStatement("SELECT * FROM tenant WHERE houseid = ? AND firstname = ?\n"
                                    + "ORDER BY houseid, firstname");
                            pstmt.setInt(1, houseid);
                            pstmt.setString(2, fname);
                        } else{
                            pstmt = conn.prepareStatement("SELECT * FROM tenant WHERE houseid = ?\n"
                                    + "ORDER BY houseid");
                            pstmt.setInt(1, houseid);
                        }
                    }
                } else {
                    if (!lname.equals("0")){
                        if (!fname.equals("0")){
                            pstmt = conn.prepareStatement("SELECT * FROM tenant WHERE lastname = ? AND firstname = ?\n"
                                    + "ORDER BY lastname, firstname");
                            pstmt.setString(1, lname);
                            pstmt.setString(2, fname);
                        } else{
                            pstmt = conn.prepareStatement("SELECT * FROM tenant WHERE lastname =?\n"
                                    + "ORDER BY lastname");
                            pstmt.setString(1, lname);
                        }
                    } else {
                        if (!fname.equals("0")){
                            pstmt = conn.prepareStatement("SELECT * FROM tenant WHERE firstname = ?\n"
                                    + "ORDER BY firstname");
                            pstmt.setString(1, fname);
                        } else{
                            pstmt = conn.prepareStatement("SELECT * FROM tenant ");
                            
                        }
                    }
                }
        
            
            tenantidList.clear();
            tenant_houseNo.clear();
            tenant_lnameList.clear();
            tenant_fnameList.clear();
            
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()){
                tenantid = rset.getInt("tenantid");
                houseid = rset.getInt("houseid");
                lname = rset.getString("lastname");
                fname = rset.getString("firstname");
                tenantidList.add(tenantid);
                tenant_houseNo.add(houseid);
                tenant_lnameList.add(lname);
                tenant_fnameList.add(fname);
            }
            
            pstmt.close();
            conn.close();
            return 1;
        } catch (Exception e){
            return 0;
        }
    }
    
    public int getDistinctInfo(int id){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM tenant WHERE tenantid = ?");
            pstmt.setInt(1, id);
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()){
                tenantid = rset.getInt("tenantid");
                fname = rset.getString("firstname");
                lname = rset.getString("lastname");
                houseid = rset.getInt("houseid");
            }
            pstmt.close();
            conn.close();
            return 1;
        } catch (Exception e){
            
            return 0;
        }
    }
    
    public int deleteTenant(int id){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM tenant WHERE tenantid = ?");
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            
            return 1;
        } catch (Exception e){
            return 0;
        }
    }

    public int availHouses(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt = conn.prepareStatement("SELECT DISTINCT houseid AS houses FROM duesDB.house ORDER BY houseid");
            ResultSet rset = pstmt.executeQuery();
            
            hoa_houses.clear();
            
            while (rset.next()){
                int hn = rset.getInt("houses");
                hoa_houses.add(hn);
            }
            pstmt.close();
            conn.close();
            System.out.println("Successful");
            return 1;
            
        } catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
    }
    public int createTenant(){
        
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(tenantid) + 1 AS newtenant FROM tenant");
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()){
                tenantid = rset.getInt("newtenant");
            }
            
            pstmt = conn.prepareStatement("INSERT INTO tenant (tenantid, houseid, lastname, firstname) VALUE ( ?, ?, ?, ?)");
            pstmt.setInt(1, tenantid);
            pstmt.setInt(2, houseid);
            pstmt.setString(3, lname);
            pstmt.setString(4, fname);
            
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return 1;
            
        } catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int updateTenant(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt = conn.prepareStatement("UPDATE tenant SET houseid = ?, lastname = ?, firstname = ? WHERE tenantID = ?");
            
            pstmt.setInt(1, houseid);
            pstmt.setString(2, lname);
            pstmt.setString(3, fname);
            pstmt.setInt(4, tenantid);
            
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return 1;
        }catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
    }
        
    
    public static void main(String args[]){
           tenants T = new tenants();
           T.houseid = 2006;
           T.lname = "Mr.";
           T.fname = "Mime";
           T.tenantid = 3008;
           
           System.out.println(T.updateTenant());
    }
}
