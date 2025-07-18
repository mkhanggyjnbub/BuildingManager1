/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class MessageDao {

    private Connection conn = null;

    public MessageDao() {
        conn = ConnectData.getConnection();

    }

    public int saveMessage(int customerId, int staffId, String senderType, String messageContent) {
        LocalDateTime now = LocalDateTime.now(); 

        try {
            String sql = "INSERT INTO Messages \n"
                    + "(CustomerId, StaffId, SenderType, MessageContent, SentAt) \n"
                    + "VALUES (?,?,?,?,?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, customerId);
            pst.setInt(2, staffId);
            pst.setString(3, senderType);
            pst.setString(4, messageContent);
            pst.setTimestamp(5, Timestamp.valueOf(now));
            return pst.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return 0;
    }

}
