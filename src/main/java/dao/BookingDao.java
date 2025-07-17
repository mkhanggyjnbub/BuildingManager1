package dao;

import db.ConnectData;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.LocalDate;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import models.Bookings;
import models.Customers;
import models.Rooms;

public class BookingDao {

    private Connection conn = null;

    public BookingDao() {
        conn = ConnectData.getConnection();
    }

    //vinh bookingconfirmation
    public List<Bookings> getAllBookings() throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

        String sql = "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, "
                + "COALESCE(r.RoomType, b.RoomType) AS RoomType, " // Ưu tiên lấy từ bảng Rooms nếu có, ngược lại lấy từ Booking
                + "c.FullName "
                + "FROM Bookings b "
                + "LEFT JOIN Rooms r ON b.RoomId = r.RoomId "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.Status IN ('Waiting for processing', 'Confirmed')";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));

            java.sql.Date startDateSql = rs.getDate("StartDate");
            if (startDateSql != null) {
                LocalDate startDate = startDateSql.toLocalDate();
                booking.setStartDate(startDate);
                booking.setFormattedStartDate(startDate.format(formatter));
            }

            java.sql.Date endDateSql = rs.getDate("EndDate");
            if (endDateSql != null) {
                LocalDate endDate = endDateSql.toLocalDate();
                booking.setEndDate(endDate);
                booking.setFormattedEndDate(endDate.format(formatter));
            }

            booking.setStatus(rs.getString("Status"));

            // Gán RoomType (kể cả khi null)
            String roomType = rs.getString("RoomType");
            if (roomType == null) {
                roomType = "Chưa gán phòng";
            }
            booking.setRoomType(roomType); // nếu bạn có thêm field roomType trong Booking

            // Gán tên khách
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

    //vinh
    public void confirmBooking(int bookingId, int confirmedBy) throws SQLException {
        String sql = "UPDATE Bookings SET Status = 'Confirmed', ConfirmationTime = ?, ConfirmedBy = ? WHERE BookingId = ?";

        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now())); // thời gian xác nhận
            ps.setInt(2, confirmedBy); // ID của nhân viên xác nhận
            ps.setInt(3, bookingId);   // ID đơn đặt phòng

            ps.executeUpdate();
        }
    }

