/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class ConnectData {
     public static Connection conn = null;
    public static Connection getConnection(){
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
<<<<<<< HEAD
            String url = "jdbc:sqlserver://LAPTOP-C36OHGQN:1433;databaseName=building_management2;user=sa;password=vinhddtce180441;encryt=true;trustServerCertificate=true;    ";
=======
            String url = "jdbc:sqlserver://localhost:1433;databaseName=building_management23;user=sa;password=123456;encryt=true;trustServerCertificate=true;    ";
>>>>>>> origin
            conn = DriverManager.getConnection(url);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConnectData.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ConnectData.class.getName()).log(Level.SEVERE, null, ex);
        }
          return conn;

    }
    
    public static void closeConnection(){
        try {
            if(!conn.isClosed()){
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectData.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
