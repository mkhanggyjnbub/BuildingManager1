/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import models.Invoices;

/**
 *
 * @author $Do Dang Khoa - CE181988
 */
public class InvoiceDao {

    private Connection conn = null;

    public InvoiceDao() {
        conn = ConnectData.getConnection();
    }

    public Invoices getByBookingId(int bookingId) {
        String sql = "SELECT * FROM Invoices WHERE BookingId = ?";
        Invoices invoice = null;

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                invoice = new Invoices();
                invoice.setInvoiceId(rs.getInt("InvoiceId"));
                invoice.setBookingId(rs.getInt("BookingId"));
                invoice.setInvoiceDate(rs.getTimestamp("InvoiceDate").toLocalDateTime());
                invoice.setRoomPriceTotal(rs.getLong("RoomPriceTotal"));
                invoice.setServiceTotal(rs.getLong("ServiceTotal"));
                invoice.setDiscount(rs.getLong("Discount"));
                invoice.setTotalAmount(rs.getLong("TotalAmount"));
                invoice.setStatus(rs.getBoolean("Status"));
                invoice.setPaidAmount(rs.getLong("PaidAmount"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return invoice;
    }
}
