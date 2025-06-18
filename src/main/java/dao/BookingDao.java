/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Bookings;
import models.Customers;
import models.Rooms;
import models.Vouchers;

/**
 *
 * @author Admin
 */
public class BookingDao {

    private Connection conn = null;

    public BookingDao() {

        conn = ConnectData.getConnection();
    }

    public List<Bookings> getAllBookings() throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

         String sql = "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, b.UserId, " +
                 "r.RoomNumber, c.FullName " +
                 "FROM Bookings b " +
                 "JOIN Rooms r ON b.RoomId = r.RoomId " +
                 "JOIN Customers c ON b.CustomerId = c.CustomerId " +
                 "WHERE b.Status IN ('Waiting for processing', 'Confirmed')";
        

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));
            booking.setStartDate(rs.getDate("StartDate"));
            booking.setEndDate(rs.getDate("EndDate"));
            booking.setStatus(rs.getString("Status"));
            
            Rooms room = new Rooms();
            room.setRoomNumber(rs.getString("RoomNumber"));
            booking.setRooms(room);
            
            Customers name = new Customers();
            name.setFullName(rs.getString("FullName"));
            booking.setCustomers(name);

            list.add(booking);
        }
        rs.close();
        ps.close();
        conn.close();
        return list;
    }

    public void updateBookingStatus(int bookingId, String status) throws SQLException {
        Connection conn = ConnectData.getConnection();
        String sql = "UPDATE Bookings SET Status = ? WHERE BookingId = ?";
        PreparedStatement ps = conn.prepareStatement(sql);  
        ps.setString(1, status);
        ps.setInt(2, bookingId);
        ps.executeUpdate();

        ps.close();
        conn.close();
    }

    public void deleteBooking(int bookingId) throws SQLException {
        String sql = "DELETE FROM Bookings WHERE BookingId = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            stmt.executeUpdate();
        }
    }

}
