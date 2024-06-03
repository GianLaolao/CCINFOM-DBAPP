/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tables_package;


import java.util.ArrayList;
import java.sql.*;
/**
 *
 * @author ccslearner
 */
public class house {
    public int houseid;
    public int houseno;
    public String street;
    public int homeownerid;

    public ArrayList<Integer> houseid_list = new ArrayList<>();
    public ArrayList<Integer> houseno_list = new ArrayList<>();
    public ArrayList<String> street_list = new ArrayList<>();
    public ArrayList<Integer> homeownerid_list = new ArrayList<>();
    
    public void getHouseList(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            PreparedStatement ps = conn.prepareStatement("SELECT house.houseid FROM house ORDER BY house.houseid");
            ResultSet rs = ps.executeQuery();
            
            houseid_list.clear();
            
            while(rs.next()){
                houseid = rs.getInt("houseid");
                houseid_list.add(houseid);
            }
            
            conn.close();
            ps.close();
            
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
    }
    
    public int getNewHouseNo(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            PreparedStatement ps = conn.prepareStatement("SELECT MAX(houseid) + 1 AS newHouseID FROM house");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                houseid = rs.getInt("newHouseID");
            }
            
            conn.close();
            ps.close();
            
            return houseid;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        
        return 2001; // first houseid if there are no houses yet
    }

    public int register(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            PreparedStatement ps = conn.prepareStatement("SELECT MAX(houseid) + 1 AS newHouseID FROM house");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                houseid = rs.getInt("newHouseID");
            }
            ps = conn.prepareStatement("INSERT INTO house VALUES (?, ?, ?, ?)");
            ps.setInt(1, houseid);
            ps.setInt(2, houseno);
            ps.setString(3,street);
            ps.setInt(4, homeownerid);
            
            ps.executeUpdate();
            
            conn.close();
            ps.close();
            
            return 1;

        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        
        return 0;
    }
    
    public int getHouseRecord(int i_houseid){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            PreparedStatement ps = conn.prepareStatement("SELECT h.houseid, s.street, h.houseno, h.homeownerid"
                    + " FROM ref_street s JOIN house h ON s.street = h.street JOIN homeowner ho ON ho.homeownerid = h.homeownerid" +
                    " WHERE h.houseid =" + i_houseid + ";");
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                houseid = rs.getInt("houseid");
                street = rs.getString("street");
                houseno = rs.getInt("houseno");
                homeownerid = rs.getInt("homeownerid");
            }
            
            ps.close();
            conn.close();
            
            if(houseid != 0){
                return 1;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        
        return 0;
    }
    
    public int updateHouse(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            PreparedStatement ps = conn.prepareStatement("UPDATE house SET street=?, homeownerid=?, houseno=? WHERE houseid=?");
            
            ps.setString(1,street);
            ps.setInt(2,homeownerid);
            ps.setInt(3,houseno);
            ps.setInt(4,houseid);
            ps.executeUpdate();
            
            ps.close();
            conn.close();
            
            return 1;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return 0;
    }
    
    public int deleteHouse(int i_house){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            PreparedStatement ps = conn.prepareStatement("DELETE FROM house WHERE houseid = ?");
            
            ps.setInt(1,i_house);
            ps.executeUpdate();
            
            conn.close();
            ps.close();
            
            return 1;
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return 0;
    }
    
    public int filterHouse(){
        try{
            StringBuilder sb = new StringBuilder();
            String stmt;
            
            if(street.equals("") && houseno == 0 && homeownerid == 0){
                sb.append("SELECT house.* FROM house");
            }else if(!street.equals("") || houseno != 0 || homeownerid != 0){
                sb.append("SELECT house.* FROM house WHERE ");
                
                if(!street.equals("")){
                    stmt = "street=" + "\""+ street + "\"";
                    sb.append(stmt);
                    
                    if(houseno != 0){
                        stmt = " AND houseno=" + houseno;
                        sb.append(stmt);
                    }
                    if(homeownerid != 0){
                        stmt = " AND homeownerid=" + homeownerid;
                        sb.append(stmt);
                    }
                }
                
                else if(houseno != 0){
                    stmt = "houseno=" + houseno;
                    sb.append(stmt);
                    
                    if(!street.equals("")){
                        stmt = " AND street=" + "\""+ street + "\"";
                        sb.append(stmt);
                    }
                    if(homeownerid != 0){
                        stmt = " AND homeownerid=" + homeownerid;
                        sb.append(stmt);
                    }
                }
                
                else if(homeownerid != 0){
                    stmt = "homeownerid=" + homeownerid;
                    sb.append(stmt);
                    
                    if(!street.equals("")){
                        stmt = " AND street=" + "\""+ street + "\"";
                        sb.append(stmt);
                    }
                    if(houseno != 0){
                        stmt = " AND houseno=" + houseno;
                        sb.append(stmt);
                    }
                }
            }
            
            System.out.println(sb.toString());
            
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            PreparedStatement ps = conn.prepareStatement(sb.toString());
            ResultSet rs = ps.executeQuery();
            
            houseid_list.clear();
            street_list.clear();
            houseno_list.clear();
            homeownerid_list.clear();
            
            while(rs.next()){
                houseid_list.add(rs.getInt("houseid"));
                street_list.add(rs.getString("street"));
                houseno_list.add(rs.getInt("houseno"));
                homeownerid_list.add(rs.getInt("homeownerid"));
            }
            
            conn.close();
            ps.close();
            
            if(!street_list.isEmpty() && !houseno_list.isEmpty() && !homeownerid_list.isEmpty()){
                return 1;
            }else{
                return 0;
            }
        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        return 0;
    }
    
    public static void main(String args[]){
       
        
        
    }
}
