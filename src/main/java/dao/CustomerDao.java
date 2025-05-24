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

        return -1;

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
                    CustomerStatus cs = new CustomerStatus();
                    cs.setStatusName(rs.getString("StatusName"));
                    customer.setCustomerStatus(cs);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return customer;
    }
}