//vinh
    public void confirmBookingWithRoom(int bookingId, int roomId, int confirmedBy) throws SQLException {
        String sql = "UPDATE Bookings SET RoomId = ?, Status = 'Confirmed', ConfirmationTime = ?, ConfirmedBy = ? WHERE BookingId = ?";
        try (
                 Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setTimestamp(2, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(3, confirmedBy);
            ps.setInt(4, bookingId);
            ps.executeUpdate();
        }
    }

//vinh
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

    public int updateBookingStatus(int bookingId, String status) {
        int cnt = 0;
        try {
            Connection conn = ConnectData.getConnection();
            String sql = "UPDATE Bookings SET Status = ? WHERE BookingId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            cnt = ps.executeUpdate();
            ps.close();
            conn.close();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

    public void deleteBooking(int bookingId) throws SQLException {
        String sql = "DELETE FROM Bookings WHERE BookingId = ?";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            stmt.executeUpdate();
        }
    }

//     Thêm dữ liệu mới vào Bookings
    public void insertBooking(Bookings booking) throws SQLException {
        String sql = "INSERT INTO Bookings (RoomId, CustomerID, UserId, StartDate, EndDate, Status, Notes) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try ( Connection conn = ConnectData.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, booking.getRoomId());
            ps.setInt(2, booking.getCustomerId());
            ps.setInt(3, booking.getUserId());
            ps.setDate(4, java.sql.Date.valueOf(booking.getStartDate()));
            ps.setDate(5, java.sql.Date.valueOf(booking.getEndDate()));

            ps.setString(6, booking.getStatus());
            ps.setString(7, booking.getNotes());

            ps.executeUpdate();
        }
    }

    //vinh
    public List<Bookings> searchBookings(String roomTypeFilter, String fullNameFilter,
            String startDateFilter, String endDateFilter,
            String statusFilter) throws SQLException {
        List<Bookings> list = new ArrayList<>();
        Connection conn = ConnectData.getConnection();

        StringBuilder sql = new StringBuilder(
                "SELECT b.BookingId, b.RoomId, b.CustomerId, b.StartDate, b.EndDate, b.Status, "
                + "b.RoomType, c.FullName "
                + "FROM Bookings b "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (roomTypeFilter != null && !roomTypeFilter.trim().isEmpty()) {
            sql.append(" AND b.RoomType LIKE ? ");
            params.add("%" + roomTypeFilter.trim() + "%");
        }

        if (fullNameFilter != null && !fullNameFilter.trim().isEmpty()) {
            sql.append(" AND c.FullName LIKE ? ");
            params.add("%" + fullNameFilter.trim() + "%");
        }

        if (startDateFilter != null && !startDateFilter.isEmpty()) {
            sql.append(" AND b.StartDate >= ? ");
            params.add(Date.valueOf(startDateFilter));
        }

        if (endDateFilter != null && !endDateFilter.isEmpty()) {
            sql.append(" AND b.EndDate <= ? ");
            params.add(Date.valueOf(endDateFilter));
        }

        if (statusFilter != null && !statusFilter.equals("-- All --")) {
            sql.append(" AND b.Status = ? ");
            params.add(statusFilter);
        }

        PreparedStatement ps = conn.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        ResultSet rs = ps.executeQuery();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        while (rs.next()) {
            Bookings booking = new Bookings();
            booking.setBookingId(rs.getInt("BookingId"));

            java.sql.Date startDateSql = rs.getDate("StartDate");
            if (startDateSql != null) {
                LocalDate startDate = startDateSql.toLocalDate();
                booking.setStartDate(startDate);
                booking.setFormattedStartDate(startDate.format(formatter));
            }

            java.sql.Date endDateSql = rs.getDate("EndDate");
            if (endDateSql != null) {
                LocalDate endDate = endDateSql.toLocalDate();
                booking.setEndDate(endDate);
                booking.setFormattedEndDate(endDate.format(formatter));
            }

            booking.setStatus(rs.getString("Status"));

            String roomType = rs.getString("RoomType");
            if (roomType == null || roomType.trim().isEmpty()) {
                roomType = "Chưa gán phòng";
            }
            booking.setRoomType(roomType);

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

    public int updateBookingStatusAndcheckInt(int bookingId, String status) {
        int cnt = 0;
        try {
            Connection conn = ConnectData.getConnection();
            String sql = "UPDATE Bookings SET Status = ? WHERE BookingId = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            cnt = ps.executeUpdate();
            ps.close();
            conn.close();

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return cnt;
    }

    public Bookings getCheckInCheckOutDetails(int id) {
        Bookings booked = new Bookings();

        try {
            Connection conn = ConnectData.getConnection();

            String sql = "SELECT b.BookingId, b.RoomId, b.CustomerId, b.UserId, b.StartDate, b.EndDate, "
                    + "b.Status, b.CheckInTime, b.CheckOutTime, b.ConfirmationTime, "
                    + "c.FullName, c.Email, c.Phone, r.RoomNumber "
                    + "FROM Bookings b "
                    + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                    + "JOIN Rooms r ON b.RoomId = r.RoomId "
                    + "WHERE b.BookingId =? ";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bookings booking = new Bookings();
                booking.setBookingId(rs.getInt("BookingId"));
                booking.setRoomId(rs.getInt("RoomId"));
                booking.setCustomerId(rs.getInt("CustomerId"));
                booking.setUserId(rs.getInt("UserId"));
                booking.setStartDate(rs.getDate("StartDate").toLocalDate());
                booking.setEndDate(rs.getDate("EndDate").toLocalDate());

                booking.setStatus(rs.getString("Status"));
                booking.setCheckInTime(rs.getTimestamp("CheckInTime").toLocalDateTime());
                booking.setCheckOutTime(rs.getTimestamp("CheckOutTime").toLocalDateTime());
                booking.setConfirmationTime(rs.getTimestamp("ConfirmationTime").toLocalDateTime());

                Customers customer = new Customers();
                customer.setFullName(rs.getString("FullName"));
                customer.setEmail(rs.getString("Email"));
                customer.setPhone(rs.getString("Phone"));
                booking.setCustomers(customer);

                Rooms room = new Rooms();
                room.setRoomNumber(rs.getString("RoomNumber"));
                booking.setRooms(room);

            }

        } catch (SQLException ex) {
            Logger.getLogger(BookingDao.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return booked;

    }

    public Bookings getBookingById(int id) {
        Bookings b = null;
        String sql = "SELECT b.BookingID, b.Status, b.StartDate, b.EndDate, b.CheckInTime, b.CheckOutTime, "
                + "r.RoomNumber, c.FullName, c.Email, c.Phone "
                + "FROM Bookings b "
                + "JOIN Rooms r ON b.RoomID = r.RoomID "
                + "JOIN Customers c ON b.CustomerID = c.CustomerID "
                + "WHERE b.BookingID = ?";

        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                b = new Bookings();
                b.setBookingId(rs.getInt("BookingID"));
                b.setStatus(rs.getString("Status"));
                b.setStartDate(rs.getDate("StartDate").toLocalDate());
                b.setEndDate(rs.getDate("EndDate").toLocalDate());

                b.setCheckInTime(rs.getTimestamp("CheckInTime").toLocalDateTime());
                b.setCheckOutTime(rs.getTimestamp("CheckOutTime").toLocalDateTime());

                // Room
                Rooms r = new Rooms();
                r.setRoomNumber(rs.getString("RoomNumber"));
                b.setRooms(r);

                // Customer
                Customers c = new Customers();
                c.setFullName(rs.getString("FullName"));
                c.setEmail(rs.getString("Email"));
                c.setPhone(rs.getString("Phone"));
                b.setCustomers(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return b;
    }

    //vinh   
    public Bookings getBookingInfoForConfirmation(int bookingId) throws SQLException {
        String sql = "SELECT b.BookingId, b.StartDate, b.EndDate, b.RoomId, b.ConfirmationTime, "
                + "       b.RoomType, " // Lấy RoomType từ bảng Bookings
                + "       c.FullName, c.Email "
                + "FROM Bookings b "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.BookingId = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bookings info = new Bookings();
                info.setBookingId(rs.getInt("BookingId"));

                if (rs.getDate("StartDate") != null) {
                    info.setStartDate(rs.getDate("StartDate").toLocalDate());
                }
                if (rs.getDate("EndDate") != null) {
                    info.setEndDate(rs.getDate("EndDate").toLocalDate());
                }

                if (rs.getTimestamp("ConfirmationTime") != null) {
                    info.setConfirmationTime(rs.getTimestamp("ConfirmationTime").toLocalDateTime());
                }

                // Gán khách
                Customers customer = new Customers();
                customer.setFullName(rs.getString("FullName"));
                customer.setEmail(rs.getString("Email"));
                info.setCustomers(customer);

                // Gán loại phòng
                Rooms room = new Rooms();
                room.setRoomType(rs.getString("RoomType")); // luôn có vì lấy từ bảng Bookings
                info.setRooms(room);

                return info;
            }
        }

        return null;
    }

    //vinh
    public Bookings getBookingInfoForCancellation(int bookingId) throws SQLException {
        String sql = "SELECT b.BookingId, b.StartDate, b.EndDate, b.Notes, "
                + "       r.RoomType, "
                + "       c.FullName, c.Email "
                + "FROM Bookings b "
                + "LEFT JOIN Rooms r ON b.RoomId = r.RoomId "
                + "JOIN Customers c ON b.CustomerId = c.CustomerId "
                + "WHERE b.BookingId = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Bookings info = new Bookings();
                info.setBookingId(rs.getInt("BookingId"));

                if (rs.getDate("StartDate") != null) {
                    info.setStartDate(rs.getDate("StartDate").toLocalDate());
                }

                if (rs.getDate("EndDate") != null) {
                    info.setEndDate(rs.getDate("EndDate").toLocalDate());
                }

                String notes = rs.getString("Notes");
                info.setNotes(notes != null ? notes : "Do not have");

                String roomType = rs.getString("RoomType");
                if (roomType == null) {
                    roomType = "Room not assigned yet";
                }
                info.setRoomType(roomType);

                Customers customer = new Customers();
                customer.setFullName(rs.getString("FullName"));
                customer.setEmail(rs.getString("Email"));
                info.setCustomers(customer);

                return info;
            }
        }

        return null;
    }

//vinh
    public String getBookingStatus(int bookingId) throws SQLException {
        String sql
                = "SELECT Status FROM Bookings WHERE BookingId = ?";

        try ( PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("Status");
            }
        }

        return null; // Không tìm thấy booking
    }

    //vinh deskbooking
    public int insertBookingAndReturnId(Bookings booking) throws SQLException {
        String sql = "INSERT INTO Bookings (RoomId, CustomerID, StartDate, EndDate, Status, RequestTime, ConfirmationTime, ConfirmedBy) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try ( PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, booking.getRoomId());
            ps.setInt(2, booking.getCustomerId());
            ps.setDate(3, Date.valueOf(booking.getStartDate()));
            ps.setDate(4, Date.valueOf(booking.getEndDate()));
            ps.setString(5, booking.getStatus());
            ps.setTimestamp(6, Timestamp.valueOf(booking.getRequestTime()));
            ps.setTimestamp(7, Timestamp.valueOf(booking.getConfirmationTime()));
            ps.setInt(8, booking.getConfirmedBy());

            int affected = ps.executeUpdate();
            if (affected == 0) {
                throw new SQLException("Không thể tạo booking.");
            }

            try ( ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Trả lại bookingId
                } else {
                    throw new SQLException("Không lấy được bookingId.");
                }
            }
        }
    }

}
