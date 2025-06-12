/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import models.Vouchers;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author CE180441_Dương Đinh Thế Vinh
 */
public class VoucherDAO {

    private Connection conn = null;

    public VoucherDAO() {

        conn = ConnectData.getConnection();
    }

    public List<Vouchers> selectAllVouchers() {
        ResultSet rs = null;
        List<Vouchers> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Vouchers";
            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);

            while (rs.next()) {
                Vouchers voucher = new Vouchers(); // ✅ tạo mới mỗi vòng lặp
                voucher.setVoucherId(rs.getInt("VoucherId"));
                voucher.setCode(rs.getString("Code"));
                voucher.setTypeId(rs.getInt("TypeId"));
                voucher.setDiscountPercent(rs.getInt("DiscountPercent"));
                voucher.setDiscountAmount(rs.getInt("DiscountAmount"));
                voucher.setMinOrderAmount(rs.getInt("MinOrderAmount"));
                voucher.setStartDate(rs.getDate("StartDate"));
                voucher.setEndDate(rs.getDate("EndDate"));
                voucher.setDescription(rs.getString("Description"));
                list.add(voucher);
            }
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void insertVoucher(Vouchers voucher) {
        String sql = "INSERT INTO Vouchers (Code, TypeId, DiscountPercent, DiscountAmount, MinOrderAmount, StartDate, EndDate, Description) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucher.getCode());
            ps.setInt(2, voucher.getTypeId());
            ps.setObject(3, voucher.getDiscountPercent());
            ps.setObject(4, voucher.getDiscountAmount());
            ps.setInt(5, voucher.getMinOrderAmount());
            ps.setDate(6, voucher.getStartDate());
            ps.setDate(7, voucher.getEndDate());
            ps.setString(8, voucher.getDescription());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteVoucher(int voucherId) {
        String sql = "DELETE FROM Vouchers WHERE VoucherId = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Vouchers getVoucherById(int id) {
        Vouchers v = null;
        try {
            String sql = "SELECT * FROM Vouchers WHERE VoucherId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                v = new Vouchers(
                        rs.getInt("VoucherId"),
                        rs.getString("Code"),
                        rs.getInt("TypeId"),
                        rs.getInt("DiscountPercent"),
                        rs.getInt("DiscountAmount"),
                        rs.getInt("MinOrderAmount"),
                        rs.getDate("StartDate"),
                        rs.getDate("EndDate"),
                        rs.getString("Description")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return v;
    }

    public int updateVoucher(Vouchers v) {
        int dem = 0;
        try {
            String sql = "UPDATE Vouchers SET Code=?, TypeId=?, DiscountPercent=?, DiscountAmount=?, MinOrderAmount=?, StartDate=?, EndDate=?, Description=? WHERE VoucherId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, v.getCode());
            ps.setInt(2, v.getTypeId());
            ps.setInt(3, v.getDiscountPercent());
            ps.setInt(4, v.getDiscountAmount());
            ps.setInt(5, v.getMinOrderAmount());
            ps.setDate(6, v.getStartDate());
            ps.setDate(7, v.getEndDate());
            ps.setString(8, v.getDescription());
            ps.setInt(9, v.getVoucherId());
            dem = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dem;
    }

}
