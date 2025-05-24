/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import com.nimbusds.openid.connect.sdk.assurance.evidences.Voucher;
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
                Vouchers voucher = new Vouchers();
                voucher.setStatus(rs.getBoolean("Status"));
                voucher.setVoucherId(rs.getInt("VoucherId"));
                voucher.setCode(rs.getString("Code"));
                voucher.setTypeId(rs.getInt("TypeId"));
                voucher.setDiscountPercent(rs.getInt("DiscountPercent"));
                voucher.setDiscountAmount(rs.getInt("DiscountAmount"));
                voucher.setMinOrderAmount(rs.getInt("MinOrderAmount"));
                voucher.setStartDate(rs.getDate("StartDate"));
                voucher.setEndDate(rs.getDate("EndDate"));
                voucher.setDescription(rs.getString("Description"));
                voucher.setQuantity(rs.getInt("Quantity"));
                list.add(voucher);
            }
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int insertVoucher(Vouchers voucher) {
        int dem = 0;
        String sql = "INSERT INTO Vouchers (Code, TypeId, DiscountPercent, DiscountAmount, MinOrderAmount, StartDate, EndDate, Description, Quantity) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucher.getCode());
            ps.setInt(2, voucher.getTypeId());
            ps.setObject(3, voucher.getDiscountPercent());
            ps.setObject(4, voucher.getDiscountAmount());
            ps.setInt(5, voucher.getMinOrderAmount());
            ps.setDate(6, voucher.getStartDate());
            ps.setDate(7, voucher.getEndDate());
            ps.setString(8, voucher.getDescription());
            ps.setInt(9, voucher.getQuantity());
            dem = ps.executeUpdate();
            return dem;
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return dem;

    }

    public int deleteVoucher(int voucherId) {
        int dem = 0;
        String sql = "DELETE FROM Vouchers WHERE VoucherId = ?";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            dem = ps.executeUpdate();
            return dem;
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return dem;
    }

    public Vouchers getVoucherById(int id) {
        Vouchers v = new Vouchers();
        try {
            String sql = "SELECT * FROM Vouchers WHERE VoucherId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                v.setVoucherId(rs.getInt("voucherId"));
                v.setCode(rs.getString("Code"));
                v.setTypeId(rs.getInt("TypeId"));
                v.setDiscountPercent(rs.getInt("DiscountPercent"));
                v.setDiscountAmount(rs.getInt("DiscountAmount"));
                v.setMinOrderAmount(rs.getInt("MinOrderAmount"));
                v.setStartDate(rs.getDate("StartDate"));
                v.setEndDate(rs.getDate("EndDate"));
                v.setDescription(rs.getString("Description"));
                v.setStatus(rs.getBoolean("Status"));
                v.setQuantity(rs.getInt("Quantity"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return v;
    }

    public int updateVoucher(Vouchers v) {
        int dem = 0;
        try {
            String sql = "UPDATE Vouchers SET Code=?, TypeId=?, DiscountPercent=?, DiscountAmount=?, MinOrderAmount=?, StartDate=?, EndDate=?, Quantity=?, Description=? WHERE VoucherId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, v.getCode());
            ps.setInt(2, v.getTypeId());
            ps.setInt(3, v.getDiscountPercent());
            ps.setInt(4, v.getDiscountAmount());
            ps.setInt(5, v.getMinOrderAmount());
            ps.setDate(6, v.getStartDate());
            ps.setDate(7, v.getEndDate());
            ps.setInt(8,v.getQuantity());
            ps.setString(9, v.getDescription());
            ps.setInt(10, v.getVoucherId());
            
            dem = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dem;
    }

    public List<Vouchers> checkVoucherById(int customerId) {
        List<Vouchers> list = new ArrayList<>();
        ResultSet rs = null;

        try {
            String sql = "SELECT voucherId FROM CustomerVoucher WHERE CustomerId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Vouchers voucher = new Vouchers(); // tạo object mới mỗi vòng lặp
                voucher.setVoucherId(rs.getInt("voucherId"));
                list.add(voucher); // thêm từng object vào list
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

}
