/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Bookings;
import models.Customers;
import models.Invoices;
import models.Payments;

/**
 *
 * @author $Do Dang Khoa - CE181988
 */
public class InvoicesDao {

    private Connection conn;

    public InvoicesDao() {
        conn = db.ConnectData.getConnection();
    }

    public List<Invoices> getAllInvoicesCustomer(int CustomerId) {
        List<Invoices> list = new ArrayList<>();
        ResultSet rs = null;
        String sql = "select i.InvoiceId, i.BookingId, i.InvoiceDate, i.RoomTotal ,i.ServiceTotal ,i.Discount ,i.TotalAmount ,i.Status, c.CustomerId, p.Amount from Invoices i\n"
                + "inner join Bookings b on b.BookingId = i.BookingId\n"
                + "inner join Customers c on c.CustomerId = b.CustomerID\n"
                + "inner join Payments p on p.RoomId = b.RoomId\n"
                + "where c.CustomerId = ?";
        try {

            Statement st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                Payments p = new Payments();
                p.setAmount(rs.getLong("Amount"));
                
                Customers c = new Customers();
                c.setCustomerId(rs.getInt("CustomerId"));
                
                Invoices i = new Invoices();
                i.setBookingId(rs.getInt("BookingId"));
                i.setDatetime(rs.getTimestamp("InvoiceDate").toLocalDateTime());
                i.setRoomTotal(rs.getLong("RoomTotal"));
                i.setServiceTotal(rs.getLong("ServiceTotal"));
                i.setDiscount(rs.getLong("Discount"));
                i.setTotalAmount(rs.getLong("TotalAmount"));
                i.setStatus(rs.getBoolean("Status"));
                i.setPayments(p);
                i.setCustomer(c);
                list.add(i);
            }
        } catch (SQLException ex) {
            Logger.getLogger(InvoicesDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
