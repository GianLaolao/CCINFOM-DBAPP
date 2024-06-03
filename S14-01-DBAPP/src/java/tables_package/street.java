/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tables_package;
import java.util.*;
import java.sql.*;

/**
 *
 * @author ccslearner
 */
public class street {
    public String street;
    public ArrayList<String> street_list = new ArrayList<>();
    
    public int getStreetList(){
        try{
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/duesDB?user=root&password=12345678");
            PreparedStatement ps = conn.prepareStatement("SELECT s.street FROM ref_street s");
            ResultSet rs = ps.executeQuery();
            
            street_list.clear();
            
            while(rs.next()){
                street_list.add(rs.getString("street"));
            }
            
            conn.close();
            ps.close();
            
            return 1;

        }catch(Exception e){
            System.out.println(e.getMessage());
        }
        
        return 0;
    }
    
    public static void main(String args[]){
        
     
    }
}
