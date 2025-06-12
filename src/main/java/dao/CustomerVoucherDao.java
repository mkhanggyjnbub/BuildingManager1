/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
public class CustomerVoucherDao {

    private Connection conn = null;

    public CustomerVoucherDao() {
        conn = db.ConnectData.getConnection();
    }

    public int saveVoucher(int customerId, int voucherId) {
        int result = 0;
        try {
            // Kiểm tra xem đã lưu chưa
            String checkSql = "SELECT * FROM CustomerVoucher WHERE customerId = ? AND voucherId = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setInt(1, customerId);
            checkStmt.setInt(2, voucherId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Đã lưu rồi
                return 0;
            }

            // Kiểm tra xem còn quantity không
            String quantitySql = "SELECT quantity FROM Vouchers WHERE voucherId = ?";
            PreparedStatement qtyStmt = conn.prepareStatement(quantitySql);
            qtyStmt.setInt(1, voucherId);
            ResultSet qtyRs = qtyStmt.executeQuery();

            if (qtyRs.next() && qtyRs.getInt("quantity") > 0) {
                // Bắt đầu transaction
                conn.setAutoCommit(false);

                // Bước 1: Lưu vào bảng trung gian
                String insertSql = "INSERT INTO CustomerVoucher (customerId, voucherId) VALUES (?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setInt(1, customerId);
                insertStmt.setInt(2, voucherId);
                insertStmt.executeUpdate();

                // Bước 2: Trừ quantity
                String updateSql = "UPDATE Vouchers SET quantity = quantity - 1 WHERE voucherId = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setInt(1, voucherId);
                result = updateStmt.executeUpdate();

                conn.commit(); // commit transaction
            }

        } catch (SQLException e) {
            try {
                conn.rollback(); // rollback nếu lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return result;
    }
}
