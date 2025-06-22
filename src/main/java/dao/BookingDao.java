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
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import models.Bookings;
import models.Customers;
import models.Rooms;

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

        String sql = "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, "
                + "r.RoomNumber, c.FullName "
                + "FROM Bookings b "
                + "JOIN Rooms r ON b.RoomId = r.RoomId "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.Status IN ('Waiting for processing', 'Confirmed')";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));

            // Đọc StartDate dạng Timestamp và convert sang LocalDateTime
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

            Timestamp startTs = rs.getTimestamp("StartDate");
            if (startTs != null) {
                LocalDateTime startDate = startTs.toLocalDateTime();
                booking.setStartDate(startDate); // nếu vẫn cần giữ LocalDateTime
                booking.setFormattedStartDate(startDate.format(formatter)); // chuỗi đã format
            }

            Timestamp endTs = rs.getTimestamp("EndDate");
            if (endTs != null) {
                LocalDateTime endDate = endTs.toLocalDateTime();
                booking.setEndDate(endDate);
                booking.setFormattedEndDate(endDate.format(formatter));
            }

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

    public void confirmBooking(int bookingId, int confirmedBy) throws SQLException {
        String sql = "UPDATE Bookings SET Status = 'Confirmed', ConfirmationTime = ?, ConfirmedBy = ? WHERE BookingId = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(2, confirmedBy);
            ps.setInt(3, bookingId);
            ps.executeUpdate();
        }
    }

    public void cancelBooking(int bookingId, String notes, int canceledBy) throws SQLException {
        String sql = "UPDATE Bookings SET Status = ?, CancelTime = ?, CanceledBy = ?, Notes = ? WHERE BookingId = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "Canceled");
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(3, canceledBy);
            ps.setString(4, notes);
            ps.setInt(5, bookingId);
            ps.executeUpdate();
        }
    }

    public List<Bookings> searchBookings(String roomNumber, String fullName, String startDateStr, String endDateStr, String status) throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

        StringBuilder sql = new StringBuilder(
                "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, "
                + "r.RoomNumber, c.FullName "
                + "FROM Bookings b "
                + "JOIN Rooms r ON b.RoomId = r.RoomId "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.Status IN ('Waiting for processing', 'Confirmed')"
        );

        List<Object> params = new ArrayList<>();

        if (roomNumber != null && !roomNumber.trim().isEmpty()) {
            sql.append("AND r.RoomNumber LIKE ? ");
            params.add("%" + roomNumber.trim() + "%");
        }

        if (fullName != null && !fullName.trim().isEmpty()) {
            sql.append("AND c.FullName LIKE ? ");
            params.add("%" + fullName.trim() + "%");
        }

        if (startDateStr != null && !startDateStr.trim().isEmpty()) {
            sql.append("AND CONVERT(varchar, b.StartDate, 23) LIKE ? ");
            params.add(startDateStr.trim() + "%");
        }

        if (endDateStr != null && !endDateStr.trim().isEmpty()) {
            sql.append("AND CONVERT(varchar, b.EndDate, 23) LIKE ? ");
            params.add(endDateStr.trim() + "%");
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND b.Status = ? ");
            params.add(status.trim());
        }

        PreparedStatement ps = conn.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));
            booking.setStatus(rs.getString("Status"));

            Timestamp startTs = rs.getTimestamp("StartDate");
            if (startTs != null) {
                LocalDateTime startDate = startTs.toLocalDateTime();
                booking.setStartDate(startDate);
                booking.setFormattedStartDate(startDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")));
            }

            Timestamp endTs = rs.getTimestamp("EndDate");
            if (endTs != null) {
                LocalDateTime endDate = endTs.toLocalDateTime();
                booking.setEndDate(endDate);
                booking.setFormattedEndDate(endDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")));
            }

            Rooms room = new Rooms();
            room.setRoomNumber(rs.getString("RoomNumber"));
            booking.setRooms(room);

            Customers customer = new Customers();
            customer.setFullName(rs.getString("FullName"));
            booking.setCustomers(customer);

            list.add(booking);
        }

        rs.close();
        ps.close();
        conn.close();
        return list;
    }

}
