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
import java.sql.Timestamp;
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
                voucher.setVoucherId(rs.getInt("VoucherId"));
                voucher.setCode(rs.getString("Code"));
                voucher.setDiscountPercent(rs.getInt("DiscountPercent"));
                voucher.setMinOrderAmount(rs.getBigDecimal("MinOrderAmount"));
                voucher.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                voucher.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                voucher.setDescription(rs.getString("Description"));
                voucher.setQuantity(rs.getInt("Quantity"));
                voucher.setIsActive(rs.getBoolean("isActive"));
                voucher.setUserId(rs.getString("userId"));
                list.add(voucher);
            }
        } catch (SQLException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int insertVoucher(Vouchers voucher) {
        int dem = 0;
        String sql = "INSERT INTO Vouchers (Code, DiscountPercent, MinOrderAmount, StartDate, EndDate, Description, Quantity, IsActive) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, voucher.getCode());
            ps.setObject(2, voucher.getDiscountPercent());
            ps.setBigDecimal(3, voucher.getMinOrderAmount());
            ps.setTimestamp(4, Timestamp.valueOf(voucher.getStartDate()));
            ps.setTimestamp(5, Timestamp.valueOf(voucher.getEndDate()));
            ps.setString(6, voucher.getDescription());
            ps.setInt(7, voucher.getQuantity());
            ps.setBoolean(8, voucher.getIsActive());
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
                v.setDiscountPercent(rs.getInt("DiscountPercent"));
                v.setMinOrderAmount(rs.getBigDecimal("MinOrderAmount"));
                v.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                v.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                v.setDescription(rs.getString("Description"));
                v.setQuantity(rs.getInt("Quantity"));
                v.setIsActive(rs.getBoolean("IsActive"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return v;
    }

    public int updateVoucher(Vouchers v) {
        int dem = 0;
        try {
            String sql = "UPDATE Vouchers SET Code=?, DiscountPercent=?, MinOrderAmount=?, StartDate=?, EndDate=?, Quantity=?, Description=?, IsActive=? WHERE VoucherId=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, v.getCode());
            ps.setInt(2, v.getDiscountPercent());
            ps.setBigDecimal(3, v.getMinOrderAmount());
            ps.setTimestamp(4, Timestamp.valueOf(v.getStartDate()));
            ps.setTimestamp(5, Timestamp.valueOf(v.getEndDate()));
            ps.setInt(6, v.getQuantity());
            ps.setString(7, v.getDescription());
            ps.setBoolean(8, v.getIsActive());
            ps.setInt(9, v.getVoucherId());

            dem = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dem;
    }

    public List checkVoucherById(int customerId) {
        List list = new ArrayList<>();
        ResultSet rs = null;

        try {
            String sql = "SELECT VoucherId FROM CustomerVouchers WHERE CustomerId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Vouchers voucher = new Vouchers();
                voucher.setVoucherId(rs.getInt("VoucherId"));
                list.add(voucher);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean hasSavedVoucher(int customerId, int voucherId) {
        String sql = "SELECT 1 FROM CustomerVouchers WHERE CustomerId = ? AND VoucherId = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ps.setInt(2, voucherId);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean decreaseVoucherQuantity(int voucherId, Connection conn) throws SQLException {
        String sql = "UPDATE Vouchers SET Quantity = Quantity - 1 WHERE VoucherId = ? AND Quantity > 0";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, voucherId);
            return ps.executeUpdate() > 0;
        }
    }

    public List getAllAvailableVouchers() {
        List list = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers "
                + "WHERE EndDate >= GETDATE() AND Quantity > 0 AND IsActive = 1";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Vouchers v = new Vouchers();
                v.setVoucherId(rs.getInt("VoucherId"));
                v.setCode(rs.getString("Code"));
                v.setDescription(rs.getString("Description"));
                v.setDiscountPercent(rs.getInt("DiscountPercent"));
                v.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                v.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                v.setMinOrderAmount(rs.getBigDecimal("MinOrderAmount"));
                v.setQuantity(rs.getInt("Quantity"));
                list.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List getVouchersByCustomer(int customerId) {
        List list = new ArrayList<>();
        String sql = "SELECT v.* FROM Vouchers v "
                + "JOIN CustomerVouchers cv ON v.VoucherId = cv.VoucherId "
                + "WHERE cv.CustomerId = ?";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Vouchers v = new Vouchers();
                v.setVoucherId(rs.getInt("VoucherId"));
                v.setCode(rs.getString("Code"));
                v.setDescription(rs.getString("Description"));
                v.setDiscountPercent(rs.getInt("DiscountPercent"));
                v.setStartDate(rs.getTimestamp("StartDate").toLocalDateTime());
                v.setEndDate(rs.getTimestamp("EndDate").toLocalDateTime());
                v.setMinOrderAmount(rs.getBigDecimal("MinOrderAmount"));
                v.setQuantity(rs.getInt("Quantity"));
                list.add(v);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean saveCustomerVoucher(int customerId, int voucherId, Connection conn) throws SQLException {

        String sql = "INSERT INTO CustomerVouchers (CustomerId, VoucherId, IsUsed, AssignedDate) VALUES (?, ?, 0, GETDATE())";
        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, voucherId);
            return ps.executeUpdate() > 0;
        }
    }

}
