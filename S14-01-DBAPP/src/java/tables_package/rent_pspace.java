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

public class rent_pspace {
    
    public int rentid;
    public int tenantid;
    public int ho_id;
    public int parkingspaceno;
    public String spaceSt;
    public int price;
    
    public ArrayList<Integer> rentidList = new ArrayList<> ();
    public ArrayList<Integer> tenantidList = new ArrayList<> ();
    public ArrayList<Integer> ho_idList = new ArrayList<> ();
    public ArrayList<Integer> parkingNoList = new ArrayList<> ();
    public ArrayList<String> spaceStList = new ArrayList<> ();
    public ArrayList<Integer> priceList = new ArrayList<> ();
        
    public rent_pspace(){
        
    }
    public int getrentInfo(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            
            return 1;
        } catch (Exception e){
            return 0;
        }
    }
    
    public int checkSpaces(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt = conn.prepareStatement("UPDATE parkingspace ps " +
                                            "INNER JOIN renting_parkingspace rp " +
                                            "ON ps.parkingspaceno = rp.parkingspaceno " +
                                            "AND ps.street = rp.street " +
                                            "SET ps.status = 'Available' " +
                                            "WHERE rp.rentdate != curdate() " +
                                            "AND rp.rentdate = (SELECT MAX(rentdate) " +
                                                                "FROM renting_parkingspace " +
                                                                "WHERE parkingspaceno = ps.parkingspaceno " +
                                            "AND street = ps.street)");
            pstmt.executeUpdate();
            pstmt.close();
            conn.close();
            return 1;
            
        } catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
            
    }
    
    
    public int gethoInfo(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            ho_idList.clear();
            PreparedStatement stmt = conn.prepareStatement("SELECT  homeownerid AS homeowner FROM   homeowner ORDER BY homeownerid ASC");
            ResultSet rset = stmt.executeQuery();
            while (rset.next()){
                ho_idList.add(rset.getInt("homeowner"));
            }
            
            stmt.executeUpdate();
            stmt.close();
            conn.close();
            System.out.println("Successful");
            return 1;
        } catch (Exception e){
            return 0;
        }
    }
    
    public int getTInfo(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            tenantidList.clear();
            PreparedStatement stmt = conn.prepareStatement("SELECT tenantid AS tenantID FROM tenant ORDER BY tenantid ASC");
            ResultSet rset = stmt.executeQuery();
            
            while (rset.next()){
                tenantidList.add(rset.getInt("tenantID"));
            }
            
            
            stmt.close();
            conn.close();
            System.out.println("Successful");
            return 1;
        } catch (Exception e){
            return 0;
        }
    }
    
    public int checkSpace(int sl, String st){
        try{
            getSpaceInfo();
            int flag= 2; 
            for (int i=0; i < parkingNoList.size(); i++){
                if ((st.equals(spaceStList.get(i))) && (sl == parkingNoList.get(i))){
                    flag = 1;
                }
            }
            return flag; //returning 2 means user's input is not in available parking spaces list else 1
        } catch (Exception e){
            return 0;
        }
    }
    
    public int getAllRented(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            parkingNoList.clear();
            spaceStList.clear();
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT parkingspaceno AS parkingNo, street AS streetName FROM renting_parkingspace");
            ResultSet rset = pstmt.executeQuery();
            
            while (rset.next()){
                parkingNoList.add(rset.getInt("parkingNo"));
                spaceStList.add(rset.getString("streetName"));
            }
            pstmt.close();
            conn.close();
            return 1;
        } catch (Exception e){
            return 0;
        }
    }
    
    public ArrayList<Integer> getSlots(String street, int type){
        ArrayList<Integer> arr = new ArrayList<> ();
        try{
            for (int i =0; i < parkingNoList.size(); i++){
                if (spaceStList.get(i).equals(street)){
                    arr.add(parkingNoList.get(i));
                }
            }
            return arr;
        } catch(Exception e){
            
            return arr;
        }
    }
    
    public ArrayList<Integer> getSlots(String street){
        ArrayList<Integer> arr = new ArrayList<> ();
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT DISTINCT parkingspaceno AS parkingNo FROM renting_parkingspace WHERE street = ?");
            pstmt.setString(1,street);
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()){
                arr.add(Integer.parseInt(rset.getString("parkingNo")));
            }
            pstmt.close();
            conn.close();
            return arr;
        } catch(Exception e){
            
            return arr;
        }
    }
    
    public ArrayList<String> getDistinctStreet(){
        ArrayList<String> dStreets = new ArrayList<> ();
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT DISTINCT street AS streetName FROM renting_parkingspace");
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()){
                dStreets.add(rset.getString("streetName"));
            }
            pstmt.close();
            conn.close();
            return dStreets;
        } catch (Exception e){
            System.out.println(e.getMessage());
            return dStreets;
        }
    }
    
    public int getRent(){
        int rentfee = 0;
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT rent_price AS rent FROM parkingspace WHERE street = ? AND parkingspaceno = ?");
            pstmt.setString(1, spaceSt);
            pstmt.setInt(2, parkingspaceno);
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()){
                rentfee = rset.getInt("rent");
            }
            pstmt.close();
            conn.close();
            return rentfee;
        } catch(Exception e){
            System.out.println(e.getMessage());
            
            return 0;
        }
    }
    public int getSpaceInfo(){
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT parkingspaceno AS parkingSp, street AS streetName, rent_price AS rent FROM parkingspace WHERE status = 'Available' ORDER BY parkingspaceno");
            ResultSet rst = pstmt.executeQuery();
            
            parkingNoList.clear();
            spaceStList.clear();
            priceList.clear();
            
            while (rst.next()) {
                parkingNoList.add(rst.getInt("parkingSp"));
                spaceStList.add(rst.getString("streetName"));
                priceList.add(rst.getInt("rent"));
            }
            
            pstmt.close();
            conn.close();
            System.out.println("Successful");
            return 1;
        } catch(Exception e) {
            return 0;
        }
    }
    
    public ArrayList<String> getDistinctAvailable(){
         ArrayList<String> dStreets = new ArrayList<> ();
        try {
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            
            PreparedStatement pstmt = conn.prepareStatement("SELECT DISTINCT street AS streetName FROM parkingspace WHERE status = 'Available'");
            ResultSet rst = pstmt.executeQuery();
             
            dStreets.clear();
            
            while (rst.next()) {
                dStreets.add(rst.getString("streetName"));
            }
            
            pstmt.close();
            conn.close();
            System.out.println("Successful");
            return dStreets;
        } catch(Exception e) {
            return dStreets;
        }
    }
    
    public int rentT_space(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(rentid) + 1 AS newrent FROM renting_parkingspace");
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()){
                rentid = rset.getInt("newrent");
            }
            
            
            
            pstmt = conn.prepareStatement("INSERT INTO renting_parkingspace (rentid, parkingspaceno, street, rentdate) VALUE (?, ?, ?, curdate())");
            
            pstmt.setInt(1, rentid);
            pstmt.setInt(2, parkingspaceno);
            pstmt.setString(3, spaceSt);
            
            pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement("INSERT INTO tenant_parkspace (rentid, tenantid) VALUE (?, ?)");
            pstmt.setInt(1, rentid);
            pstmt.setInt(2, tenantid);
            
            pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement("UPDATE parkingspace SET status = ? WHERE parkingspaceno = ? AND street = ?");
            pstmt.setString(1, "Occupied");
            pstmt.setInt(2, parkingspaceno);
            pstmt.setString(3, spaceSt);
            
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            System.out.println("Successful");
            return 1;
        } catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
    }
    public int searchTRent(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt, pst_t;
            
            
            
            if (tenantid != 0){
                if (parkingspaceno != 0){
                    if (!spaceSt.equals("0")){
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN tenant_parkspace tp ON rp.rentid=tp.rentid \n"
                                    + "AND tp.tenantid = ? AND rp.parkingspaceno = ? AND rp.street = ? \n"
                                    + "ORDER BY tp.tenantid, rp.parkingspaceno, rp.street");
                        pstmt.setInt(1, tenantid);
                        pstmt.setInt(2, parkingspaceno);
                        pstmt.setString(3, spaceSt);
                    } else {
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN tenant_parkspace tp ON rp.rentid=tp.rentid \n"
                                    + "AND tp.tenantid = ? AND rp.parkingspaceno = ? \n"
                                    + "ORDER BY tp.tenantid, rp.parkingspaceno");
                        pstmt.setInt(1, tenantid);
                        pstmt.setInt(2, parkingspaceno);
                    }
                } else {
                    if (!spaceSt.equals("0")){
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN tenant_parkspace tp ON rp.rentid=tp.rentid \n"
                                    + "AND tp.tenantid = ? AND rp.street = ? \n"
                                    + "ORDER BY tp.tenantid, rp.street");
                        pstmt.setInt(1, tenantid);
                        pstmt.setString(2, spaceSt);
                    } else {
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN tenant_parkspace tp ON rp.rentid=tp.rentid \n"
                                    + "AND tp.tenantid = ? ORDER BY tp.tenantid");
                        pstmt.setInt(1, tenantid);
                    }
                }
            } else {
                if (parkingspaceno != 0){
                    if (!spaceSt.equals("0")){
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN tenant_parkspace tp ON rp.rentid=tp.rentid \n"
                                    + "AND rp.parkingspaceno = ? AND rp.street = ? \n"
                                    + "ORDER BY rp.parkingspaceno, rp.street");
                        pstmt.setInt(1, parkingspaceno);
                        pstmt.setString(2, spaceSt);
                    } else {
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN tenant_parkspace tp ON rp.rentid=tp.rentid \n"
                                    + "AND rp.parkingspaceno = ? \n"
                                    + "ORDER BY rp.parkingspaceno");
                        pstmt.setInt(1, parkingspaceno);
                    }
                } else {
                    if (!spaceSt.equals("0")){
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN tenant_parkspace tp ON rp.rentid=tp.rentid \n"
                                    + "WHERE street = ?\n"
                                    + "ORDER BY street");
                        pstmt.setString(1, spaceSt);
                    } else {
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN tenant_parkspace tp ON tp.rentid=rp.rentid");
                       
                    }
                }
            }
            
            parkingNoList.clear();
            spaceStList.clear();
            tenantidList.clear();
            rentidList.clear();
            
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()){
                rentidList.add(rset.getInt("rentid"));
                tenantidList.add(rset.getInt("tenantid"));
                parkingNoList.add(rset.getInt("parkingspaceno"));
                spaceStList.add(rset.getString("street"));
                
            }
            
            pstmt.close();
            conn.close();
            return 1;
        } catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int searchhoRent(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt, pst_t;
            int rID;
            
            
            if (ho_id != 0){
                if (parkingspaceno != 0){
                    if (!spaceSt.equals("0")){
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN ho_parkspace hp ON rp.rentid=hp.rentid \n"
                                    + "AND hp.homeownerid = ? AND rp.parkingspaceno = ? AND rp.street = ? \n"
                                    + "ORDER BY hp.homeownerid, rp.parkingspaceno, rp.street");
                        pstmt.setInt(1, ho_id);
                        pstmt.setInt(2, parkingspaceno);
                        pstmt.setString(3, spaceSt);
                    } else {
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN ho_parkspace hp ON rp.rentid=hp.rentid \n"
                                    + "AND hp.homeownerid = ? AND rp.parkingspaceno = ? \n"
                                    + "ORDER BY hp.homeownerid, rp.parkingspaceno");
                        pstmt.setInt(1, ho_id);
                        pstmt.setInt(2, parkingspaceno);
                    }
                } else {
                    if (!spaceSt.equals("0")){
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN ho_parkspace hp ON rp.rentid=hp.rentid \n"
                                    + "AND hp.homeownerid = ? AND rp.street = ? \n"
                                    + "ORDER BY hp.homeownerid, rp.street");
                        pstmt.setInt(1, ho_id);
                        pstmt.setString(2, spaceSt);
                    } else {
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN ho_parkspace hp ON rp.rentid=hp.rentid \n"
                                    + "AND hp.homeownerid = ? ORDER BY hp.homeownerid");
                        pstmt.setInt(1, ho_id);
                    }
                }
            } else {
                if (parkingspaceno != 0){
                    if (!spaceSt.equals("0")){
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN ho_parkspace hp ON rp.rentid=hp.rentid \n"
                                    + "AND rp.parkingspaceno = ? AND rp.street = ? \n"
                                    + "ORDER BY rp.parkingspaceno, rp.street");
                        pstmt.setInt(1, parkingspaceno);
                        pstmt.setString(2, spaceSt);
                    } else {
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN ho_parkspace hp ON rp.rentid=hp.rentid \n"
                                    + "AND rp.parkingspaceno = ? \n"
                                    + "ORDER BY rp.parkingspaceno");
                        pstmt.setInt(1, parkingspaceno);
                    }
                } else {
                    if (!spaceSt.equals("0")){
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN ho_parkspace hp ON rp.rentid=hp.rentid \n"
                                    + "WHERE street = ?\n"
                                    + "ORDER BY street");
                        pstmt.setString(1, spaceSt);
                    } else {
                        pstmt = conn.prepareStatement("SELECT * FROM renting_parkingspace rp JOIN ho_parkspace hp ON rp.rentid=hp.rentid");
                       
                    }
                }
            }
            
            parkingNoList.clear();
            spaceStList.clear();
            ho_idList.clear();
            rentidList.clear();
            
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()){
                rentidList.add(rset.getInt("rentid"));
                ho_idList.add(rset.getInt("homeownerid"));
                parkingNoList.add(rset.getInt("parkingspaceno"));
                spaceStList.add(rset.getString("street"));
                
            }
            
            pstmt.close();
            conn.close();
            return 1;
        } catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    public int rentho_space(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            System.out.println("Connection Successful");
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(rentid) + 1 AS newrent FROM renting_parkingspace");
            ResultSet rset = pstmt.executeQuery();
            while (rset.next()){
                rentid = rset.getInt("newrent");
            }
            pstmt = conn.prepareStatement("INSERT INTO renting_parkingspace (rentid, parkingspaceno, street, rentdate) VALUE (?, ?, ?, curdate())");
            pstmt.setInt(1, rentid);
            pstmt.setInt(2, parkingspaceno);
            pstmt.setString(3, spaceSt);
            
            pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement("INSERT INTO ho_parkspace (rentid, homeownerid) VALUE (?, ?)");
            pstmt.setInt(1, rentid);
            pstmt.setInt(2, ho_id);
           
            pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement("UPDATE parkingspace SET status = ? WHERE parkingspaceno = ? AND street = ?");
            pstmt.setString(1, "Occupied");
            pstmt.setInt(2, parkingspaceno);
            pstmt.setString(3, spaceSt);
            
            pstmt.executeUpdate();
            
            pstmt.close();
            conn.close();
            System.out.println("Successful");
            return 1;
        } catch (Exception e){
            System.out.println(e.getMessage());
            return 0;
        }
    }
    
    
    public static void main(String args[]){
           
    }
}
