/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import static dao.UserDao.md5;
import db.ConnectData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.CustomerStatus;
import models.Customers;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class CustomerDao {

    private Connection conn = null;

    public CustomerDao() {

        conn = ConnectData.getConnection();
    }

    public int loginCussForId(Customers acc) {
        try {
            String sql = "Select * from Customers where UserName=? and Password=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, acc.getUserName());
            pst.setString(2, md5(acc.getPassword()));
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt("CustomerId");
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, "Lỗi truy vấn đăng nhập", ex);
        }

        return 0;

    }

    public Customers getCustomerById(int id) {
        Customers customer = null;
        String sql = "SELECT UserName, FullName, Email, Phone, StatusName, AvatarUrl, Address, Gender, DateOfBirth \n"
                + "FROM Customers c \n"
                + "INNER JOIN CustomerStatus cs ON c.StatusId = cs.StatusId \n"
                + "WHERE CustomerID = ?";

        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, id);
            try ( ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    customer = new Customers();
                    customer.setUserName(rs.getString("UserName"));
                    customer.setFullName(rs.getString("FullName"));
                    customer.setEmail(rs.getString("Email"));
                    customer.setPhone(rs.getString("Phone"));
                    customer.setAvatarUrl(rs.getString("AvatarUrl"));
                    customer.setAddress(rs.getString("Address")); // có thể là null
                    customer.setGender(rs.getString("Gender")); // có thể là null
                    customer.setDateOfBirth(rs.getDate("DateOfBirth")); // có thể là null (java.sql.Date)

                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return customer;
    }

    public int updateCustomerProfileById(int id, Customers customer) {
        int cmt = 0;
        try {
            String sql = "Update Customers set Address = ?, FullName = ?, Gender = ? where CustomerId = ? ";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, customer.getAddress());
            pst.setString(2, customer.getFullName());
            pst.setString(3, customer.getGender());
            pst.setInt(4, id);
            cmt = pst.executeUpdate();
            return cmt;
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cmt;
    }
    
    public void updateLoginTimestamps(int customerId) {
        String sql = "UPDATE Customers SET LastLogin = CurrentLastLogin, CurrentLastLogin = ? WHERE CustomerId = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            System.out.println(Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(2, customerId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
