/*
package db;
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

    public static Connection getConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

<<<<<<< HEAD
            String url = "jdbc:sqlserver://MEONGUYENTU:1433;databaseName=building_management301;user=sa;password=1234567890;encrypt=true;trustServerCertificate=true;";
=======
         String url = "jdbc:sqlserver://LAPTOP-SJ6AII7D\\SQLEXPRESS:1433;databaseName=building_management30;user=sa;password=123456;encrypt=true;trustServerCertificate=true;";
>>>>>>> 5df086ec3e126c5c1a51ea75abb3800cbd341bc1



            conn = DriverManager.getConnection(url);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConnectData.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ConnectData.class.getName()).log(Level.SEVERE, null, ex);
        }
        return conn;

    }

    public static void closeConnection() {
        try {
            if (!conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectData.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
